# Missing Data in IRT

Finch (2008) Estimation of Item Response Theory Parameters in the Presence of Missing Data. Journal of Educational Measurement, 45(3), 225-245.  


<span>　</span>
基本的には欠測値の代入方法は大きく分けて5つ

1. 項目平均と受検者得点の平均から Corrected Item mean Substitution(CM) を計算して代入する。
2. 欠測値以外の残りの得点の平均値を代入する。
3. 多重代入法を利用する。Cold Deck と Hot Deckで大きく分かれるが，とにかくいろんな手法があるっぽい。
4. EMアルゴリズムを利用する。SASのPROC MI procedureが有名っぽい。
5. そもそも代入なんてしない（BILOGMG方式）。完全に無視するか，部分点として数える。

※normal-based approachとは？

<span>　</span>
Lordは1970年代くらいから欠測値の研究に着手していて，当初から，MissingをIN(Incorrect)と扱ってはいけないと主張していた（de ayalaで読んだ気がする）。  
　Bernaards & Sijtsma (1999) の研究によれば，CMによる代入は，ランダム補完，平均補完，リストワイズ法のいずれの方法よりも優れた結果を出している。さらにBernaards & Sijtsma (2000) はCMをEMアルゴリズムによる代入を比較して，リッカートタイプのデータに対してはEMが最適な手法であるが，CMは簡便な方法として完全にNOとはされていない（そこまで性能が悪くなかったのかな？）。  
　Huisman and Molenaar (2001) はHot Deck，CM，Mokken Scaling（ノンパラの一種）と1PLMによるモデルベースの代入などを比較した結果，1PLMにもとづくモデルベース代入がもっとも優れた結果でくぁり，CMやノンパラ手法はわずかに性能が悪く，CMは最も低い性能であったと述べている。
