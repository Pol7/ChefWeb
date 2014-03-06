#!/usr/bin/perl
# Script che crea un form HTML
print "Content-type: text/html\n\n";
print <<EOF;
<html>
	<head><title>Form di inserimento</title></head>
<body>
<form action="elabora.cgi" method="get">
Nome: <input type="text" name="Nome">
Cognome: <input type="text" name="Cognome">
<input type="submit" name="Invio" value="Invia">
</form>
</body></html>
EOF
exit;