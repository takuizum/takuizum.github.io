# Workstation of takuizum

## About this site.

<!---
　このサイトでは主に項目反応理論の分析パッケージ`irtfun2`の機能を紹介していきます。項目反応理論の説明についても，のちのち加筆していこうと考えています。  
--->

[@takuizum](https://twitter.com/takuizum)のサイトです。  
東京の民間企業でデータ分析のお仕事をしています。心理測定やテスト理論に関心があります。  
加入学会は日本テスト学会，日本教育心理学会，日本心理学会です。  
最近は行動計量学会などにも参加しています。  
プログラミング言語はRとjuliaを使います。  

Julia Advent Calender 2019の2日目に投稿しました👀。[HERE](https://qiita.com/advent-calendar/2019/julialang)

## What's IRT ?

 項目反応理論は広義のテスト（学力テストから心理検査，アンケートなど）を分析するための心理軽量モデル (Psychometric model) の一種です。測定対象の能力や特性をモデルのパラメタに含むことから，潜在変数モデルの一種であると言われます。  
  代表的なモデルのひとつが2-Parameter Logistic Model，

<div align="center">
<img src="https://latex.codecogs.com/png.latex?P(\theta)=\frac{1}{1&plus;\rm{exp}\it\left(-Da(\theta-b)\right)}" title="P(\theta)=\frac{1}{1+\rm{exp}\it\left(-Da(\theta-b)\right)}" />
</div>

です。<img src="https://latex.codecogs.com/png.latex?\it&space;a" title="\it a" />は識別力を，<img src="https://latex.codecogs.com/png.latex?\it&space;b" title="\it b" />は困難度，<img src="https://latex.codecogs.com/png.latex?\theta" title="\theta" />は受験者の特性値（能力）を表します。    
 IRTモデルは多変量解析の一種であり，因子分析 (Factor Analysis) とも理論的な関連があります。具体的にはカテゴリカルデータの因子分析がIRTに一致するというものです。

## What's merits of IRT ?

心理尺度を構成したり，学力診断をするためのテストの分析であれば，大抵の場合IRTは不要です。しかし，より詳細に項目の特性や測定精度を検討したい時や，異なるテスト得点を比較するために対応づけ (linking) を実行したい場合に，IRTは真価を発揮します。

## How to analyse the data with IRT in R ?

IRTは有益なモデルですが，分析可能なソフトが比較的限定されています。2013~2015年くらいまでは市販のソフトウェアでなければまともにIRT分析をすることはできませんでしたが，最近では[Easy Estimation](http://irtanalysis.main.jp/) や [Exametrika](http://antlers.rd.dnc.ac.jp/~shojima/exmk/jindex.htm), [HAD](http://norimune.net/had) などを使用して手軽に，GUIで簡単に分析をすることができるようになりました。それ以前は海外の研究者が作ったプログラムを使用するしかありませんでした。

近年では統計分析をRでおこなうことも増えてきており，当然IRTを分析するパッケージも充実しています。中には多次元IRTなどのより発展的なモデルを分析できるものを実装されており，私も情報が追いついていません。RでIRT分析を行いたいのであれば，`ltm`や`irtoys`，`mirt`パッケージなどが便利なようです。もちろん，ごく一部のモデルしかまだ対応していませんが，`irtfun2`でも分析できます！！

<!---

しかし，Rで分析可能なIRT用のパッケージの多くは推定速度が遅かったり，高速化できてもアウトプットの情報が乏しかったりするため，満足に研究や分析に用いることが難しいです。そのため今でも研究や実務では市販のソフトウェア（例えばIRT PRO）が使用されます。

またBILOG-MGやIRT PROならば別ですが，Easy EstimationやHADはRとは直接連携する機能を持たないため，繰り返し分析を行う際にアドホックな手続きを要します。つまり，Rでデータを整形->CSVやtxtに書き出し->それぞれのソフトウェアで分析，という手順を踏むことになります。当然，大量のデータを繰り返し分析するようなシミュレーションなどには不向きですし，なにより分析がRで完結しないため途中でデータがどこにあるかわからなくなったり，予期せぬ不都合が生じてしまいます。

Rの中だけでデータと分析が完結すれば，コピペ汚染のような問題も起こりにくいですし，ggplot2などの強力なデータビジュアリゼーションパッケージが，スムースに使用できます。

--->

---
メモ・ノート😏
- [Notes/](Notes/generalized-linear-mixed-model.md)

---

自作パッケージ周りの資料  

 - [irtfun2の使い方](20190118_introduction_to_irtfun2)
 - [irtfun2のインストール方法](20180118_install_irtfun2)
 - [irtfun2の妥当性検証](20190107_validation_irtfun2)

---

院生時代の資料  

 - [確認的因子分析の資料（自主ゼミ用）](20190121_confirmed_factor_analysis_with_Stan)
 - [HTML ver](09_Confirmed_Factor_Analysis.html)


<!---

# Deprecated due to old version
 - [irtfun2 source ver.](irtfun2_0.6.7.1.tar.gz)
 - [irtfun2 binary ver.](irtfun2_0.6.7.1.zip)
 
--->