#!/usr/bin/env perl
#-----------------#
# PROGRAM:
# File Name    :
# Created By   :
# Created Date :
# Description  :
#-----------------#
use strict;
use warnings;

my $dir = shift or die "Missing directory";

for my $file (glob("$dir/*.pl")) {

    open (IP, "$file") or die "Opening $file: $! ";
    undef $/; # Turn off input record separator

    my $content = <IP>; # Read first line
    close(IP);

    if ($content !~ /^use strict/m) {
        rename $file, "$file.bak" or die "Renaming $file: $!";
        open(OP, ">$file") or die "Create $file: $!";

        $content =~ s/^(?!#)/\nuse strict;\n\n/m;
        print OP $content;
        close(OP);
        print "Updated $file \n";

    } else {
        print "\n $file already strict \n";
    }
}
