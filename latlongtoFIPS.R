#Lat long to FIPS

#Function
latlong2fips <- function(latitude, longitude) {
  url <- (
    paste0(
      "http://data.fcc.gov/api/block/find?format=json&latitude=",as.character(latitude),"&longitude=",as.character(longitude),"&showall=false")
    )
  data <- fromJSON(RCurl::getURL(url))
  as.character(data$Block[1])
}

#Get Philly Crimes Data into a format that the function can read
  #i.e. one column named "latitude" and one column named "longitude", 
    #then split up data into sections so API doesn't have to work so hard,
      #then do this for each file

philly_crimes_wFIPS <- philly_crimes %>% 
  rowwise() %>% 
  mutate(
    FIPS = latlong2fips(latitude, longitude)
    )

        #then recombine