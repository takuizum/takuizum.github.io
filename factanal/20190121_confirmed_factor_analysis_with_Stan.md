# Workstation of takuizum

20190121\_Confirmed\_Factor\_Analysis
================
T.SHIBUYA
2019/1/21
Turn to [home](index.html)

# Stanで確認的因子分析

# What’s Comfirmed Factor Analysis(CFA) ?

探索的因子分析(Explanatory Factor
Analysis)はすべての変量に対して，すべての因子が影響している（因子負荷が0ではない）を仮定していた。

この方法は事前に因子構造の検討がついていないときに，どの項目に対してどの因子が大きく負荷しているかを検討する上では役に立ったが，仮説や既存のモデルの適合度(fit)を検討することには不向きであった。

CFAはある変量は特定の因子だけに寄与し，それ以外には寄与しない（因子負荷が0）という制約をおいたモデル＝分析者の仮説的なモデルがどの程度フィットしているのか，適合度を計算できる。

## 基本的なモデル

基本的なモデルはEFAと同じで，

\[
Z = F'A + \Psi
\]

である。ただし，独自性に関する項を\(\Psi\)とおいた。

このとき因子負荷行列\(A\)は変量数\(\times\)因子数の大きさの行列だが，その要素はEFAの時とは異なり，

\[
  A = \left[
    \begin{array}{cccc}
      a_{11} & 0\\
      a_{21} & 0\\
      \vdots & \vdots\\
      0 & a_{m2}
    \end{array}
  \right]
\]

というように，特定の位置に0を含む行列となる（※上の図は二因子を想定している）。

## CFAを実行できる環境

  - SPSS(Amos)　有料
  - M*plus*　有料
  - R(`lavaan`, `blavaan`など)　無料
  - Stan 無料

今回は下ふたつで分析してみる。

