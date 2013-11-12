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
            },
            last_release_author_name => {
              title => 'Releaser',
              value => 'BESSARABV'
            },
            last_release_date => {
              title => 'Latest release date',
              value => '2013-08-12'
            },
            last_release_version => {
              title => 'Latest release date',
              value => '1.2.1'
            },
            number_of_releases => {
              title => '# releases',
              value => 9
            }
        },

    },
    "get_comparison_data()",
);

done_testing;
