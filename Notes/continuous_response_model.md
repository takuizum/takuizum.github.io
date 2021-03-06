# Continuous Response Model

### 2019/04/08 Takumi Shibuya

#### 連続反応モデル(Continuous Response Model)とは
　段階反応モデル（多段階反応モデル，Graded Response Model)の段階を連続にしたモデル。0から1の得点の間にm+1個の下位カテゴリ(sub-category)に分ける。これらの下位カテゴリはすべてsub-intervalによって等間隔であると仮定される。  
　CRMにおける得点は，上記のように0から1までの連続尺度得点として考えられる。そのため通常の質問紙調査で用いられるようなリッカート法とは異なり，受検者は，たとえば「全くそう思わない」（0）から「とてもそう思う」（1）の2点の間にひかれた直線上の任意の値のどこかにチェックをすることになる。ただし0と1の両端には回答してはならない（open response situationの場合）。clozed response situationの場合の反応得点は，$0 \le z_g \le 1$と表現される。open response であれば等号が不要となる。  
　反応確率は通常のIRTモデルと同様であり，単調増加の，正規累積分布関数かそれを良く近似するロジスティック関数でモデリングされる。CRMでは確率と同様で，ある一点($z_g$)に反応する確率は0であり，確率は確率密度で定義される。  
　GRMと大きく異なる点は，段階ごとに項目パラメタをモデリングするのではなく，項目反応自体を連続値として扱うことで推定すべきパラメタを少数に抑えている点である。    
　$z_g$における正規累積分布関数の反応確率(モデルの解釈の上では，$z_g$以上の反応をする確率) $P_{z_g}^\ast(\theta)$ は，
$$
\begin{eqnarray}
P_{z_g}^\ast(\theta)=\int_{-\infty}^{a_g(\theta-b_{z_g})}\psi_g(t)dt\\
\left\{
\begin{array}\\
\lim_{\theta \to -\infty}P_{z_g}^\ast(\theta)&=&0\\
\lim_{\theta \to \infty}P_{z_g}^\ast(\theta)&=&1
\end{array}
\right.
\end{eqnarray}
$$
と表され， $z_g$ の反応確率は，微少区間 $\Delta$ を用いて，
$$
\begin{eqnarray}
H_{z_g}(\theta) &=& \lim_{\theta \to \infty}\frac{P^\ast_{z_g}(\theta)-P^\ast_{z_g+Δz_g}(\theta)}{Δz_g}\\
&=&a_g \psi_g\{a_g(\theta - b_g)\}\frac{d}{dz_g}b_{z_g}
\end{eqnarray}
$$
となる。なお $\theta$が大きくなるほど，正答確率は限りなく１に近づく。上記のように，微小区間デルタの確率をスコア$z_g$に対するoperating density characteristicとよぶ。この確率密度は，いわばGRMにおけるICCをある $\theta$ 一点で切断したときの，断各カテゴリの断面図を示していると考えることができる。 $H_{z_g}(\theta)$ は$z_g$の区間$0 \le z_g \le 1$ で積分すると１になる。かつ，
$$
\begin{eqnarray}
\left\{
\begin{array}\\
\lim_{z_g \to 0}b_{z_g}&=&-\infty\\
\lim_{z_g \to 1}b_{z_g}&=&\infty
\end{array}
\right.
\end{eqnarray}
$$
を満たす。これは $z_g$ に対応する困難度パラメタにあたるパラメタの範囲を示している。さらに，
$$
\begin{eqnarray}
\lim_{z_g \to 0}\frac{d}{dz_g}b_{z_g} = \lim_{z_g \to 1}\frac{d}{dz_g}b_{z_g} = \infty
\end{eqnarray}
$$
である。つまり$z_gf$について $b_{z_g}$ は狭義の単調増加である。ここで $b_{z_g}$ をあらたに，
$$
b_{z_g} = \frac{1}{a_g}\left\{\ln{(z_g)}-\ln{(1-z_g)}+\beta\right\}
$$
と定義する。この関数は，受検者の反応 $z_g$ に対応する連続量 $b_{z_g}$ を推定するための逆ロジスティック関数である。必ずしもこの関数形である必要はない。この関数の選び方としてSamejima (1973) は,

1. 単調増加の関数であり，
2. すべての $z_g$ において偏微分が0にならない，
3. $z_g$ が有限であるのに対し， $b_{z_g}$ は無限なので，二者の関係は線形ではない，

というような条件を述べている。  

　CRMにおける情報量は，基本的にGRMにおける情報量の導出と同じである。まず $\theta$ を固定したときの，カテゴリ $z_g$ における情報量の期待値を，その項目の情報量であると考える。すなわち，
$$
I_{z_g}(\theta) = -\frac{\partial^2}{\partial\theta^2}\left[ \ln{H_{z_g}(\theta)}\right]
$$
であるとき，
$$
\begin{eqnarray}
I_g(\theta) &=& E\left[I_{z_g}(\theta)\right]\\
 &=& \int_0^1 I_{z_g}H_{z_g}dz_g\\
 &&[置換積分]
 &=& \int_{-\infty}^{\infty}I_{z_g}a_g\psi_g{a_g(\theta - b_{z_g})}db_{z_g}
\end{eqnarray}
$$
と計算される。

#### 段階反応モデルとの関連
　段階反応モデル(GRM)がカテゴリごとの反応曲線のパラメタを推定しようとしているのに対し，CRMはパラメタを推定するための関数のパラメタを推定している。この点で二者は異なるが，CRMの考え方を応用して，GRMにおいてカテゴリ数が増えすぎた際に観測されないカテゴリが生じるという問題に，一つの対処法を考えることができる。  
##### GRMにおけるカテゴリ数設定の問題
　GRMでは，理論上はカテゴリ数に制限は存在しないため，CRMモデルに適用するようなカテゴリ数が非常に多いデータであっても適用可能である。しかし，カテゴリ数が増加すれば，各カテゴリのパラメタを推定するために求められるなサンプルサイズも大きくなってしまう上に，サンプルサイズの不足した状態でパラメタを推定すると，必然的にパラメタの推定の標準誤差も大きくなってしまう。どのくらいの標本数があれば何カテゴリまで推定できるかという問題は，項目や受検者集団の特性とあいまって一様に決定することは難しいが，数百から数千人規模のテスト・アンケートデータの順序反応を安定して分析するためには，せいぜい7カテゴリ程度が限界であろう。  
　カテゴリ数を多くしすぎることによる別の問題として，度数0のカテゴリが生じる可能性が高くなるということが指摘できる。記述式答案やスピーキングテストの採点などでは受検者のスコアは，いくつかの基準にしたがって，数個のカテゴリに属する様な形で決定される。アチーブメントの設定とその数によっては，両端の極端なカテゴリに属する受検者は存在しにくいケースは往々にしてあり得る。またアンケート調査などでも質問項目によっては極端な回答，あるいは中間的な反応を観測しにくい場合がある。このようなデータに対する対処法として本稿では，各カテゴリをGRMのパラメタ推定が可能な程度のカテゴリ数に併合し，そのデータによる推定値と観測データを基に，併合したカテゴリのパラメタを適当な関数で予測する方法を提案する。  

##### 期待テスト得点と項目カテゴリパラメタの関係  
  まず,観測されないカテゴリ $c$ と隣接するカテゴリ($c-1$, $c+1$)は観測できている状況について考える。この場合，段階反応モデルの順序尺度についての仮定から， $k$ の項目カテゴリパラメタは $c-1$ よりも大きく，$c+1$ よりも小さいことが分かる。次に，GRMにおける期待テスト得点について考えると，期待テスト得点は $\theta$ 全域における各カテゴリに反応する期待値であるため，ICCが単調増加であればTCCも単調増加が保証される。この期待テスト得点と $\theta$ の対応を示す曲線を回帰直線とみなすと，推定された項目パラメタをパラメタに持つパラメトリックな関数であることが分かる。  
　ところで，IRTにおける $\theta$ と項目カテゴリパラメタ $b_{jk}$ は同一心理的連続体上の値である。特に，GRMにおける項目パラメタは，最大，最小のカテゴリのパラメタを除いて，IRCCCが最大となる点に対応している。最大，最小のカテゴリのパラメタは，そのカテゴリ以上の反応となる確率を示すBCCがちょうど0.5となる位置の $\theta$ に一致している。しかしながら，期待得点と $\theta$ の対応を表す関数（以後，期待項目得点関数）は厳密にGRMの項目パラメタ $b_{jk}$ と対応しているわけではない。  
　いま，カテゴリ $c$ $(0 \leq c \leq K_j)$ の反応が観測されていない状況を仮定しているので，カテゴリ $c$ を除いた項目 $j$ の期待項目得点関数を $E_j(\theta)$ とおく。期待項目得点関数は，
$$
\begin{eqnarray}
E_j(\theta) &=& \sum_{k = 0}^{K_j} kP_{jk}(\theta)\\
&=& \sum_{k = 1}^{K_j}P^\ast_{jk}(\theta)
\end{eqnarray}
$$
と表現される。ただし， $P_{jk}(\theta)$ はカテゴリ特性曲線， $P^\ast_{jk}(\theta)$ は境界特性曲線(Boundary Characteristic Curve, BCC)であり，GRMの仮定から，
$$
P^\ast_{j0}(\theta) = 1\\
P^\ast_{jK_j}(\theta) = 0
$$
である。なお $k=0$ の期待値は当然0となるため，期待項目得点関数から $P^\ast_{j0}(\theta)$ はなくなる。先ほど述べたように，期待項目得点の期待得点と各カテゴリの項目パラメタには何らかの解析的な関係があるわけではない。そこでまず，仮にカテゴリ $c$ が観測されたときの期待得点関数 $E_j^\ast(\theta)$ とおき，ふたつの期待テスト得点の差を計算することで，以下のように，カテゴリ $c$ のBCCだけを取り出すことを考える。
$$
\begin{eqnarray}
E_j^\ast(\theta) - E_j(\theta) &=& \sum_{k = 1}^{K_j＋1}P^\ast_{jk}(\theta) - \sum_{k = 1}^{K_j}P^\ast_{jk}(\theta)\\
&=& P^\ast_{jc}(\theta)
\end{eqnarray}
$$
これにより期待項目得点関数の差から，知りたいカテゴリのBCCを計算することができる。BCCの困難度パラメタはGRMの困難度パラメタと，
$$
b_{jk} = \frac{b^\ast_{jk} + b^\ast_{jk+1}}{2}
$$
という関係があるため，BCCの困難度パラメタから本当に知りたいGRMの困難度パラメタを計算することは容易である。
##### カテゴリ $c$ を観測した場合の期待項目得点関数の推定
　先に説明した方法でカテゴリ $c$ の困難度パラメタを得るためには，カテゴリ $c$ を観測した場合の期待得点関数 $E_j^\ast(\theta)$ を何らかの方法で推定しなくてはならない。類似したアイディアで，観測得点から項目パラメタを予測する関数を設定し，そのパラメタを推定しているのが，実はCRMである。しかしCRMでSamejimaが用いた逆ロジスティック関数には理論的な根拠が示されていない。GRMはカテゴリ間の感覚に順序の制約しかおかないモデルであるため，出力が非線形な関数を当てはめるのは適当であるが，逆ロジスティック関数は中心から離れるほどに傾きが急になるため，最大カテゴリのパラメタを予測する場合には不適切な設定になりかねない。
　期待得点関数は基本的に回帰式であるため，単調増加という制約を満たす形であれば，逆ロジスティック関数に限らず，任意の回帰直線で近似することが可能である。入力データから出力データを予測する回帰直線を推定する問題においては，簡易的な手法として多項回帰フィッティングが用いられている。期待得点関数の近似として，この多項回帰直線に単調増加の制約を課したものを用いることもできるだろう。ただし，入力データ点に関しては，項目 $j$ の項目パラメタだけではデータ数が少なすぎるため，項目パラメタと期待得点ではなく，受検者の能力パラメタの推定値 $\hat{\theta}$ とそれに対応する観測項目得点を利用して，オーバーフィッティングを防ぐことができる。ただしこの方法を用いると $\hat{\theta}$ の推定誤差を無視して関数のパラメタを推定してしまうことには注意が必要である。
