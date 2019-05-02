###########################################################
#####セクション4 可視化  ####################################
###########################################################

###########################################################
#レクチャー： 補足：因子型（Factor型）のRでの実践1&2-----------
###########################################################


factor_table <- data.frame(
  seibetu = c("男","女","男","男","男","男"),
  ketueki = c("A","B","O","O","AB","A"),
  umare = c("大阪","京都","兵庫","兵庫","京都","大阪"),
  alcohol = c("週1日以内","週3-6日","週3-6日","毎日","のまない","週1-2日")
)

#この時点では、すべてが文字列型のはずです。
summary(c("男","女","男","男","男","男"))
summary(factor_table$seibetu)

#???

default.stringsAsFactors()

#このstringsAsFactorsという設定が実はデフォルトでは、
#TRUEになっています。
#Helpをみると、

?data.frame

#stringsAsFactors = default.stringsAsFactors()
#というオプションがあり、
#strings(文字列)As(を)Factors(因子に)という
#オプションがTRUEになっているため、
#data.frame関数は勝手に文字列を因子型に変換してしまいます。

#この挙動が困るのは、例えば、間違って
#数値型に列を変換してしまったときに、

as.numeric(c("男","女","男","男","男","男"))
#文字列型であれば
#数値型に変換できずエラーがでてしまうのですが、

as.numeric(factor_table$seibetu)
#なんと数字型に変換できてしまいます！

#これは因子型の「レベル」に対しての操作になるため
#このような結果になります。


string_table <- data.frame(
  seibetu = c("男","女","男","男","男","男"),
  ketueki = c("A","B","O","O","AB","A"),
  umare = c("大阪","京都","兵庫","兵庫","京都","大阪"),
  alcohol = c("週1日以内","週3-6日","週3-6日","毎日","のまない","週1-2日"),
  stringsAsFactors = FALSE
)

summary(string_table)
summary(factor_table)

#先程のレクチャーでつくったfactor_tableの続きです。
factor_table

#さて、生まれ変数が関西圏が並んでいますが、
#日本には都道府県が47あります。
factor_table$umare

#レベルが３つしかありません。
#なぜなら、Rには、入力されたデータからしか
#因子をつくることができないからです。
#とりあえず、関西圏のデータ
#であるという前提があるとして、整えます。

x <- factor_table$umare

levels(x)

c(levels(x), "奈良", "滋賀", "和歌山")

a <- factor(x, levels=c(levels(x), 
                        "奈良","滋賀", "和歌山"))


a
summary(a)

#このようにすると、因子型のベクトルに対して、
#必要なレベル設定をしてあげることができました。
#labelという設定もありますが、levelと考え方は同じです

#レベルベクトル：
vecLev <- c(1,2,3,4,5,6)
#ラベルベクトル：
vecLab <-c("京都","大阪","兵庫","奈良","滋賀","和歌山")

a <- factor(c(1,2,3,1,2,3,4,5,3,4,5,6,3), 
            levels=vecLev, labels=vecLab)

a
as.numeric(a)


###########################################################
#レクチャー： 演習問題　出題：geom_XXX関数を利用したグラフ描画--
###########################################################

#Section4 practice1 導入

#ggplotで基本的なグラフを描画する！

library(ggplot2)

#これで、
diamonds
economics
msleep

#等のデータセットが利用できるようになっていると思うので、
#これらを利用します。

#diamonds：50000個のダイヤモンドのデータ
# price -> 値段(ドル)
# carat -> 重さ
# cut -> カットの質（カテゴリカル変数）
# color -> ダイヤの色（カテゴリカル変数、
#　　　　Jが最低、Dが最高）
# clarity -> ダイヤの透明度
#　　　　　　（悪い：I1 SI2 SI1 VS2 VS1 
#              VVS2 VVS1 IF 最高。
#            カテゴリカル変数
# x, y, z -> 長さ、幅、
#            深さをミリメートル単位

