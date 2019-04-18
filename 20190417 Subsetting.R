#subsetting
x <- c("a", "b", "c", "d", "e")
x
x[c(1,5)]
x[1]

Games
Games[1:3, 6:10]
Games[c(1,10),]
Games[, c("2008","2009")]
Games[1,]

is.matrix(Games[1,])
is.vector(Games[1,])

# 要素を取り出す際，引数に drop=FALSE を指定することで，行列の要素抽出における結果のベクトル化を防ぐことも出来る（結果が複数行で無い場合にベクトル化がなされる）
Games[1,,drop=F] 
Games[1,5, drop=F]
