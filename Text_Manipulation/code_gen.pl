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

my @consts;
# file name
my $name = <>;
die "Invalid format - missing name" unless defined ($name);
chomp $name;

# Read in the rest of the file
while (<>) {
	# avoid \n on last field
	chomp;

	# beginning-of-string
	s/^\s*//; 
	# end-of-string
	s/\s*$//;
	die "Invalid line: $_" unless /^(\w+)$/;
	push @consts, $_;
}

# Generate the file
open(HDR, ">$name.h") or die "Can't open $name.h: $!";
open(SRC, ">$name.c") or die "Can't open $name.h: $!";

my $uc_name = uc($name);
my $arrary_name = $uc_name . "_names";

print HDR "/* file generated automatically - do not edit*/ \n";
print HDR "extern const char *${uc_name}_name[]";
print HDR "typedef emu {\n";
print HDR join ", \n", @consts;
print HDR "\n} $uc_name; \n\n";

print SRC "/* File generated automatically - do not edit*/\n";
print SRC "const char *${uc_name}_name[] = {\n \"";
print SRC join "\",\n \"", @consts;
print SRC "\"\n};\n" ;

close(HDR);
close(SRC);


