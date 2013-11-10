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
        },
    },
    "get_comparison_data()",
);

done_testing;