#他のデータセットも、helpの検索を利用すれば
#詳しい内容を知ることができます。
?economics

#例題：ダイヤモンドの長さ(x)と幅(y)の関係を
#       散布図で描画してください。

ggplot(data = diamonds) +
  geom_point(mapping=aes(x=x, y=y))

#Q1: ダイヤモンドの重さと値段の関係を、
#    散布図で描画してください。
#Q2: ダイヤモンドの色と値段の関係を、
#    箱ひげ図で描画してください。
#Q3: ダイヤモンドの透明度と色の関係を、
#    何らかの形で描画してください
ggplot(data = diamonds) + geom_count(mapping=aes(x=clarity, y=color))
#Q4: ダイヤモンドの値段の分布をヒストグラムにして
#    描画してください

#Q5: ダイヤモンドのカットの質が分類毎に、
#    このデータセットに何件ずつあるのかを
#    描画してください。

#Q6: この問題には、economicsデータを利用します。
#    米国の失業者数の推移を何らかの形で描画してください。

#economics:米国の経済データ
# date -> 日付
# unemploy -> 失業者数（千人単位）
# pop -> 人口（千人単位）

################################################################
# 演習問題　解答例：geom_XXX関数を利用したグラフの描画 -------------
################################################################

#====================================================
#Q1: ダイヤモンドの重さと値段の関係を、
#散布図で描画してください。
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price))

#Q2: ダイヤモンドの色と値段の関係を、
#箱ひげ図で描画してください。
ggplot(data =diamonds) +
  geom_boxplot(mapping = aes(x = color, y = price))

#Q3:　ダイヤモンドの透明度と色の関係を、
#何らかの形で描画してください
#例：
gdia <- ggplot(data = diamonds)

gdia + geom_count(aes(clarity, color))
gdia + geom_jitter(aes(clarity, color))

#Q4: ダイヤモンドの値段の分布を
#ヒストグラムにして描画してください
gdia + geom_histogram(aes(price))

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price))

#Q5: ダイヤモンドのカットの質が分類毎に、
#このデータセットに
#何件ずつあるのかを描画してください。
gdia + geom_bar(aes(cut))
summary(diamonds$cut)

#Q6: この問題には、economicsデータを利用します。
#米国の失業者数の推移を何らかの形で描画してください。
economics
geco <- ggplot(economics) 
  
geco + geom_line(aes(date, unemploy))
geco + geom_point(aes(date, unemploy))

#################################################################
# グラフの色設定のRでの実践 1 & 2----------------------------------
#################################################################

#==================================================================================
#演習問題で作ったグラフを塗り分けて、
#より「意味を感じられる」グラフを作ってみましょう。
library(ggplot2)

#Q1: ダイヤモンドの重さと値段の関係を、
#散布図で描画してください。
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price))

#何となく右肩上がりですが、同じ重さでも、
#値段に相当な開きがありそうです。
#カットが影響している？？？
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, 
                           y = price, 
                           color = cut))


#??? 透明度は？
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat,
                           y = price,
                           color = clarity))

#なんか意味ありそうですね。　色もみて見ましょう
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat,
                           y = price,
                           color = color))
#こっちも関係ありそう。

#補足、mappingは、実はggplotの中に記載してもOKで、
#＋以降のgeom関数にその効果は続きます。
#なので、うえの例のようにほぼ同じグラフをたくさん書いて
#探索的なデータ可視化を行う場合は、
#次のように書いてもOKです

gg <- ggplot(data = diamonds, mapping = aes(x = carat,
                                            y = price))

gg + geom_point()
gg + geom_point(mapping = aes(color = cut))
gg + geom_point(mapping = aes(color = clarity))

#さらに、argumentが指定されていない場合、
#ヘルプファイルの順番
#通りに記載されていると解釈されるため、
#data= mapping=部分は
#省略できるため、
gg <- ggplot(diamonds, aes(carat, price))
gg + geom_point()
gg + geom_point(aes(color = cut))
#という風に簡略できます。


