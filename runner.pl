# runner.pl
use strict;
use warnings;
$| = 1;
my @scripts = ('normalize-apostrophe-batch.pl corpus', 'batch-tokenize.pl -e corpus', 'apply-treetaggertaglem-batchv1.1.pl corpus english-utf8.par', 'TT2taglemma4lca.pl corpus', 'replace-SENT-.-batch.pl corpus');
for my $scr (@scripts) {
    my $cmd = "$^X $scr";
    print "Run '$cmd'...";
    my $out = qx{$cmd};
    my $rc = $? >> 8;
    print "rc=$rc\n";
    print "Output:$out\n";
    if ($rc != 0) {
        print "Main script $0 exit $rc\n";
        exit $rc;
    }
}
print "All commands finished successfully.\n";
