setwd( "C:/MyRScripts")
cat( "Working Directory:", getwd( ), "\n\n" )

frame <- read.csv( "DataSet-Browsers.csv" )

print( frame )