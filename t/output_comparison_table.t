use strict;
use warnings FATAL => 'all';
use Test::More;
use Capture::Tiny qw(capture_merged);

BEGIN {
    if (!eval q{ use Test::Differences; 1 }) {
        *eq_or_diff = \&is_deeply;
    }
}

require 'bin/comparator';

my $output = capture_merged {

    output_comparison_table(
        data => {
            'Test::Whitespaces' => {
                distribution_name => {
                    title => 'Name',
                    value => 'Test::Whitespaces',
                },
            },
        },
        output => [
            'distribution_name',
        ],
    );

};

eq_or_diff(
    $output,
    'Name
Test::White-
',
    "get_comparison_data()",
);

done_testing;