#Q2: ダイヤモンドの色と値段の関係を、
#箱ひげ図で描画してください。
library(ggplot2)

ggplot(data =diamonds) +
  geom_boxplot(mapping = aes(x = color, y = price))

#これも、色と値段に何かしらの関係がありそうです。
#他の変数で色分けしてみましょう
ggplot(data = diamonds) +
    geom_boxplot(mapping = aes(x = color, 
                               y = price, 
                               color = cut))
 
ggplot(data = diamonds) +
   geom_boxplot(mapping = aes(x = color,
                              y = price,
                              color = clarity))
 

#colorでなくてfillを使うと、
ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = color, 
                             y = price, 
                             fill = cut))

ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = color,
                             y = price,
                             fill = clarity))

# ggplot(data = diamonds) +
#   geom_boxplot(mapping = aes(x = color,
#                              y = price,
#                              fill = clarity,
#                              color = clarity))

#->
gg <- ggplot(diamonds, aes(color, price))

gg + geom_boxplot(aes(color=cut))
gg + geom_boxplot(aes(color=clarity))

gg + geom_boxplot(aes(fill=cut))
gg + geom_boxplot(aes(fill=clarity))

gg + geom_boxplot(aes(fill=clarity, color = clarity))

             
             
#Q3:　ダイヤモンドの透明度と色の関係を、
#何らかの形で描画してください

#例：
gdia <- ggplot(data = diamonds)

gdia + geom_count(aes(clarity, color))
gdia + geom_jitter(aes(clarity, color))

#
gdia + geom_jitter(aes(clarity, color, color = cut))
gdia + geom_jitter(aes(clarity, color, color = clarity))
   #意味ないですけど
gdia + geom_count(aes(clarity, color, color = cut))


gdia + geom_jitter(aes(clarity, color, color = carat)) 
   #このように、連続変数も色の濃さで表現されます

#Q4: ダイヤモンドの値段の分布をヒストグラムにして
#描画してください
gdia <- ggplot(data = diamonds)

gdia + geom_histogram(aes(price))

gdia + geom_histogram(aes(price, color = cut)) #???
gdia + geom_histogram(aes(price, fill = cut))
gdia + geom_histogram(aes(price, fill = clarity))

#Q5: ダイヤモンドのカットの質が分類毎に、
#このデータセットに何件ずつあるのかを描画してください。
gdia + geom_bar(aes(cut))

gdia + geom_bar(aes(cut, fill = clarity))
gdia + geom_bar(aes(cut, fill = price)) #これはだめです

gdia + geom_bar(aes(cut, fill = clarity))　
  #これを種類毎に分けたい場合はどうすればいでしょうか？
#positionというオプションがあるgeom_XXXでは、
#次のようなことができます。
gdia + geom_bar(mapping = aes(cut, fill=clarity), 
                position = "dodge")　
　　　#dodgeはよけるという意味です。
gdia + geom_bar(aes(cut, fill=clarity),
                position = "stack")

#Q4のヒストグラムも同様です。
gdia + geom_histogram(aes(price, fill = clarity), 
                      position = "dodge")


#Q6: 米国の失業者数の推移を何らかの形で描画してください。
economics
geco <- ggplot(economics) 

geco + geom_line(aes(date, unemploy,color = pop))

geco + geom_line(mapping = aes(date,unemploy),
                 color = "red",
                 size = 1.5,
                 linetype = "dashed")



###############################################################
# タイトルとラベルの設定のRでの実践 ------------------------------
###############################################################

ggplot(diamonds) +
  geom_histogram(aes(x = price, fill = color))

#に、タイトル：「ダイアモンドの値段分布」　
#X軸：「値段(ドル)」　Y軸：「件数」とつけてみましょう。

ggplot(diamonds) + 
  geom_histogram(aes(price, fill=color)) +
  labs(title = "ダイヤモンドの値段分布",
       x = "値段[ドル]", 
       y = "件数")

