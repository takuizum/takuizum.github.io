# Longitudinal IRT

### Vandemeulebroecke et al. (2017). A Longitudinal Item Response Theory Model to Characterize Cognition Over Time in Elderly Subjects.
##### [link](https://ascpt.onlinelibrary.wiley.com/doi/full/10.1002/psp4.12219)

認知機能の低下とそれに効くとされる薬の効果を測定するための様々なテストをIRTモデルで分析した研究。特に，どのような認知領域 (Cognitive Domain) が高齢者の認知機能低下に対して最も情報をもたらすのか，あるいは，どの受検者特性が早期の認知機能低下に関連するのかをあぶり出したい。  
この研究で使用するモデルは $\theta$ を複数時点の得点の線形和として考えるモデルである。テスト項目は全受験で同じ。つまり
$$
\begin{eqnarray}
\theta &=& \gamma_{0, s} + \gamma_{1, s} \times t + \dots \\
\gamma_{1, s} &=& \gamma^\ast_{1, s} + \bf x_s \beta
\end{eqnarray}
$$
というモデルが，反応確率のロジットに一致する。 $\bf x$ は受検者ごとに特徴付けられたベクトルであり。ジェンダーや年齢，簡易精神検査の結果，認知症リスクを高める遺伝子を持っているか否かなどの，認知機能に関連する様々な変数がここに含まれる。詳しくはSupplemental Materialを見よ。筆者らはWinBUGS, JAGS, Stanの3種類でモデリングしたらしい。  
データは認知機能に関するいくつかのテスト項目であり，計算時間短縮のため，それぞれをいくつかのカテゴリに要約している。  
結果を解釈する際はテスト情報量を算出している。このモデルで情報量を計算するためには対数尤度関数の二階偏微分の負の期待値が必要になる。各モデルで計算しないとダメなのだろうか。
$\theta$ を縦断データの測定要素の線形和として分解している点はユニーク。Stanのコードもついているので，参考にできる。
