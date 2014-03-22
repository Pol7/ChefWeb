#!/usr/bin/perl -w
use CGI qw/:standard/;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use strict;
use warnings;

require "../../chefweb.pl";
print header(-type=>'text');
my $result=Sync();
print $result;

