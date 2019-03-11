#Author Gaillat Thomas.University of Paris Diderot
#Inspired from Tangy and Hathout http://perl.linguistes.free.fr/
#usage perl TT2seq_feat_3grams.pl directory
# directory is at the same level as the perl programme. It includes texts that have been tokenized an tagged. One lemma and POS tag attached with underscore sign _.
# This script takes TT tagged and lemmatised files and , for each line, places lemma and tags in arrays and then prints $lemma"_"$tag 
#The resulting data can be used with LCA. 

use strict;
use locale;

#multi-file processing in one folder

if ( $#ARGV != 0 ) {
    die "Usage : ", $0, " enter directory name please\n";
}

my $repertoire = $ARGV[0];


opendir ( REP, $repertoire ) or 
    die "Impossible d'ouvrir ", $repertoire, " : ", $!, "\n";
my @fichiers = readdir( REP );
closedir ( REP );

my @fichierstt = grep (/\.tt$/, @fichiers);

foreach my $fichier ( sort @fichierstt ) {
 	my $r = $fichier ;
	$r =~ s/^(.*)\.tt$/$1/;
	print STDERR $r, "\n";
   
	open ( ENTREE, "<", $repertoire."/".$fichier) or 
		warn "Erreur d'ouverture de ",$fichier, " :" ,$!, "\n";
	open(SORTIE, ">", $repertoire."/".$r) or die "impossible d'ouvrir ", $r;

#throw each token tag pair in arrays. 
my (@tokens, @tags, @lemma);

while (my $line = <ENTREE>) {
chomp $line;
        my @array = split ( /\t/, $line );
	push ( @tokens, $array[0] );
	push ( @tags, $array[1] );
	push ( @lemma, $array[2] );
}
for (my $i=0; $i <= $#tokens; $i++){
	print SORTIE  $lemma[$i],"_", $tags[$i]," ";
}
    close(SORTIE);
    close(ENTREE);
}