## lavaan

  - Fit a Latent Variable Model
  - 12 authers develop this package.
  - [About lavaan](http://lavaan.ugent.be/)
  - SEM (Structure Equation Model) 分析パッケージの一種

今回は確認的因子分析に使うが，本当は上位のSEMも取り扱えるパッケージ。

### すごいところ

  - 商用のソフトウェアM\_plus\_に似せた結果をアウトプット可能
  - 最尤法，最小二乗法，一般化最小二乗法など数種類のアルゴリズムを搭載
  - 欠測値（FIML）も扱え，階層的なモデルや非線形モデル，カテゴリカルデータにも対応している
  - 簡単なモデルであれば，文法もそんなに難しくない

## CFA Analysis

最初に，後々のグラフ出力のことを考えて，データの変数名を全角から半角の英語表記にする。

``` r
# replace s-jis to utf-8 because it is not able to use in `qgraph` pkg.
data <- data %>% dplyr::rename(English=英語, Japanese=現代文, Classic=古典, Math=数学, Physics=物理, Geometry=地学)
head(data)
```

```
  English Japanese Classic Math Physics Geometry
1      31       31      33   59      63       52
2      72       77      60   50      51       68
3      34       27      47   34      33       20
4      44       44      54   43      35       48
5      58       57      54   45      61       63
6      35       38      34   18      31       27
```

その後，`lavaan`の`cfa`パッケージで分析。

``` r
library(lavaan)
```

    This is lavaan 0.6-3

    lavaan is BETA software! Please report any bugs.

``` r
# model
cfa_model <- '
  F1 =~ English + Japanese + Classic
  F2 =~ Math + Physics + Geometry
'

res_lav <- cfa(cfa_model, data = data, std.lv = TRUE)
```

適合度も含め，推定値や統計量の確認をする。

``` r
res_lav %>% summary(fit.measure = T, standardized = T)
```

    lavaan 0.6-3 ended normally after 18 iterations

      Optimization method                           NLMINB
      Number of free parameters                         13

      Number of observations                          1000

      Estimator                                         ML
      Model Fit Test Statistic                     111.070
      Degrees of freedom                                 8
      P-value (Chi-square)                           0.000

    Model test baseline model:

      Minimum Function Test Statistic             4263.724
      Degrees of freedom                                15
      P-value                                        0.000

    User model versus baseline model:

      Comparative Fit Index (CFI)                    0.976
      Tucker-Lewis Index (TLI)                       0.955

    Loglikelihood and Information Criteria:

      Loglikelihood user model (H0)             -22637.391
      Loglikelihood unrestricted model (H1)     -22581.857

      Number of free parameters                         13
      Akaike (AIC)                               45300.783
      Bayesian (BIC)                             45364.584
      Sample-size adjusted Bayesian (BIC)        45323.295

    Root Mean Square Error of Approximation:

      RMSEA                                          0.114
      90 Percent Confidence Interval          0.095  0.133
      P-value RMSEA <= 0.05                          0.000

    Standardized Root Mean Square Residual:

      SRMR                                           0.030

    Parameter Estimates:

      Information                                 Expected
      Information saturated (h1) model          Structured
      Standard Errors                             Standard

    Latent Variables:
                       Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
      F1 =~
        English          13.056    0.384   34.022    0.000   13.056    0.875
        Japanese         13.684    0.370   37.015    0.000   13.684    0.923
        Classic          12.553    0.390   32.156    0.000   12.553    0.843
      F2 =~
        Math             13.324    0.384   34.704    0.000   13.324    0.894
        Physics          12.885    0.388   33.178    0.000   12.885    0.868
        Geometry         12.209    0.399   30.630    0.000   12.209    0.821

    Covariances:
                       Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
      F1 ~~
        F2                0.533    0.026   20.640    0.000    0.533    0.533

    Variances:
                       Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
       .English          52.384    3.474   15.080    0.000   52.384    0.235
       .Japanese         32.736    3.140   10.425    0.000   32.736    0.149
       .Classic          64.405    3.755   17.154    0.000   64.405    0.290
       .Math             44.676    3.730   11.978    0.000   44.676    0.201
       .Physics          54.528    3.843   14.188    0.000   54.528    0.247
       .Geometry         71.858    4.216   17.042    0.000   71.858    0.325
        F1                1.000                               1.000    1.000
        F2                1.000                               1.000    1.000

``` r
# path diagram
# `semPlots` is more recomended than `qgraph`

# library(semPlot)
# semPaths(res_lav, what = "path")

# Cannot output graph

knitr::include_graphics("cfa_plot.png")
```

![](cfa_plot.png)<!-- -->

\(\chi^2\)検定の帰無仮説はモデルが正しいというものであり，標本数が大きければ\((n-1)*f_{ML}\)が自由度\(\frac{1}{2}n(n-1)-p\)の\(\chi^2\)分布に従うことを利用して検定をおこなっている。しかし，標本数が大きくなれば検定力が増大し帰無仮説が棄却されやすくなるため，検定以外の方法でモデルが適合しているかを判断する。

### CFI

CFI(Comparative Fit Index,
比較適合度指標)は分析したモデルと独立モデル（共分散行列が対角行列＝すべての変数が独立）を比較したときに，どれくらい分析したモデルが改善されているかを表している指標。1に近いほどよく，0.95を下回ると良くないとされる。

### LTI

TLI(Tukey-Lewis
Index)もCFIと同様に，分析モデルと独立モデルを比較したもので，1に近いほどよい。詳しくは[星野・岡田・前田
(2005)](https://www.jstage.jst.go.jp/article/jbhmk/32/2/32_2_209/_pdf)を参照されたい。

### AIC, BIC, sample size adjusted BIC (sBIC)

\-2\(times\)loglikelihood(negative twice
loglikelihood)をベースにしたモデル比較のための指標。情報量規準。変数や標本数が増えると途方もない数になるため，役に立たないこともある。

### RMSEA

RMSEA(Root Mean Square Error of
Approximation)はモデルの分布とデータ分布との乖離を1自由度あたりの量として計算したもの。言い換えれば，モデルの共分散構造と，標本共分散行列の相違度を自由度で割ったもの。0.05\~0.06以下ならば当てはまりが良く，0.1以上であれば当てはまりが悪いとされる。

### SRMR

SRMR(Stantdardized Root Mean-square
Resduals)。RMRは標本共分散行列とモデルから計算された共分散行列を要素ごとに平均したものであり，標準化したものがSRMRである。0に近いほど当てはまりがよく，0.08以下であれば良いとされる。

以上の適合度指標の観点からこのモデルはデータに十分にフィットしていると考えられる。

## Stan編

確率モデルを考えればStanでBayesian
CFAが実行できる。ただし，尺度の不定性には注意が必要で，相関行列のコレスキー因子を使って制約をかける必要がある。

[偉大なる先人](https://gist.github.com/mike-lawrence/dd2435f290a567bd1fd03370ee669688)のコードを丸コピーして，ちょっと表記を変えたものが以下のコード。

``` stan
// CFA
data {
  int N; // # of subjects
  int J; // # of variables
  matrix[N, J] X;  // data matrix
  int M; // # of latent traits
  int<lower = 1, upper = M> fm[J]; // # vector of which factor is associated with each variables
}

transformed data{
  matrix[N, J] Z; // outcums matrix
  for(j in 1:J){
    Z[, j] = (X[, j] - mean(X[, j])) / sd(X[, j]); // standardization
  }
}

parameters {
  matrix[M, N] f; // (helper)
  cholesky_factor_corr[M] C; // (helper)
  vector [J] mu;
  vector<lower = 0> [J] eps;
  vector<lower = 0> [J] A; // factor loadings(must be positive)
}

transformed parameters{
  matrix[N, M] F; // factor score
  F = (C * f)';
}

model{
  to_vector(f) ~ normal(0, 1);
  C ~ lkj_corr_cholesky(1); // for scale invariance
  mu ~ normal(0, 3);
  eps ~ weibull(2, 1);
  A ~ normal(0, 3);

  for(j in 1:J){
    Z[, j] ~ normal(mu[j] + F[, fm[j]] * A[j], eps[j]);
  }
}

generated quantities{
  corr_matrix[M] R;
  vector[J] item_means;
  vector[J] item_epsilon;
  R = multiply_lower_tri_self_transpose(C);
  for(j in 1:J){
    item_means[j] = mu[j]*sd(X[, j]) + mean(X[, j]);
    item_epsilon[j] = eps[j] * sd(X[, j]);
  }
}
```

コンパイルしたら，Rで走らせる。MCMCは時間がかかるので，まずはVBから実行する。

``` r
data_stan <- list(N = nrow(data), J = ncol(data), X = data, M = 2, fm = c(1,1,1,2,2,2))

# cfa_mod <- stan_model("cfa.stan")
res_vb <- rstan::vb(cfa_mod, data = data_stan)
```

    Chain 1: ------------------------------------------------------------
    Chain 1: EXPERIMENTAL ALGORITHM:
    Chain 1:   This procedure has not been thoroughly tested and may be unstable
    Chain 1:   or buggy. The interface is subject to change.
    Chain 1: ------------------------------------------------------------
    Chain 1:
    Chain 1:
    Chain 1:
    Chain 1: Gradient evaluation took 0.001 seconds
    Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 10 seconds.
    Chain 1: Adjust your expectations accordingly!
    Chain 1:
    Chain 1:
    Chain 1: Begin eta adaptation.
    Chain 1: Iteration:   1 / 250 [  0%]  (Adaptation)
    Chain 1: Iteration:  50 / 250 [ 20%]  (Adaptation)
    Chain 1: Iteration: 100 / 250 [ 40%]  (Adaptation)
    Chain 1: Iteration: 150 / 250 [ 60%]  (Adaptation)
    Chain 1: Iteration: 200 / 250 [ 80%]  (Adaptation)
    Chain 1: Success! Found best value [eta = 1] earlier than expected.
    Chain 1:
    Chain 1: Begin stochastic gradient ascent.
    Chain 1:   iter             ELBO   delta_ELBO_mean   delta_ELBO_med   notes
    Chain 1:    100      -862942.561             1.000            1.000
    Chain 1:    200     -1150194.815             0.625            1.000
    Chain 1:    300      -170746.346             2.329            1.000
    Chain 1:    400      -509193.648             1.913            1.000
    Chain 1:    500   -146579658.817             1.729            0.997
    Chain 1:    600     -4328987.878             6.918            1.000
    Chain 1:    700     -4893686.588             5.946            0.997
    Chain 1:    800     -1713635.599             5.435            1.000
    Chain 1:    900       -24446.786            12.508            1.000
    Chain 1:   1000     -2748177.488            11.357            1.000
    Chain 1:   1100      -728026.410            11.534            1.856   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1200  -444480569776.368            11.609            1.856   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1300  -1108179360.560            51.045            1.856   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1400     -2768987.447            90.899            2.775   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1500   -329876202.557            90.899            2.775   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1600    -18164333.878            89.329            2.775   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1700       -87452.758           109.988           17.161   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1800    -12800457.041           109.901           17.161   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   1900       -12640.180           204.160           17.161   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2000        -9481.635           204.094           17.161   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2100        -8131.260           203.833           17.161   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2200        -7913.918           203.736           17.161   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2300        -7726.611           163.729            0.993   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2400        -7713.097           123.808            0.992   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2500        -7704.360           123.709            0.333   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2600        -7666.394           121.994            0.166   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2700        -7616.302           101.324            0.027   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2800        -7457.662           101.227            0.024   MAY BE DIVERGING... INSPECT ELBO
    Chain 1:   2900        -7359.370             0.060            0.021
    Chain 1:   3000        -7593.683             0.030            0.021
    Chain 1:   3100        -7257.101             0.018            0.021
    Chain 1:   3200        -7607.515             0.020            0.021
    Chain 1:   3300        -9155.247             0.034            0.021
    Chain 1:   3400        -7188.231             0.061            0.031
    Chain 1:   3500        -8149.875             0.073            0.046
    Chain 1:   3600        -7514.723             0.081            0.046
    Chain 1:   3700        -7267.369             0.084            0.046
    Chain 1:   3800        -7244.566             0.082            0.046
    Chain 1:   3900        -7146.070             0.082            0.046
    Chain 1:   4000        -7225.704             0.080            0.046
    Chain 1:   4100        -7152.991             0.076            0.046
    Chain 1:   4200        -7159.542             0.072            0.034
    Chain 1:   4300        -7162.448             0.055            0.014
    Chain 1:   4400        -7137.090             0.028            0.011
    Chain 1:   4500        -7542.114             0.022            0.011
    Chain 1:   4600        -7243.006             0.017            0.011
    Chain 1:   4700        -7123.759             0.015            0.011
    Chain 1:   4800        -7134.077             0.015            0.011
    Chain 1:   4900        -7117.308             0.014            0.010
    Chain 1:   5000        -7105.033             0.013            0.004   MEDIAN ELBO CONVERGED
    Chain 1:
    Chain 1: Drawing a sample of size 1000 from the approximate posterior...
    Chain 1: COMPLETED.

``` r
print(res_vb, pars = c("R", "A"))
```

    Inference for Stan model: f776aabef4a74129df04b4e9b6d29e27.
    1 chains, each with iter=1000; warmup=0; thin=1;
    post-warmup draws per chain=1000, total post-warmup draws=1000.

           mean   sd 2.5%  25%  50%  75% 97.5%
    R[1,1] 1.00 0.00 1.00 1.00 1.00 1.00  1.00
    R[1,2] 0.33 0.01 0.30 0.32 0.33 0.33  0.35
    R[2,1] 0.33 0.01 0.30 0.32 0.33 0.33  0.35
    R[2,2] 1.00 0.00 1.00 1.00 1.00 1.00  1.00
    A[1]   0.23 0.64 0.00 0.03 0.07 0.20  1.45
    A[2]   0.92 0.01 0.89 0.91 0.92 0.92  0.94
    A[3]   0.86 0.02 0.83 0.85 0.86 0.87  0.89
    A[4]   0.80 0.01 0.77 0.79 0.79 0.81  0.83
    A[5]   0.77 0.02 0.74 0.76 0.77 0.78  0.81
    A[6]   0.74 0.02 0.71 0.73 0.74 0.75  0.77

    Approximate samples were drawn using VB(meanfield) at Mon Jan 21 20:12:32 2019.

    We recommend genuine 'sampling' from the posterior distribution for final inferences!

次はMCMCでちゃんと(genuine)サンプリングする。

``` r
stan.time <- system.time(
  res_mcmc <- rstan::sampling(cfa_mod, data = data_stan)
)
```

```

SAMPLING FOR MODEL 'f776aabef4a74129df04b4e9b6d29e27' NOW (CHAIN 1).
Chain 1:
Chain 1: Gradient evaluation took 0.001 seconds
Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 10 seconds.
Chain 1: Adjust your expectations accordingly!
Chain 1:
Chain 1:
Chain 1: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 1: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 1: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 1: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 1: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 1: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 1: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 1: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 1: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 1: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 1: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 1: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 1:
Chain 1:  Elapsed Time: 26.488 seconds (Warm-up)
Chain 1:                19.9 seconds (Sampling)
Chain 1:                46.388 seconds (Total)
Chain 1:

SAMPLING FOR MODEL 'f776aabef4a74129df04b4e9b6d29e27' NOW (CHAIN 2).
Chain 2:
Chain 2: Gradient evaluation took 0.001 seconds
Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 10 seconds.
Chain 2: Adjust your expectations accordingly!
Chain 2:
Chain 2:
Chain 2: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 2: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 2: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 2: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 2: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 2: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 2: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 2: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 2: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 2: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 2: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 2: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 2:
Chain 2:  Elapsed Time: 25.642 seconds (Warm-up)
Chain 2:                18.748 seconds (Sampling)
Chain 2:                44.39 seconds (Total)
Chain 2:

SAMPLING FOR MODEL 'f776aabef4a74129df04b4e9b6d29e27' NOW (CHAIN 3).
Chain 3:
Chain 3: Gradient evaluation took 0 seconds
Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 0 seconds.
Chain 3: Adjust your expectations accordingly!
Chain 3:
Chain 3:
Chain 3: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 3: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 3: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 3: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 3: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 3: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 3: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 3: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 3: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 3: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 3: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 3: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 3:
Chain 3:  Elapsed Time: 26.447 seconds (Warm-up)
Chain 3:                22.6 seconds (Sampling)
Chain 3:                49.047 seconds (Total)
Chain 3:

SAMPLING FOR MODEL 'f776aabef4a74129df04b4e9b6d29e27' NOW (CHAIN 4).
Chain 4:
Chain 4: Gradient evaluation took 0 seconds
Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 0 seconds.
Chain 4: Adjust your expectations accordingly!
Chain 4:
Chain 4:
Chain 4: Iteration:    1 / 2000 [  0%]  (Warmup)
Chain 4: Iteration:  200 / 2000 [ 10%]  (Warmup)
Chain 4: Iteration:  400 / 2000 [ 20%]  (Warmup)
Chain 4: Iteration:  600 / 2000 [ 30%]  (Warmup)
Chain 4: Iteration:  800 / 2000 [ 40%]  (Warmup)
Chain 4: Iteration: 1000 / 2000 [ 50%]  (Warmup)
Chain 4: Iteration: 1001 / 2000 [ 50%]  (Sampling)
Chain 4: Iteration: 1200 / 2000 [ 60%]  (Sampling)
Chain 4: Iteration: 1400 / 2000 [ 70%]  (Sampling)
Chain 4: Iteration: 1600 / 2000 [ 80%]  (Sampling)
Chain 4: Iteration: 1800 / 2000 [ 90%]  (Sampling)
Chain 4: Iteration: 2000 / 2000 [100%]  (Sampling)
Chain 4:
Chain 4:  Elapsed Time: 25.264 seconds (Warm-up)
Chain 4:                19.958 seconds (Sampling)
Chain 4:                45.222 seconds (Total)
Chain 4:
```

``` r
# check convergence
all(summary(res_mcmc)$summary[,"Rhat"]<1.10, na.rm=T)
```

    [1] TRUE

``` r
# trace plot
traceplot(res_mcmc, pars = "R")
```

![](09_confirmed_factor_analysis_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
traceplot(res_mcmc, pars = "A")
```

![](09_confirmed_factor_analysis_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
# check structure parameter
print(res_mcmc, pars = c("R", "A"))
```

    Inference for Stan model: f776aabef4a74129df04b4e9b6d29e27.
    4 chains, each with iter=2000; warmup=1000; thin=1;
    post-warmup draws per chain=1000, total post-warmup draws=4000.

           mean se_mean   sd 2.5%  25%  50%  75% 97.5% n_eff Rhat
    R[1,1] 1.00     NaN 0.00 1.00 1.00 1.00 1.00  1.00   NaN  NaN
    R[1,2] 0.53       0 0.03 0.48 0.51 0.53 0.55  0.58  1107    1
    R[2,1] 0.53       0 0.03 0.48 0.51 0.53 0.55  0.58  1107    1
    R[2,2] 1.00       0 0.00 1.00 1.00 1.00 1.00  1.00  3882    1
    A[1]   0.88       0 0.03 0.83 0.86 0.88 0.89  0.93  1137    1
    A[2]   0.92       0 0.03 0.87 0.91 0.92 0.94  0.97  1003    1
    A[3]   0.84       0 0.03 0.79 0.83 0.84 0.86  0.90  1453    1
    A[4]   0.90       0 0.03 0.85 0.88 0.90 0.91  0.94  1372    1
    A[5]   0.87       0 0.03 0.82 0.85 0.87 0.89  0.92  1570    1
    A[6]   0.82       0 0.03 0.77 0.80 0.82 0.84  0.88  1883    1

    Samples were drawn using NUTS(diag_e) at Mon Jan 21 20:15:50 2019.
    For each parameter, n_eff is a crude measure of effective sample size,
    and Rhat is the potential scale reduction factor on split chains (at
    convergence, Rhat=1).

本当はEMアルゴリズムで付随(incidental)母数を積分消去してから推定すると，速度も速く，推定結果も一致性があるため望ましい。Stanでも周辺化してから推定するコードを書くことができるようだが，それはまた今度。


Turn to [home](index.html)
