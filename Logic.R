active <- TRUE

print( paste( "NOT logic !active:", !active ) )

flags <- c( TRUE, TRUE, FALSE, ( 1 > 0 ), 0 )
marks <- c( FALSE, TRUE, TRUE, 16, FALSE )

print( paste( "AND  logic:", flags && marks ) )
print( paste( "OR logic:", flags || marks ) )

and.result <- flags & marks
or.result <- flags | marks