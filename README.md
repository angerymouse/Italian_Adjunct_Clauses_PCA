# Italian Adjunct Clauses PCA

## Project
 This repository contains the data and script used to perform a Principal Component Analysis (PCA) of the prepositional phrases introducing adjunct clauses in Italian and the verbs they are followed by.

## Data
 The data was sourced from the CORIS (CORpus di Italiano Scritto), available [here](https://corpora.ficlit.unibo.it/TCORIS/). The relevant adjunct clauses were searched with the help of regular expressions and POS tags, then  copy pasted and saved into txt files.
 
 The data folder includes the raw data, the resulting list of lemmatised verbs and the frequency tables. The lemmatisation was performed with the [CST's Lemmatiser](https://cst.dk/online/lemmatiser/uk/). 
 
 The PCA and visualisation were carried out in the R programming language. Some of the code was adapted from S. Gabay's [Cours_6](https://github.com/gabays/32M7129/tree/master/Cours_06). The script is available in the R_script folder.
 
 The images folder contains the visualisation in vector format.

 For more information, please read the visualisation report available in the report folder.
 
## Citation

Martina Rizzello. _Italian_ _Adjunct_ _Clauses_ _PCA_. Université de Genève, 2023.

```bibtex
@misc{Rizzello_PCA_2023,
  title        = {Italian Adjunct Clauses PCA},
  author       = {Rizzello, Martina},
  howpublished = {\url{https://zenodo.org/badge/latestdoi/589588944}},
  year         = {2023},
}
```

 [![DOI](https://zenodo.org/badge/589588944.svg)](https://zenodo.org/badge/latestdoi/589588944)
 
 