#もちろん、変数も使えるので、
title_text = "なにかすごいタイトル"
label_x_axis = "すごいラベルX"
label_y_axis = "とてつもないラベルY"

yoi_graph <- ggplot(diamonds) + 
  geom_histogram(aes(price, fill=color)) 

yoi_graph + labs(title = title_text, 
                 x = label_x_axis, 
                 y = label_y_axis)


title_text <- "A"
label_x_axis <- "B"
label_y_axis <- "C"

yoi_graph + labs(title = title_text, 
                 x = label_x_axis, 
                 y = label_y_axis)

#こんなこともできます。

#############################################################
# Legendの設定のRでの実践 1 & 2 ------------------------------
#############################################################

#凡例操作
#library(tidyverse)

graph <- ggplot(diamonds) + geom_histogram(aes(x = price, fill = clarity))
graph

#まず、凡例をけしてみる　guide = FALSE
graph + scale_fill_discrete(guide = FALSE)

#タイトルをいじる
graph
graph + scale_fill_discrete(name = "透明度")

#表示される順番を変えてみる
graph
graph + 
  scale_fill_discrete(breaks = c("I1", "IF", "VVS1",
                                 "VVS2", "VS2", "VS1", "SI2", "SI1"))

#ところで、ダイヤモンドの透明度について知らないことに気づいたので、
#調べてみました。

#透明度とは、ダイヤモンドに含まれる微少な包有物
#I1:含まれる 
#SI2:わずかに含まれる
#SI1:わずかに含まれる
#VS2:ほんのわずかに含まれる
#VS1:ほんのわずかに含まれる
#VVS2:ごくごくわずかに含有
#VVS1:ごくごくわずかに含有
#IF:内部が無傷

#ラベルをつけます

levels(diamonds$clarity)
#で表示された順番に、
text_label_of_clarity <- c("含まれる",
                           "わずかにSI2","わずかにSI1",
                           "ほんのわずかにVS2","ほんのわずかにVS1",
                           "ごくごくわずかにVVS2","ごくごくわずかにVVS1",
                           "内部が無傷")

graph
graph + scale_fill_discrete(labels = text_label_of_clarity)

#ここまでの情報をまとめると、
ggplot(diamonds) + geom_histogram(aes(x = price, fill = clarity)) +
  labs(title = "値段と含有物のヒストグラム", x = "値段", y = "件数") +
  scale_fill_discrete(name = "透明度", 
                      labels = text_label_of_clarity)

#こんなグラフがかけるようになりました！


#練習問題：次のグラフにタイトルと軸のラベルをつけて、透明度の凡例をつけてください。
ggplot(diamonds) + geom_point(aes(carat, price, color = clarity))
#答え合わせは次のレクチャーで。


#=================================================================================
ggplot(diamonds) + geom_point(aes(carat, price, color = clarity))

levels(diamonds$clarity)
#で表示された順番に、
text_label_of_clarity <- c("含まれる",
                           "わずかにSI2","わずかにSI1",
                           "ほんのわずかにVS2","ほんのわずかにVS1",
                           "ごくごくわずかにVVS2","ごくごくわずかにVVS1",
                           "内部が無傷")

ggplot(diamonds) + 
  geom_point(aes(carat, price, color = clarity)) +
  labs(title = "値段と重さと透明度の関係", x = "重さ(カラット)", y = "値段") +
  scale_color_discrete(name = "透明度",
                       labels = text_label_of_clarity)

###############################################################
# テーマの設定方法のRでの実践 -----------------------------------
###############################################################

#Theme 設定
#単純にグラフにtheme_XXX()を足すだけで、お手軽にテーマ設定ができます。
text_label_of_clarity <- c("含まれる",
                           "わずかにSI2","わずかにSI1",
                           "ほんのわずかにVS2","ほんのわずかにVS1",
                           "ごくごくわずかにVVS2","ごくごくわずかにVVS1",
                           "内部が無傷")


