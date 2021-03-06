package App::Comparator::Distribution;

=head1 DESCRIPTION

Class representing a CPAN Distribution.

    my $d = App::Comparator::Distribution->new(
        distribution => 'Test::Whitespaces',
    );

    my @releses = $d->get_releases();

The @releses will contaion something like:

    [
        {
            version => '0.01',
            author => 'BESSARABV',
            date => '2013-01-24',
        },
        ...
        {
            version => '1.2.1',
            author => 'BESSARABV',
            date => '2013-08-12',
        },
    ]


=cut

use strict;
use warnings FATAL => 'all';
use feature 'say';
use utf8;
use open qw(:std :utf8);

use Carp;
use LWP::Simple qw(get);
use JSON;
use URI;

my $true = 1;
my $false = '';

=head1 new

=cut

sub new {
    my ($class, %params) = @_;

    my $self = {};
    bless $self, $class;

    croak "Expected 'distribution'" if not defined $params{distribution};
    $self->{_distribution} = $params{distribution};

    $self->{_name} = $self->{_distribution};
    $self->{_name} =~ s{::}{-}g;

    my $uri = URI->new("http://api.metacpan.org");
    $uri->path("/v0/release/_search");
    $uri->query_form(
        q => "distribution:" . $self->{_name},
        fields => "version,author,date,tests",
        sort => 'date',
        size => 5000,
    );

    $self->{_url} = $uri->as_string();

    my $json = get($self->{_url});
    my $data = decode_json $json;

    my @releases;
    foreach my $element (@{ $data->{hits}->{hits} }) {
        push @releases, {
            version => $element->{fields}->{version},
            author => $element->{fields}->{author},
            date => substr($element->{fields}->{date}, 0, 10),
            tests_fail => ($element->{fields}->{tests}->{fail} // 0),
            tests_na => ($element->{fields}->{tests}->{na} // 0),
            tests_pass => ($element->{fields}->{tests}->{pass} // 0),
            tests_unknown => ($element->{fields}->{tests}->{unknown} // 0),
        };
    }

    $self->{_releases} = \@releases;

    return $self;
}

=head1 get_releases

    my @releases = $d->get_releases();

=cut

sub get_releases {
    my ($self) = @_;

    return @{ $self->{_releases} };
}

=head1 get_latest_release

Returnes the last element from the array that return get_releases() method.

    my $relese = $d->get_latest_release();

=cut

sub get_latest_release {
    my ($self) = @_;

    return $self->{_releases}->[-1];
}

1;
