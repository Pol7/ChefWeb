#!/usr/bin/perl -w
use CGI qw/:standard/;
use strict;
use warnings;

print header(-type=>'text'),
my $result=`sudo -u pi tac /var/log/apache2/error.log`;
print $result;
