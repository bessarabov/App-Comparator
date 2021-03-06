use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    if (!eval q{ use Test::Differences; 1 }) {
        *eq_or_diff = \&is_deeply;
    }
}

require 'bin/comparator';

my $got = get_comparison_data('Test::Whitespaces');

eq_or_diff(
    $got,
    {
        'Test::Whitespaces' => {
            distribution_name => {
                title => 'Name',
                value => 'Test::Whitespaces',
                sort => sub { "DUMMY" },
            },
            last_release_author_name => {
                title => 'Releaser',
                value => 'BESSARABV',
                sort => sub { "DUMMY" },
            },
            last_release_date => {
                title => 'Latest release date',
                value => '2013-08-12',
                sort => sub { "DUMMY" },
            },
            last_release_version => {
                title => 'Latest release version',
                value => '1.2.1',
                sort => sub { "DUMMY" },
            },
            last_release_tests_fail => {
                title => 'fail',
                value => 0,
                sort => sub { "DUMMY" },
            },
            last_release_tests_na => {
                title => 'na',
                value => 0,
                sort => sub { "DUMMY" },
            },
            last_release_tests_pass => {
                title => 'pass',
                value => 315,
                sort => sub { "DUMMY" },
            },
            last_release_tests_unknown => {
                title => 'unknown',
                value => 0,
                sort => sub { "DUMMY" },
            },
            number_of_releases => {
                title => '# releases',
                value => 9,
                sort => sub { "DUMMY" },
            }
        },

    },
    "get_comparison_data()",
);

done_testing;
