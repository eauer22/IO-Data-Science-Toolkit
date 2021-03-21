1+1

head(iris)

by(iris, iris$Species, function(x) mean(x$Petal.Length))
