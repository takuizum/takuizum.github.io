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
というモデルが，反応確率のロジットに一致する。 $\bf x$ は受検者ごとに特徴付けられたベクトルであり。ジェンダーや年齢，簡易精神検査の結果，認知症リスクを高める遺伝子を持っているか否かなどの，認知機能に関連する様々な変数がここに含まれる。詳しくはSupplemental Materialを見よ。筆者らはWinBUGS, JAGS, Stanの3種類でモデリングしたらしい。$\theta$ を縦断データの測定要素の線形結合として分解している点はユニーク。Stanのコードもついているので，参考にできる。  
データは認知機能に関するいくつかのテスト項目であり，計算時間短縮のため，それぞれをいくつかのカテゴリに要約している。結果を解釈する際はテスト情報量を算出している。このモデルで情報量を計算するためには対数尤度関数の二階偏微分の負の期待値が必要になる。各モデルで計算しないとダメなのだろうか。  
　
### Yau et al. (2018) Longitudinal measurement invariance and explanatory IRT models for adolescents’ oral health-related quality of life

QOLと口腔環境の健康度の関連についてIRTで分析する研究。質問紙が2種類あってｍ大本の Child Perception Questionnaire の短縮版2種類である。これらは思春期の児童に対して用いられる質問紙であり。この回答データから得られた潜在特性値を使って回帰分析などをおこないたい訳だが，今回はその変化に着目しているようだ。  
　まずはじめは探索的GRMを実行している。 $\theta$ が他の変数（親の収入とか）の重み付きの線形和として表現されているモデル。
$$
\begin{array}{l}{\log \left(\frac{P_{j k}^{+}}{1-P^{+} j k}\right)=\mathrm{a}_{\mathrm{j}}\left(\theta-\mathrm{b}_{\mathrm{jk}}\right)} \\ {\text { where } \theta=\mathrm{x}_{1} \mathrm{Y}_{1}+\mathrm{x}_{2} \mathrm{Y}_{2}+\ldots+\mathrm{x}_{\mathrm{p}} \gamma_{\mathrm{p}}+\varepsilon}\end{array}
$$
この研究ではこのモデルを基本に，さらに拡張した3つのモデルを適用している。  
$$
\delta=\theta_{2} - \theta_{1}\\

\delta=\mathrm{x}_{11} \gamma_{11}+\mathrm{x}_{21} \mathrm{\gamma}_{21}+\ldots+\mathrm{x}_{\mathrm{p} 1} \gamma_{\mathrm{p} 1}+\varepsilon \qquad \text{[MODEL1]}\\

\begin{array}{l} {\delta=\mathrm{x}_{1 d} \gamma_{1}+\mathrm{x}_{2 d} \gamma_{2}+} {\ldots+\mathrm{x}_{p d} \gamma_{p}+\varepsilon}\end{array} \qquad \text{[MODEL2]}\\

\begin{array}{l}{ \theta_{\mathrm{t}}=\mathrm{x}_{1 \mathrm{t}} \gamma_{1 \mathrm{t}}+}  {\mathrm{x}_{2 \mathrm{t}} \mathrm{Y}_{2 \mathrm{t}}+\ldots+\mathrm{x}_{\mathrm{pt}} \gamma_{\mathrm{pt}}+\varepsilon_{\mathrm{t}} \qquad \text{[MODEL3]}\\

\text { where } t=1,2}\end{array}

$$

全てのモデルは一時点前の $\theta$ との差 $\delta$ についてモデリングしている。MODEL1は $\delta$ をベースラインとなる最初の一時点における独立変数の線形結合に分解している。MODEL2は一時点の独立変数ではなく，最初と最後の時点での独立変数の変化を変数として活用するモデルである。さらに発展的なMODEL3はある $t$ 時点の特性を $\theta_t$ としたときに，その $\theta$ 自体をその時点における説明変数の線形結合としてモデリングするモデルである。当然1よりも2の方が，2よりも3の方が求めるべき母数は増える。

### Rijmen et al. (2003). A Nonlinear Mixed Model Framework for Item Response Theory

