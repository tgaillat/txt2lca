# nomalize apostrophe hex 0092 in text into normal asicc apostrophe

use strict;
use locale;

if ( $#ARGV != 0 ) {
    die "Usage : ", $0, " argument corpus manquant\n";
}

my $repertoire = $ARGV[0];

# multi-file processing in one folder
opendir ( REP, $repertoire ) or 
    die "Impossible d'ouvrir ", $repertoire, " : ", $!, "\n";
my @fichiers = grep( /\.*.txt$/, readdir(REP) );
closedir ( REP );

foreach my $fichier  ( sort @fichiers) {
 
	my $r = $fichier ;
	$r =~ s/^(.*)\.txt$/$1.txtn/;

	print STDERR $r, "\n";
   
	open ( ENTREE, "<", $repertoire."/".$fichier) or 
		warn "Erreur d'ouverture de ",$fichier, " :" ,$!, "\n";
	open(SORTIE,">", $repertoire."/".$r) or die "impossible d'ouvrir ", $r;
	

while( my $ligne = <ENTREE> ){
    $ligne =~ s/â€™/\'/g;
    $ligne =~ s/’/\'/g;

    
    
    
    print SORTIE $ligne;
}

    close(SORTIE);
    close(ENTREE);
}