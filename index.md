# takuizum

## about this site.

　このサイトでは主に項目反応理論の分析パッケージ`irtfun2`の機能を紹介していきます。項目反応理論の説明についても，のちのち加筆していこうと考えています。  
 項目反応理論は広義のテスト（学力テストから心理検査，アンケートなど）を分析するための心理軽量モデル (Psychometric model) の一種です。測定対象の能力や特性をモデルのパラメタに含むことから，潜在変数モデルの一種であると言われます。  
 代表的なモデルのひとつが2-Parameter Logistic Model，

<div align="center">
<img src="https://latex.codecogs.com/png.latex?P(\theta)=\frac{1}{1&plus;\rm{exp}\it\left(-Da(\theta-b)\right)}" title="P(\theta)=\frac{1}{1+\rm{exp}\it\left(-Da(\theta-b)\right)}" />
</div>

です。aは識別力を，bは困難度，\thetaは受験者の特性値（能力）を表します。    
 IRTモデルは多変量解析の一種であり，因子分析 (Factor Analysis) とも理論的な関連があります。具体的にはカテゴリカルデータの因子分析がIRTに一致するというものです。


 - [irtfun2の使い方](20190118_introduction_to_irtfun2)
 - [irtfun2のインストール方法](20180118_install_irtfun2)
