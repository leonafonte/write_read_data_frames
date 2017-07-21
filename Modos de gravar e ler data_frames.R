## 1 - saveRDS

nrOfRows <- 1e7
x <- data.frame(
  Integers = 1:nrOfRows,  # integer
  Logicals = sample(c(TRUE, FALSE, NA), nrOfRows, replace = TRUE),  # logical
  Text = factor(sample(state.name , nrOfRows, replace = TRUE)),  # text
  Numericals = runif(nrOfRows, 0.0, 100),  # numericals
  stringsAsFactors = FALSE)

head(x)
tail(x)

## Gravando com saveRDS comprimido
tw_saveRDS <- system.time({
  saveRDS(x, "c:/R/Github/saveRDS.rds")  
})
tw_saveRDS
## Gravando saveRDS não comprimido
tw_saveRDS_nc <- system.time({
  saveRDS(x, "c:/R/Github/saveRDS_nc.rds", compress = F)  
})
tw_saveRDS_nc

## Lendo saveRDS comprimido
tr_saveRDS <- system.time({
  readRDS("c:/R/Github/saveRDS.rds")  
})

## Lendo saveRDS não comprimido
tr_saveRDS_nc <- system.time({
  readRDS("c:/R/Github/saveRDS_nc.rds")  
})
tw_saveRDS
tw_saveRDS_nc
tr_saveRDS
tr_saveRDS_nc

## ----------------------------------------------------- ##



## 2 - feather

install.packages("feather")
library(feather)

## Gravando com feather
tw_feather <- system.time({
  write_feather(x, "c:/R/Github/feather.feather")
})
tw_feather

## Lendo com feather
tr_feather <- system.time({
  read_feather("c:/R/Github/feather.feather")
})
tr_feather

## Lendo alguns registros com feather
a <- feather("c:/R/Github/feather.feather")
b <- a[5000:6000, 1:3]
b

## ----------------------------------------------------- ##


## 3 - fst
install.packages("fst")
library(fst)

# Gravando fst
tw_fst <- system.time ({ 
  write.fst(x, "c:/R/Github/datafst.fst")
})
tw_fst

## Lendo fst
tr_fst <- system.time ({
  a <- read.fst("c:/R/Github/datafst.fst") 
}) 
tr_fst
head(a)
tail(b)

## Lendo alguns registros com fst
tr_fst_slice <- system.time ({
  b <- read.fst("c:/R/Github/datafst.fst", c("Logicals", "Text"), 2000, 4990) 
}) 
tr_fst_slice
b
head(b)
tail(b)

## -------------------------------------------------------------------- ##


## Gravando com fwrite
library(data.table)

tw_fwrite <- system.time ({
  fwrite(x, "c:/R/Github/fwrite.csv")
}) 
tw_fwrite  

## Lendo com fread
tr_fread <- system.time ({
  fread("c:/R/Github/fwrite.csv")
})
tr_fread

## -------------------------------------------------------------------- ##



## Conclusão ##

## - Use sempre saveRDS e readRDS, se precisar de velocidade, salve com o argumento compress = FALSE para não comprimir o arquivo.

## - Se você for ler a base em python ou Julia e quiser um formato padronizado, use o feather.

## - Se você for realmente ler e escrever os seus dados muitas vezes e você precisar de velocidade, use o fst, mas tome cuidado com os valores com formato date.

