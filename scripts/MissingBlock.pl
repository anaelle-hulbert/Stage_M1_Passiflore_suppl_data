# Paul simion
# 30/09/2013
# Objectif: Ouvrir un alignement, compter les "-" et les "?" dans une colonne et supprimer la colonne si trop de donn�es manquantes/inconnues 															
#															

# Usage: 2 arguments
# perl MissingBlock.pl input_fasta %max_missing
# exemple: for f in *.fasta; do perl MissingBlock.pl $f 50; done

#! /usr/bin/env perl

use strict;
use warnings;
use lib '/home/paul/0_Paul/Programmation/scripts_perl_Paul';

#d�claration des variables
my @ali = ();
my @matrix = ();
my $line = '';
my $total_taxon = '';
my $position_max = '';
my $tmp_count = 0;
my %MissingData = ();
my @alignement = ();
my $nb_suppression = 0;

# v�rification ouverture script
print "Matrice name : $ARGV[0]\nMax missing data : $ARGV[1] %"; 

### ouverture fichier 
open (INFILE,$ARGV[0]) or die "\nImpossible d'ouvrir le fichier $ARGV[0]";
@ali = <INFILE>;
close (INFILE);

# si la ligne ne commence pas par un ">" (= est une s�quence), elle devient une ligne de la matrice

foreach my $line (@ali) {
	if ( $line =~ /^[^>]/ ) {
 		my @tmp_line = split ('', $line); 
 		push (@matrix, [@tmp_line]);
		#print "\ndebut de la sequence initiale        : ", substr($line, 0, 150); 		# permet d'afficher une partie de chaque sequence
	}
}

# sauvegardes du nombre de taxon total et du nombre de position de l'alignement:

$total_taxon = $#matrix;
for (my $x = 0; $x <= "$#matrix"; $x++) {
	$position_max = "$#{$matrix[$x]}";
}
print "\nAlignment length = $position_max";


# affiche la colonne deux de la matrice (juste pour rigoler)
# $#matrix ==> nombre de lignes
# $#{@matrix[$x]} ==> nombre de positions
# $matrix[$x][1] ==> colonne 2
# $matrix[1][$y] ==> ligne 2 (une s�quence quoi)

#print "\ncolonne 2\n"; 
#for (my $x = 0; $x <= "$#matrix"; $x++) {
#	print "taxon $x", "==>", $matrix[$x][1], "\n";
#}


# pour chaque ligne on regarde la position X. On regroupe ces positions X, et on fait le calcul dessus. 
# position et r�sultats de calcul (=ratio de missing data) deviennent un hachage

for (my $position = 0; $position < $position_max; $position++) {				# pour chaque position
	$tmp_count = 0;																# on part de count = 0
	for (my $x = 0; $x <= "$#matrix"; $x++) {   								# on parcours la valeur de cette position pour chaque ligne
		if ($matrix[$x][$position] =~ /[-?\*X]/) { $tmp_count++; }					# si manquant, count++
	}
	my $missing = ($tmp_count*100)/$total_taxon;								# on divise par le nombre total de taxon
	$MissingData{$position} = $missing;											# on attribut la valeur obtenu � la cl� (=position) du hachage
	#print "position ", $position+1, "   ratio missing data = ", $missing, "\n";
}

# on parcourt le hachage pour supprimer toutes les cl�s (=positions) dont la valeurs (= % de missing data) est sup�rieur � ARGV[1]

foreach my $position (keys(%MissingData)) {								# pour chaque position ,
	#print 'key : ',$position,' valeur ', $MissingData{$position},"\n";	   # affiche tous les couples cl�/valeur (juste pour rigoler)
	if ( $MissingData{$position} > $ARGV[1] ) {							# si sa valeur est inf�rieur au seuil donn�,
		delete ( $MissingData{$position});								# on la supprime du hachage
		$nb_suppression++;
	}
}
print "\nRemoved positions = $nb_suppression";
print "\nFinal alignment length = ",($position_max-$nb_suppression);

# pour chaque ligne de la matrice, on parcourt toutes les positions
# si la position existe (en tant que cl�) dans le hachage, on r�-�crit le caract�re. Sinon non.
# la chaine de caract�res r�sultante (=sequence) est ajouter � un tableau @alignement.

for (my $x = 0; $x <= "$#matrix"; $x++) { 										#pour chaque taxon (ligne de la matrice), on fera :
	my $tmp_seq = '';															# sequence par de rien
	for (my $position = 0; $position < $position_max; $position++) {			# on parcourt la sequence (chaque colonne est vue successivement)
		if ( exists ($MissingData{$position})) {								# si la position existe dans le hachage %MissingData
			$tmp_seq = $tmp_seq.$matrix[$x][$position];							# on augmente la sequence avec le caractere correspondant dans la matrice
			#print "\n", 'position ',$position,' tmp_seq ',$tmp_seq, ' X ', $x;
		}
	}	 
	push (@alignement, $tmp_seq);												# la s�quence complete est ajout� au tableau @alignement
	#print "\n", 'debut de la sequence clean (taxon ',$x,') : ', substr ($tmp_seq,0, 150);
}

# on �crit en sortie un alignement sans les colonnes avec trop de donn�es manquantes
# les noms de taxons sont intercal�s par les valeurs du tableau @alignement.

open (ALI_OUT, ">$ARGV[0]"."_MB"."$ARGV[1]");
foreach my $line (@ali) {								# on parcourt les lignes du fichier fasta original
	if ( $line =~ /^>/ ) {								# si c'est un nom de taxon
		my $seq = shift (@alignement);						# on retire le premier element de @alignement
		print ALI_OUT $line, $seq ,"\n";			# on ecrit le nom du taxon puis le premier element de @alignement
	}
}
	
# fin explicite
exit;
