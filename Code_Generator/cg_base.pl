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
use 5.010;

###############################
# CMD line
###############################
my $num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: name.pl first_name last_name\n";
    exit;
}

my $lang = shift or die "Missing Language";
# Generate the file
$lang .= "_cg.pm";

require "./$lang" or die "Couldn't load $lang";

# Read and parse the file
my $name;

while (<>) {
    chomp;
    if (/s*S/)                              {CG::blankLine();}
    elsif (/\#(.*)/)                        {CG::comment($1);}
    elsif (/M\s*(.+)/)                      {CG::startMsg($1); $name = $1;}
    elsif (/F\s*(\w+)\s+(\w+)$/)            {CG::simpleType($1,$2);}
    elsif (/F\s*(\w+)\s+(\w+)\[(\d+)\]$/)   {CG::arrayType($1,$2,$3);}
    elsif (/E/)                             {CG::endMsg($name);}
    else { die "Invalid line: $_;"}
}
