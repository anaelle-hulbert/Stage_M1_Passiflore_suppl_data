########## Reconstruction étatx ancestraux ##########
##########       Stage M1 Passiflore       ##########

#Répertoire de travail
setwd("C:/Users/anael/OneDrive/Documents/Fac/master/S8/stage/Passiflore/R")

# install packages
install.packages(c('ape', 'maps', 'phytools', 'geiger', 'splines','ggtree'))

# load packages
library(ape)
library(maps)
library(phytools)
library(phangorn)
library(geiger)
library(splines)
library(ggtree)
library(dplyr)

##### importation matrice #####
m_rbcl<-read.table ("matrice_caractere_rbcl.txt" ,header = TRUE)
m_genome<-read.table ("matrice_caractere_genome.txt" ,header = TRUE)

########## RBCL ##########
### importation arbre ###
windows()

tree_rbcl<-read.tree(file="C:/Users/anael/OneDrive/Documents/Fac/master/S8/stage/Passiflore/R/tree_rbcl_unique_modif_filtered_divvy.GTR+R6+F.100boots.treefile") #télécharge un fichier tre
plotTree(tree_rbcl) #Affichage arbre
nodelabels(tree_rbcl$node.label, adj=0, frame="n")
is.rooted(tree_rbcl)#False
tree_rbcl_rooted$tip.label[26]<-"Passiflora_sexflora_OP710465"


tree_rbcl_rooted<-root(tree_rbcl, "Plagiopteron_suaveolens_FJ670182", resolve.root = TRUE)
is.rooted(tree_rbcl_rooted)#True
plotTree(tree_rbcl_rooted, fsize=0.35)
nodelabels(tree_rbcl_rooted$node.label, adj=0, frame="n", cex=0.35)
tree_rbcl_rooted$tip.label[26]<-"Passiflora_sexflora_OP710465"

##### couleur #####
couleur<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      couleur[i]<-m_rbcl$couleur[y]
    }
  }
}