graph <- ggplot(diamonds) + 
  geom_histogram(aes(carat, fill = clarity)) +
  labs(title = "値段と重さと透明度の関係", x = "重さ(カラット)", y = "値段") +
  scale_fill_discrete(name = "透明度",
                       labels = text_label_of_clarity) 
graph

graph + theme_gray()

graph + theme_bw()

graph + theme_linedraw()

graph + theme_light()

graph + theme_dark()

graph + theme_minimal()

graph + theme_classic()

?theme
#ところで、色々なテーマを集めた、ggthemesパッケージというものがあります。
install.packages("ggthemes")

graph + ggthemes::theme_base()
graph + ggthemes::theme_calc()
graph + ggthemes::theme_economist() #Economist(雑誌)とにたテーマ
graph + ggthemes::theme_economist_white()
graph + ggthemes::theme_excel() #説明分がひどいです・・・「絶対につかわないで」
graph + ggthemes::theme_few()
graph + ggthemes::theme_fivethirtyeight()
graph + ggthemes::theme_gdocs()
graph + ggthemes::theme_stata()
graph + ggthemes::theme_wsj() #Wall Street Journalとにたテーマ


#以上でGGPLOTの使い方を一通り説明いたしました。

##############################################################
# 補足：集計済みデータの描画～statオプション~ -------------------
##############################################################

#集計済みのデータを表示したい：
library(ggplot2)

table <- data.frame(
  age_group　= c("~20","21~40","41~60","61~80","81~100","100~"),
  yearly_admission = c(39,42,73,88,93,132)
)

ggplot(table) + geom_bar(aes(age_group))

ggplot(table) + 
  geom_bar(aes(age_group, yearly_admission), 
           stat = "identity")

#このように、stat = "identity"というオプションをつけることで、
#geom_point等と同様の動作を設定できます。

ggplot(table) + geom_point(aes(age_group), stat="count")

#通常のgeom_barのstat = "count"　という設定を、
#手動で打ち消してあげることでこの動作になります。
#ということは・・・

diamonds
ggplot(diamonds) + geom_bar(aes(x = clarity))
ggplot(diamonds) + geom_point(aes(x = clarity)) #エラー！
ggplot(diamonds) + geom_point(aes(x = clarity), stat = "count") #成功！

#このように、実は、変数×集計の組み合わせgeom_XXXの動作を
#変数×変数の組み合わせの動作にしたり、そのまた逆にしたりをstatオプションを設定することで
#実現できます。



################################################################################
# 補足：themeでX軸のラベルを回転させる --------------------------------------------
################################################################################

#追加：themeでの個別設定が必要になるとき
table <- data.frame(
  item_name　= c("究極のマスクメロンアイスクリーム",
                "イチゴたっぷりショートケーキイタリア風",
                "和栗の贅沢ブラックモンブラン",
                "朝どれ卵のなめらかプリン",
                "マンゴーと南国フルーツのタルト",
                "フルーツをたっぷりつかったロールケーキ"),
  uriage_kosu = c(39,42,73,88,93,132)
)

ggplot(table) + 
  geom_bar(aes(item_name, uriage_kosu), stat="identity")

#このようにX軸が重なってしまったというときは、
#themeで設定を変えましょう

ggplot(table) + 
  geom_bar(aes(item_name, uriage_kosu), stat="identity") +
  theme(axis.text.x = element_text(angle = 45, hjust=1))

#できました！
#ただし、theme_classicなどを設定すると上書きされるので、
ggplot(table) + 
  geom_bar(aes(item_name, uriage_kosu), stat="identity") + 
  theme(axis.text.x = element_text(angle=45, hjust = 1)) +
  theme_classic()

#順番を入れ替えましょう
ggplot(table) + 
  geom_bar(aes(item_name, uriage_kosu), stat="identity") +
  theme_classic() +
  theme(axis.text.x = element_text(angle=45, hjust = 1))
