#!/usr/bin/perl -T
 
use strict;
use warnings;
use CGI;
use CGI::Carp qw/fatalsToBrowser/;
use File::Basename;
 
# set the maximum limit for file uploads  
$CGI::POST_MAX = 1024 * 5000; #adjust as needed (1024 * 5000 = 5MB)
 
# change to 1 (one) to disable file uploads 
$CGI::DISABLE_UPLOADS = 0; #1 disables uploads, 0 enables uploads
my $safe_filename_characters = "a-zA-Z0-9_.-";
my $upload_dir = "/home/0/2013/apozzato/tecweb/public_html/images/ricette";
my $query = new CGI;
my $filename = $query->param("photo");
my $email_address = $query->param("email_address");
my $tmpfilename = $query->tmpFileName($filename);

if ( !$filename )
{
print $query->header ( );
print "There was a problem uploading your photo (try a smaller file).";
exit;
}

my ( $name, $path, $extension ) = fileparse ( $filename, '..*' );
$filename = $name . $extension;
$filename =~ tr/ /_/;
$filename =~ s/[^$safe_filename_characters]//g;

if ( $filename =~ /^([$safe_filename_characters]+)$/ )
{
$filename = $1;
}
else
{
die "Filename contains invalid characters";
}

my $upload_filehandle = $query->upload("photo");

open ( UPLOADFILE, ">$upload_dir/$filename" ) or die "no open fileee";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
print UPLOADFILE $_;
}

close UPLOADFILE;

print $query->header ( );
print <<END_HTML;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Thanks!</title>
<style type="text/css">
img {border: none;}
</style>
</head>
<body>
<p>Thanks for uploading your photo!</p>
<p>Your email address: $email_address</p>
<p>Your photo:$tmpfilename</p>
<p><img src="../images/ricette/$filename" alt="Photo" /></p>
</body>
</html>
END_HTML
