# Continuous Response Model

### 2019/04/08 Takumi Shibuya

## 連続反応モデル(Continuous Response Model)とは
　段階反応モデル（多段階反応モデル，Graded Response Model)の段階を連続にしたモデル。0から1の得点の間にm+1個の下位カテゴリ(sub-category)に分ける。これらの下位カテゴリはすべてsub-intervalによって等間隔であると仮定される。  
　CRMにおける得点は，上記のように0から1までの連続尺度得点として考えられる。そのため通常の質問紙調査で用いられるようなリッカート法とは異なり，受検者は，たとえば「全くそう思わない」（0）から「とてもそう思う」（1）の2点の間にひかれた直線上の任意の値のどこかにチェックをすることになる。ただし0と1の両端には回答してはならない（open response situationの場合）。clozed response situationの場合の反応得点は，$0 \le z_g \le 1$と表現される。open response であれば等号が不要となる。  
　反応確率は通常のIRTモデルと同様であり，単調増加の，正規累積分布関数かそれを良く近似するロジスティック関数でモデリングされる。CRMでは確率と同様で，ある一点($z_g$)に反応する確率は0であり，確率は確率密度で定義される。  
　GRMと大きく異なる点は，段階ごとに項目パラメタをモデリングするのではなく，項目反応自体を連続値として扱うことで推定すべきパラメタを少数に抑えている点である。    
　$z_g$における正規累積分布関数の反応確率(モデルの解釈の上では，$z_g$以上の反応をする確率)を $P_{z_g}^\ast(\theta)$ とすると，
$$
\begin{eqnarray}
P_{z_g}^\ast(\theta)=\int_{-\infty}^{a_g(\theta-b_{z_g})}\psi_g(t)dt\\
\left\{
\begin{array}
\lim_{\theta \to -\infty}P_{z_g}^\ast(\theta)&=&0\\
\lim_{\theta \to \infty}P_{z_g}^\ast(\theta)&=&1
\end{array}
\right.
\end{eqnarray}
$$
であり，
$$
\begin{eqnarray}
H_{z_g}(\theta) &=& \lim_{\theta \to \infty}\frac{P^\ast_{z_g}(\theta)-P^\ast_{z_g+Δz_g}(\theta)}{Δz_g}\\
&=&a_g \psi_g\{a_g(\theta - b_g)\}\frac{d}{dz_g}b_{z_g}
\end{eqnarray}
$$
となる。つまり $\theta$が大きくなるほど，正答確率は限りなく１に近づく。  
　上記のように，微小区間デルタの確率をスコア$z_g$に対するoperating density characteristicとよぶ。$H_{z_g}(\theta)$ は$z_g$の区間$0 \le z_g \le 1$ で積分すると１になる。かつ，
$$
\begin{eqnarray}
\left\{
\begin{array}
\lim_{z_g \to 0}b_{z_g}&=&-\infty\\
\lim_{z_g \to 1}b_{z_g}&=&\infty
\end{array}
\right.
\end{eqnarray}
$$
を満たす。これは困難度パラメタにあたるパラメタの範囲を示している。さらに，
$$
\begin{eqnarray}
\lim_{z_g \to 0}\frac{d}{dz_g}b_{z_g} = \lim_{z_g \to 1}\frac{d}{dz_g}b_{z_g} = \infty
\end{eqnarray}
$$
である。つまり$z_gf$について$b_{z_g}は狭義の単調増加である。ここで$b_{z_g}$をあらたに，
$$
b_{z_g} = \frac{1}{a_g}\left\{\ln{(z_g)}-\ln{(1-z_g)}+\beta\right\}
$$
