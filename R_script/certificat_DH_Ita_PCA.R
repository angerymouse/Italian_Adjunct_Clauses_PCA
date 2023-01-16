## ---------------------------
##
## Script name: certificat_DH_Ita_PCA
##
## Overview: The script performs a Principal Component
##           Analysis of verbs and prepositional phrases in Italian 
##           adjunct clauses. The data was retrieved from the CORIS corpus
##           available @ https://corpora.ficlit.unibo.it/TCORIS/
##
## Author: Martina Rizzello
##
## Date Created: 2022-12-27
##
## Email: martina.rizzello@unige.ch
##
## ---------------------------
##
## Notes: Portions of this code have been adapted from S. Gabay's
##        "Cours_6" material.
##        @ https://github.com/gabays/32M7129/tree/master/Cours_06
##
## ---------------------------


#set directory
setwd("~/Uni/Certificat DH/PCA/lemmatised")

#download packages
if(!require("stylo")){
  install.packages("stylo")
  library(stylo)
}
if(!require("FactoMineR")){
  install.packages("FactoMineR")
  library(FactoMineR)
}
if(!require("factoextra")){
  install.packages("factoextra")
  library(factoextra)
}


#I load my corpus
DA_2<-paste(scan("da_auxppLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
DA_QUANDO_1<-paste(scan("da_quando_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
DOPO_2<-paste(scan("dopo_auxppLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
FINCHE_1<-paste(scan("finché_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
FINO_A_2<-paste(scan("fino_a_auxppLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
INVECE_DI_1<-paste(scan("invece_di_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
ONDE_1<-paste(scan("onde_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
PER_2<-paste(scan("per_auxppLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
PER_1<-paste(scan("per_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
PERCHE_1<-paste(scan("perché_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
POICHE_1<-paste(scan("poiché_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
PRIMA_CHE_1<-paste(scan("prima_che_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
PRIMA_DI_2<-paste(scan("prima_di_auxppLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")
PRIMA_DI_1<-paste(scan("prima_di_vclitLEMM.txt", what="character", sep="", fileEncoding="UTF-8"),collapse=" ")

#I create a list with my texts
my.corpus.raw = list(DA_2,
                     DA_QUANDO_1,
                     DOPO_2,
                     FINCHE_1,
                     FINO_A_2,
                     INVECE_DI_1,
                     ONDE_1,
                     PER_2,
                     PER_1,
                     PERCHE_1,
                     POICHE_1,
                     PRIMA_CHE_1,
                     PRIMA_DI_2,
                     PRIMA_DI_1)


#I tokenise my corpus
my.corpus.clean = lapply(my.corpus.raw, txt.to.words)

#I calculate the token frequency
complete.word.list = make.frequency.list(my.corpus.clean)

#I make a frequency table
table.of.frequencies=make.table.of.frequencies(my.corpus.clean, complete.word.list, relative = F)

#I rename the columns
row.names(table.of.frequencies)=c("DA_aux_pp",
                                  "DA_QUANDO_v",
                                  "DOPO_aux_pp",
                                  "FINCHE_v",
                                  "FINO_A_aux_pp",
                                  "INVECE_DI_v",
                                  "ONDE_v",
                                  "PER_aux_pp",
                                  "PER_v",
                                  "PERCHE_v",
                                  "POICHE_v",
                                  "PRIMA_CHE_v",
                                  "PRIMA_DI_aux_pp",
                                  "PRIMA_DI_v")

#I save a copy
write.csv(table.of.frequencies, file = "table.of.frequencies.csv",row.names=TRUE)

#I convert the data to a dataframe
table.of.frequencies = as.data.frame(read.csv(file="table.of.frequencies.csv", sep = ",", header = TRUE, row.names=1, quote = '\"'))
#and show the results
View(table.of.frequencies)

#I use the transpose function to invert the dataframe
table.of.frequencies<-t(table.of.frequencies)

#save the inverted table
write.csv(table.of.frequencies, file = "table.of.frequencies1.csv",row.names=TRUE)

#I check the table
View(table.of.frequencies)

#and look at the corpus distribution
summary(table.of.frequencies)

#I make a copy of my freq table
freqs_rel = table.of.frequencies

#Relative frequency: for each data point I divide the number by the 
#sum of the column
for(i in 1:ncol(freqs_rel)){
  freqs_rel[,i] = freqs_rel[,i]/sum(freqs_rel[,i])
}
head(freqs_rel)

#I pick the first 70 most frequent verbs
freqs_rel_mfw = freqs_rel[1:70,]

#let's do a pca
APC = PCA(t(freqs_rel_mfw))

#let's check the eigenvalues to see if it's reliable...(not great)
fviz_eig(APC, addlabels = TRUE, ylim = c(0, 70))

#let's check the correlation between the verbs (variables)
fviz_pca_var(APC, col.var = "cos2",
             gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"),
             repel = TRUE) 

#let's check the other way around
APC1 = PCA(freqs_rel_mfw)

#alternative visualisation (individuals)
fviz_pca_ind(APC1, col.ind = "cos2", 
             gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"), 
             repel = TRUE)

#final visualisation (biplot)
fviz_pca_biplot(APC, 
                title="PCA - Verbs introduced by prepositions in Italian adjunct clauses", 
                labelsize=3, col.var="contrib", geom.var = "text", 
                select.var = list(contrib = 50), repel = TRUE)+
  scale_color_gradient2(
    low="#FEFB01", mid="#87FA00", 
    high="#008001", midpoint=1.6)+theme_bw() 