従来型のIRTモデルを非線形混合モデルの枠組みで再定義し，より柔軟なモデリングを可能にした。プログラムは SAS の NLMIXED　PROC を使っている。  
まずは混合ロジスティック回帰モデルとの関連性から。MLRMは非線形IRTへの重要な架け橋的存在。項目反応のロジットはIRTモデルにおいては $\alpha  \theta + d$ だったが，MLRにおける反応確率は
$$
p\left(Y_{n i}=1 | \mathbf{x}_{n i}, \mathbf{z}_{n i}, \boldsymbol{\beta}, \boldsymbol{\theta}_{n}\right)=\frac{\exp \left(\mathbf{x}_{n i}^{\prime} \boldsymbol{\beta}+\mathbf{z}_{n i}^{\prime} \boldsymbol{\theta}_{n}\right)}{1+\exp \left(\mathbf{x}_{n i}^{\prime} \boldsymbol{\beta}+\mathbf{z}_{n i}^{\prime} \boldsymbol{\theta}_{n}\right)}
$$
と定義される。変数について説明すると，まず添え字の $i$ は受検者を， $u$ はunitを表す。ここで言うユニットとは縦断的なデータにおいては観測時点になる。xとzは共変量に関する計画行列であり， $x_{ni}$ はP次元の共変量ベクトル， $z_{ni}$ はQ次元の共変量ベクトルからなる。つまり全体の計画行列である $X$ および $Z$ は3次元Array。 $\beta$ は固定効果に関するP次元のパラメタ， $\theta_n$ はユニットnのランダム効果に関するQ次元のパラメタである。一般に $\theta_n$ の確率分布は多変量ガウス分布を仮定されるため，ランダム効果の各パラメタ間には相関が仮定される。  
このモデルのパラメタを推定するためにはまずは局外母数（ランダム効果）である $\theta_n$ を積分消去したい。いま事前分布は，簡単のため，等方的多変量ガウス分布を仮定すれば，
$$
p\left(\mathbf{y}_{n} | \mathbf{X}_{n}, \mathbf{Z}_{n}, \boldsymbol{\beta}, \mathbf{\Sigma}\right)=\int\left\{\prod_{i=1}^{I_{n}} \frac{\exp \left[y_{n i}\left(\mathbf{x}_{n i}^{\prime} \boldsymbol{\beta}+\mathbf{z}_{n i}^{\prime} \boldsymbol{\theta}_{n}\right)\right]}{1+\exp \left(\mathbf{x}_{n i}^{\prime} \boldsymbol{\beta}+\mathbf{z}_{n i}^{\prime} \boldsymbol{\theta}_{n}\right)}\right\}
N\left(\boldsymbol{\theta}_{n} | \Sigma\right) d \boldsymbol{\theta}_{n}
$$
というように，ユニットnの周辺尤度が得られる。このとき先ほど触れたように $X_n$ および $Z_n$ は $I_n \times P(Q)$ の計画行列である。  

このモデルの出力は非線形な関数だが，パラメタに関してはやはり線形であるため，一般化線形混合モデルのひとつである。つまり反応確率のロジットは
$$
\eta_{n i}=\mathbf{x}_{n i}^{\prime} \boldsymbol{\beta}+\mathbf{z}_{n i}^{\prime} \boldsymbol{\theta}_{n}
$$
となり，これを適当なリンク関数に与えることで非線形な出力が得られる。ロジットリンク以外にもプロビットリンクやcomplementary log-logリンクなどがある。  

ここで分類のために新たな定義を導入する。
1. Item covariates: 計画行列 $X$ もしくは $Z$ のどちらか/両方における，列（各ユニット）の要素が項目間で異なるが受検者間では共通している
2. Person covariates: 逆に項目間では共通だが，受検者間で異なる。
3. Person-by-Item covariates: 項目間でも受検者間でもバラバラ。

このなかで1は線形ロジスティックテストモデル (LLTM, Fisher, 1973) にあたる。2は潜在変数 $\theta$ が受検者に関する共変量の線形結合で表されるモデルと一致する。3はdynamic Rasch Modelに一致する。なお余談ではあるが，さらにこれを発展させたモデルがEMEIRTである。  

#### 項目に関する共変量だけをユニット間で変化させたモデル
　基本はラッシュモデル $\eta_{ni} =  \theta_n + \beta_i$   
※ただしここでの添え字は受検者が $i$ で項目が $j$ であることに注意。  
　このとき一般化線形混合モデルの一般系における計画行列は，項目に関する $X_n$ は $I \times I$ の単位行列になる。受検者の潜在特性値に関連する計画行列 $Z_n$ は $N \times 1$ の単位列ベクトルとなる。

　これをやや発展させたものがLLTMである。LLTMにおいて $X_n$は単位行列ではない。$X_n$ の列要素は項目の共変量にあたり，weight と basic という2種類のパラメタからなる。
