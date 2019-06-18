## 一般化線形混合モデル  
  $~$  
　線形予測子 (linear predictor) およびリンク関数 (link function)，切片，傾き（パラメタ），変量（共編量）がおもなモデルの構成要素。これと確率モデルから，一般化線形モデルな成り立っている。  

$$
\begin{eqnarray}
  y &=& \bf \beta X + \epsilon \\
  g(E[y]) &=& \bf \beta X \qquad (E[y] = \mu)\\
  y &\sim& P(\bf \beta X | \theta)
\end{eqnarray}
$$
$~$  
　よく名前の似ているモデルである一般線形モデルはidentity link functionと等分散の正規分布を仮定したモデルである。分散分析は受検者をランダム効果とし，要因を固定効果とみなし，誤差が等分散の正規分布に従うと仮定した一般化線形モデルの下位モデル。  
　GLMでよく用いられる確率分布
1. Gauss 連続，$[-\infty , \infty]$
    - $f(x)=\frac{1}{\sqrt{2 \pi \sigma^{2}}} \exp \left(-\frac{(x-\mu)^{2}}{2 \sigma^{2}}\right) \quad(x \in \mathbb{R})$
2. Poisson 離散，非負
    - $P(X=k)=\frac{\lambda^{k} e^{-\lambda}}{k !}$
3. Gamma  連則，非負
    - $f(x)=\frac{1}{\Gamma(k) \theta^{k}} x^{k-1} e^{-x / \theta} \quad \text { for } x>0$
4. binomial(Bernoulli)　連続，[0, 1]
    - $P(X=1)=p, \qquad P(X=0)=q=1-p$

　おなじく，よく用いられるリンク関数

1. Identity
1. log
2. logit
3. probit
4. $-log[-log(\pi)]$ : Log-Log(Complementary Log-Log)
    - logitやprobitは確率0.5のところで左右対称だった。それを左右非対称にしたもの。がんベル分布の累積分布関数の逆関数における特殊形。IRTの識別力にあたるパラメタが入ったものがC-loglog。[ref](http://www.stat.ualberta.ca/~kcarrier/STAT562/comp_log_log)

　一般化線形モデルでは観測データに対して適用される確率分布はひとつであった。それをランダム効果と固定効果という二つの変量に分解し，それぞれ異なる確率分布を適用しようとするのが一般化線形モデルである。  
$$
g(E[y_{ij}|\textbf{u}_i]) = \bf x_{ij}\beta+\it z_{ij} \bf u_{i} \it \qquad i =  1, ..., n \qquad j = 1, ..., d
$$
$~$
　似たような形式のデータを扱うモデルにmarginal modelというものがあるようだ by Agresti GLM。Marginal modelでは受検者ひとり似たいする複数の測定を同時分布として扱って，その積をもって尤度を構成する。予測変数の間には相関を考慮するために多変量正規分布が仮定される。つまり，同時分布から多変量積分布によりランダム効果の部分を周辺消去したモデルである。その点で言えばGLMMの固定効果とおなじリンク関数で構成されるモデルである。なお，離散変数の場合には正規分布は仮定できない。（また，実際の計算にはquasi尤度とsandwich covariance matrixが用いられる？？？）周辺化モデル（とここでは呼ぼう）が有効なケースは，郡内の個人間の変動には興味がなく，群間の差（e.g. 処置群と対照群の比較）のみに興味がある場合である。基本的には GLMM > Marginal Model と解釈してよさそう。
