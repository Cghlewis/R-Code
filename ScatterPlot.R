x <- 1:10
y <- x^2

library( ggplot2 )

qplot( x, y )
 
qplot( x, y, geom=c("point", "line" ) )

qplot( x, y, geom=c( "point", "line" ), color=I( "Red" ) )