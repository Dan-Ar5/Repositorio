#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="./../css/styles.css">
    <title>Lista de todas las paginas</title>
  </head>
  <body>
  <h1>Mis paginas de wikipedia</h1>
HTML

#Database part
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.108";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");;

my $sth = $dbh->prepare("SELECT name FROM Wiki");
$sth->execute();
print "<ul>\n";
while(my @row = $sth->fetchrow_array){
    print "<li>\n";
      print "<a href='view.pl?name=@row'>@row</a>\n";
      print "<a href='delete.pl?name=@row' class='delete-button'>X</a>\n";
      print "<a href='edit.pl?name=@row' class='edit-button'>E</a>\n";
    print "</li>\n";
}
print "</ul>\n";
$sth->finish;
$dbh->disconnect;

print <<HTML;
    <a href="./../new.html">nueva pagina</a><br>
    <a href="./../index.html">volver al inicio</a>
  </body>
</html>
HTML
