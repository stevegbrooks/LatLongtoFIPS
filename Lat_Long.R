library(readr)
library(plyr)
phila_crimes_10percent <- read_csv("C:/Users/BrookSte/Downloads/phila_crimes_10percent.csv")
View(phila_crimes_10percent)

long_lat <- sub(
  ".*\\((.*)\\).*",
  "\\1", # Replace the match (which is everything) with the first capture group.
  phila_crimes_10percent$Shape,
  perl = TRUE
)

long_lat<-as.data.frame(
  strsplit(
    long_lat,
    " " # Split on spaces
  )
)

long_lat<-as.data.frame(t(long_lat))
long_lat$X1<-phila_crimes_10percent$X1

phila_crimes<-merge(long_lat, phila_crimes_10percent, by="X1")
phila_crimes<-rename(phila_crimes, c("V2"="Latitude", "V1"="Longitude"))

head(phila_crimes)