for (i in 1:171){
  if (is.na(couleur[i])) {
    couleur[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_couleur_ER<-ace(couleur, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","lightgreen","blue","red","yellow")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd=0.35)
tiplabels(pie=to.matrix(couleur,sort(unique(couleur))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_couleur_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","blanc/vert","violet/bleu","rose/rouge","jaune/orange"), colors=col,fsize=0.4)
title("rbcl_couleur_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_couleur_ARD<-ace(couleur, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","lightgreen","blue","red","yellow")

plotTree(tree_rbcl_rooted, fsize=0.35, mwd =0.35)
tiplabels(pie=to.matrix(couleur,sort(unique(couleur))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_couleur_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","blanc/vert","violet/bleu","rose/rouge","jaune/orange"), colors=col,fsize=0.4)
title("rbcl_couleur_ARD")


##### Inflorescence #####
inflo<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      inflo[i]<-m_rbcl$inflorescence[y]
    }
  }
}

for (i in 1:171){
  if (is.na(inflo[i])){
    inflo[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_inflo_ER<-ace(inflo, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(inflo,sort(unique(inflo))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_inflo_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","solitaire","groupée"), colors=col,fsize=0.4)
title("rbcl_inflo_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_inflo_ARD<-ace(inflo, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd=0.35)
tiplabels(pie=to.matrix(inflo,sort(unique(inflo))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_inflo_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","solitaire","groupée"), colors=col,fsize=0.4)
title("rbcl_inflo_ARD")


##### Taille #####
taille<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      taille[i]<-m_rbcl$taille[y]
    }
  }
}

for (i in 1:171){
  if (is.na(taille[i])) {
    taille[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_taille_ER<-ace(taille, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(taille,sort(unique(taille))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_taille_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","petite","grande"), colors=col,fsize=0.4)
title("rbcl_taille_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_taille_ARD<-ace(taille, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd=0.35)
tiplabels(pie=to.matrix(taille,sort(unique(taille))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_taille_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","petite","grande"), colors=col,fsize=0.4)
title("rbcl_taille_ARD")



##### Forme #####
forme<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      forme[i]<-m_rbcl$forme[y]
    }
  }
}

for (i in 1:171){
  if (is.na(forme[i])) {
    forme[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_forme_ER<-ace(forme, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(forme,sort(unique(forme))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_forme_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","campanulée","tube"), colors=col,fsize=0.4)
title("rbcl_forme_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_forme_ARD<-ace(forme, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd = 0.35)
tiplabels(pie=to.matrix(forme,sort(unique(forme))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_forme_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("white","campanulée","tube"), colors=col,fsize=0.4)
title("rbcl_forme_ARD")

##### Motif #####
motif<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      motif[i]<-m_rbcl$motif[y]
    }
  }
}

for (i in 1:171){
  if (is.na(motif[i])) {
    motif[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_motif_ER<-ace(motif, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(motif,sort(unique(motif))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_motif_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","uni","concentrique"), colors=col,fsize=0.4)
title("rbcl_motif_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_motif_ARD<-ace(motif, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd=0.35)
tiplabels(pie=to.matrix(motif,sort(unique(motif))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_motif_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","uni","concentrique"), colors=col,fsize=0.4)
title("rbcl_motif_ARD")


##### Nombre serie #####
nb_filet<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      nb_filet[i]<-m_rbcl$nombre_serie[y]
    }
  }
}

for (i in 1:171){
  if (is.na(nb_filet[i])) {
    nb_filet[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_nbserie_ER<-ace(nb_filet, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(nb_filet,sort(unique(nb_filet))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_nbserie_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","1 à 5","6 et +"), colors=col,fsize=0.4)
title("rbcl_nb_serie_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_nbserie_ARD<-ace(nb_filet, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd=0.35)
tiplabels(pie=to.matrix(nb_filet,sort(unique(nb_filet))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_nbserie_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","1 à 5","6 et +"), colors=col,fsize=0.4)
title("rbcl_nb_serie_ARD")


##### Longueur filet #####
lg_filet<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      lg_filet[i]<-m_rbcl$longueur_filet[y]
    }
  }
}

for (i in 1:171){
  if (is.na(lg_filet[i])) {
    lg_filet[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_lgfilet_ER<-ace(lg_filet, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(lg_filet,sort(unique(lg_filet))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_lgfilet_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","courts","longs"), colors=col,fsize=0.4)
title("rbcl_lg_filet_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_lgfilet_ARD<-ace(lg_filet, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_rbcl_rooted, fsize=0.35, lwd=0.35)
tiplabels(pie=to.matrix(lg_filet,sort(unique(lg_filet))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_lgfilet_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","courts","longs"), colors=col,fsize=0.4)
title("rbcl_lg_filet_ARD")


##### syndrome #####
syndrome<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_rooted$tip.label[i]==m_rbcl$label[y]){
      syndrome[i]<-m_rbcl$syndrome[y]
    }
  }
}

for (i in 1:171){
  if (is.na(syndrome[i])) {
    syndrome[i]<-"?"
  }
}

### ER ###
tree_rbcl_rooted$node.label<-c()
reconstruction_syndrome_ER<-ace(syndrome, tree_rbcl_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","blue","yellow","red","lightgreen")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(syndrome,sort(unique(syndrome))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_syndrome_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","abeille","guepe","colibri","chauve-souris"), colors=col,fsize=0.4)
title("rbcl_syndrome_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_couleur_ARD<-ace(syndrome, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","blue","yellow","red","lightgreen")

plotTree(tree_rbcl_rooted, fsize=0.4)
tiplabels(pie=to.matrix(syndrome,sort(unique(syndrome))),piecol=col,cex=0.1)
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_syndrome_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","abeille","guepe","colibri","chauve-souris"), colors=col,fsize=0.4)
title("rbcl_syndrome_ARD")


########## Genome ##########
### importation arbre ###
windows()

tree_genome<-read.tree(file="C:/Users/anael/OneDrive/Documents/Fac/master/S8/stage/Passiflore/R/tree_genome_unique_MB50.GTR+R6+F.100boots.treefile") #télécharge un fichier tre
plotTree(tree_genome, fsize=0.5, lwd=0.35) #Affichage arbre
nodelabels(tree_genome$node.label, adj=0, frame="n")
is.rooted(tree_genome)#False


tree_genome_rooted<-root(tree_genome, "plagiopteron_suaveolens_NC_065726P", resolve.root = TRUE)
is.rooted(tree_genome_rooted)#True
plotTree(tree_genome_rooted)
nodelabels(tree_genome_rooted$node.label, adj=0, frame="n")


##### couleur #####
couleur<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      couleur[i]<-m_genome$couleur[y]
    }
  }
}

for (i in 1:70){
  if (is.na(couleur[i])) {
    couleur[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_couleur_ER<-ace(couleur, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("lightgreen","blue","red","yellow")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(couleur,sort(unique(couleur))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_couleur_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("blanc/vert","violet/bleu","rose/rouge","jaune/orange"), colors=col,fsize=0.4)
title("genome_couleur_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_couleur_ARD<-ace(couleur, tree_rbcl_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("lightgreen","blue","red","yellow")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(couleur,sort(unique(couleur))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_couleur_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("blanc/vert","violet/bleu","rose/rouge","jaune/orange"), colors=col,fsize=0.4)
title("genome_couleur_ARD")


##### Inflorescence #####
inflo<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      inflo[i]<-m_genome$inflorescence[y]
    }
  }
}

for (i in 1:70){
  if (is.na(inflo[i])){
    inflo[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_inflo_ER<-ace(inflo, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(inflo,sort(unique(inflo))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_inflo_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","solitaire","groupée"), colors=col,fsize=0.4)
title("genome_inflo_ER")

### ARD ###
tree_genome_rooted$node.label<-c()
reconstruction_inflo_ARD<-ace(inflo, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(inflo,sort(unique(inflo))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_inflo_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","solitaire","groupée"), colors=col,fsize=0.4)
title("genome_inflo_ARD")


##### Taille #####
taille<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      taille[i]<-m_genome$taille[y]
    }
  }
}

for (i in 1:70){
  if (is.na(taille[i])) {
    taille[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_taille_ER<-ace(taille, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(taille,sort(unique(taille))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_taille_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("petite","grande"), colors=col,fsize=0.4)
title("genome_taille_ER")

### ARD ###
tree_genome_rooted$node.label<-c()
reconstruction_taille_ARD<-ace(taille, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(taille,sort(unique(taille))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_taille_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("petite","grande"), colors=col,fsize=0.4)
title("genome_taille_ARD")



##### Forme #####
forme<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      forme[i]<-m_rbcl$forme[y]
    }
  }
}

for (i in 1:70){
  if (is.na(forme[i])) {
    forme[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_forme_ER<-ace(forme, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(forme,sort(unique(forme))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_forme_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("campanulée","tube"), colors=col,fsize=0.4)
title("genome_forme_ER")

### ARD ###
tree_rbcl_rooted$node.label<-c()
reconstruction_forme_ARD<-ace(forme, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(forme,sort(unique(forme))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_forme_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("campanulée","tube"), colors=col,fsize=0.4)
title("genome_forme_ARD")

##### Motif #####
motif<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      motif[i]<-m_genome$motif[y]
    }
  }
}

for (i in 1:70){
  if (is.na(motif[i])) {
    motif[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_motif_ER<-ace(motif, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(motif,sort(unique(motif))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_motif_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("uni","concentrique"), colors=col,fsize=0.4)
title("genome_motif_ER")

### ARD ###
tree_genome_rooted$node.label<-c()
reconstruction_motif_ARD<-ace(motif, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(motif,sort(unique(motif))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_motif_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("uni","concentrique"), colors=col,fsize=0.4)
title("genome_motif_ARD")


##### Nombre serie #####
nb_filet<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      nb_filet[i]<-m_genome$nombre_serie[y]
    }
  }
}

for (i in 1:70){
  if (is.na(nb_filet[i])) {
    nb_filet[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_nbserie_ER<-ace(nb_filet, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(nb_filet,sort(unique(nb_filet))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_nbserie_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","1 à 5","6 et +"), colors=col,fsize=0.4)
title("genome_nb_serie_ER")

### ARD ###
tree_genome_rooted$node.label<-c()
reconstruction_nbserie_ARD<-ace(nb_filet, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(nb_filet,sort(unique(nb_filet))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_nbserie_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","1 à 5","6 et +"), colors=col,fsize=0.4)
title("genome_nb_serie_ARD")


##### Longueur filet #####
lg_filet<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      lg_filet[i]<-m_genome$longueur_filet[y]
    }
  }
}

for (i in 1:171){
  if (is.na(lg_filet[i])) {
    lg_filet[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_lgfilet_ER<-ace(lg_filet, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(lg_filet,sort(unique(lg_filet))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_lgfilet_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","courts","longs"), colors=col,fsize=0.4)
title("genome_lg_filet_ER")

### ARD ###
tree_genome_rooted$node.label<-c()
reconstruction_lgfilet_ARD<-ace(lg_filet, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","darkgrey","black")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(lg_filet,sort(unique(lg_filet))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_lgfilet_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","courts","longs"), colors=col,fsize=0.4)
title("genome_lg_filet_ARD")


##### syndrome #####
syndrome<-c()
for (i in 1:70){
  for (y in 1:70){
    if (tree_genome_rooted$tip.label[i]==m_genome$label[y]){
      syndrome[i]<-m_genome$syndrome[y]
    }
  }
}

for (i in 1:70){
  if (is.na(syndrome[i])) {
    syndrome[i]<-"?"
  }
}

### ER ###
tree_genome_rooted$node.label<-c()
reconstruction_syndrome_ER<-ace(syndrome, tree_genome_rooted, type="discrete", method="ML", model="ER")

#arbre
col<-c("white","blue","yellow","red","lightgreen")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(syndrome,sort(unique(syndrome))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_syndrome_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","abeille","guepe","colibri","chauve-souris"), colors=col,fsize=0.4)
title("genome_syndrome_ER")

### ARD ###
tree_genome_rooted$node.label<-c()
reconstruction_couleur_ARD<-ace(syndrome, tree_genome_rooted, type="discrete", method="ML", model="ARD")

#arbre
col<-c("white","blue","yellow","red","lightgreen")

plotTree(tree_genome_rooted, fsize=0.4)
tiplabels(pie=to.matrix(syndrome,sort(unique(syndrome))),piecol=col,cex=0.1)
nodelabels(node=1:tree_genome_rooted$Nnode+Ntip(tree_genome_rooted),pie=reconstruction_syndrome_ARD$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","abeille","guepe","colibri","chauve-souris"), colors=col,fsize=0.4)
title("genome_syndrome_ARD")




########## Arbres finaux ##########
##### Rbcl syndromes  #####

tree_rbcl_final<-rotateNodes(tree_rbcl_rooted,c(175,176))
plotTree(tree_rbcl_final, fsize=0.35, lwd=0.35)

syndrome<-c()
for (i in 1:171){
  for (y in 1:171){
    if (tree_rbcl_final$tip.label[i]==m_rbcl$label[y]){
      syndrome[i]<-m_rbcl$syndrome[y]
    }
  }
}

for (i in 1:171){
  if (is.na(syndrome[i])) {
    syndrome[i]<-"?"
  }
}

### ER ###
tree_rbcl_final$node.label<-c()
reconstruction_syndrome_ER<-ace(syndrome, tree_rbcl_final, type="discrete", method="ML", model="ER")

#arbre
windows()

col<-c("white","blue","yellow","red","lightgreen")

plotTree(tree_rbcl_final, fsize=0.35, lwd =0.35)
tiplabels(pie=to.matrix(syndrome,sort(unique(syndrome))),piecol=col,cex=0.1, )
nodelabels(node=1:tree_rbcl_rooted$Nnode+Ntip(tree_rbcl_rooted),pie=reconstruction_syndrome_ER$lik.anc,piecol=col,cex=0.1)
add.simmap.legend(leg=c("inconnu","abeille","guepe","colibri","chauve-souris"), colors=col,fsize=0.7)
title("rbcl_syndrome_ER")


cladelabels(tree=tree_rbcl_final, text="Decaloba",node=184, cex=0.7,
            orientation="vertical")
cladelabels(tree=tree_rbcl_final, text="Passiflora",node=230, cex=0.7,
            orientation="vertical")
cladelabels(tree=tree_rbcl_final, text="Astrophea",node=316, cex=0.7,
            orientation="vertical")
cladelabels(tree=tree_rbcl_final, text="Deidamioides",node=332, cex=0.7,orientation="horizontal")


##### Arbre genome boorstraps #####

tree_genome_final<-rotateNodes(tree_genome_rooted,c(73,80))
plotTree(tree_genome_final, fsize=0.5, lwd=0.35)
nodelabels(tree_genome_rooted$node.label, adj=0, frame="n", cex=0.4)

