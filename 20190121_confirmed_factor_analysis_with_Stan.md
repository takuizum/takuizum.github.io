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

  - 商用のソフトウェアM*plus*に似せた結果をアウトプット可能
  - 最尤法，最小二乗法，一般化最小二乗法など数種類のアルゴリズムを搭載
  - 欠測値（FIML）も扱え，階層的なモデルや非線形モデル，カテゴリカルデータにも対応している
  - 簡単なモデルであれば，文法もそんなに難しくない

## CFA Analysis

最初に，後々のグラフ出力のことを考えて，データの変数名を全角から半角の英語表記にする。あわせて標準化も`scale()`でおこなう。

``` r
# replace s-jis to utf-8 because it is not able to use in `qgraph` pkg.
data <- data %>% dplyr::rename(English=英語, Japanese=現代文, Classic=古典, Math=数学, Physics=物理, Geometry=地学)
# std
std_data <- data %>% scale() %>% data.frame()
head(std_data)
```

``` 
     English   Japanese    Classic        Math    Physics    Geometry
1 -1.1882617 -1.2070183 -1.0677139  0.62885750  0.9190711  0.19460904
2  1.5569194  1.8929115  0.7435625  0.02541177  0.1114515  1.27054013
3 -0.9873948 -1.4765774 -0.1285335 -1.04738064 -1.0999779 -1.95725315
4 -0.3178384 -0.3309512  0.3410567 -0.44393491 -0.9653746 -0.07437374
5  0.6195405  0.5451159  0.3410567 -0.30983586  0.7844678  0.93431166
6 -0.9204392 -0.7352899 -1.0006296 -2.12017304 -1.2345812 -1.48653330
```

その後，`lavaan`の`cfa()`で分析。

モデルの記述は`=~`と`+`でおこなう。

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

res_lav <- cfa(cfa_model, data = std_data, std.lv = TRUE)
```

適合度も含め，推定値や統計量の確認をする。

``` r
res_lav %>% summary(fit.measure = T, standardized = T)
```

    lavaan 0.6-3 ended normally after 24 iterations
    
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
    
      Loglikelihood user model (H0)              -6434.303
      Loglikelihood unrestricted model (H1)      -6378.768
    
      Number of free parameters                         13
      Akaike (AIC)                               12894.605
      Bayesian (BIC)                             12958.406
      Sample-size adjusted Bayesian (BIC)        12917.117
    
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
        English           0.874    0.026   34.022    0.000    0.874    0.875
        Japanese          0.922    0.025   37.015    0.000    0.922    0.923
        Classic           0.842    0.026   32.156    0.000    0.842    0.843
      F2 =~                                                                 
        Math              0.893    0.026   34.704    0.000    0.893    0.894
        Physics           0.867    0.026   33.178    0.000    0.867    0.868
        Geometry          0.821    0.027   30.630    0.000    0.821    0.821
    
    Covariances:
                       Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
      F1 ~~                                                                 
        F2                0.533    0.026   20.640    0.000    0.533    0.533
    
    Variances:
                       Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
       .English           0.235    0.016   15.080    0.000    0.235    0.235
       .Japanese          0.149    0.014   10.425    0.000    0.149    0.149
       .Classic           0.290    0.017   17.154    0.000    0.290    0.290
       .Math              0.201    0.017   11.978    0.000    0.201    0.201
       .Physics           0.247    0.017   14.188    0.000    0.247    0.247
       .Geometry          0.325    0.019   17.042    0.000    0.325    0.325
        F1                1.000                               1.000    1.000
        F2                1.000                               1.000    1.000

``` r
# path diagram
# `semPlots` is more recomended than `qgraph`

library(semPlot)
```

    Warning: package 'semPlot' was built under R version 3.5.2

``` r
semPaths(res_lav, what = "path")
```

![](09_confirmed_factor_analysis_files/figure-gfm/result-1.png)<!-- -->

``` r
# if the graph cannot be output

# knitr::include_graphics("cfa_plot.png")
```

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

ただしStanでは確率モデルを扱うため，モデルは，

\[
X \sim Normal(\mu+\Lambda'\theta, \epsilon)
\] である。ただし， \[
\mu \sim Normal(0,3)
\] \[
\Lambda \sim Normal(0,3)
\] \[
\theta \sim Normal(0, 1)
\] \[
\epsilon \sim weible(2, 1)
\]

である。

このとき，因子負荷行列には回転の不定性があるためコレスキー因子相関行列を使って，第一変量の因子負荷が正となるように制約をかけておく。コレスキー因子相関行列の事前分布については[こちら](https://www.psychstatistics.com/2014/12/27/d-lkj-priors/)を参照されたい。

## Stan code

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
  matrix[N, M] theta; // factor score
  theta = (C * f)';
}

model{
  to_vector(f) ~ normal(0, 1);
  C ~ lkj_corr_cholesky(1); // prior for cholesky factor cor
  mu ~ normal(0, 3);
  eps ~ weibull(2, 1);
  A ~ normal(0, 3);
  
  for(j in 1:J){
    Z[, j] ~ normal(mu[j] + theta[, fm[j]] * A[j], eps[j]);
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
    Chain 1:    100       -14991.777             1.000            1.000
    Chain 1:    200        -7492.206             1.000            1.001
    Chain 1:    300        -6831.731             0.699            1.000
    Chain 1:    400        -6735.248             0.528            1.000
    Chain 1:    500        -6709.212             0.423            0.097
    Chain 1:    600        -6676.631             0.353            0.097
    Chain 1:    700        -6683.178             0.303            0.014
    Chain 1:    800        -6676.936             0.265            0.014
    Chain 1:    900        -6660.238             0.236            0.005   MEDIAN ELBO CONVERGED
    Chain 1: 
    Chain 1: Drawing a sample of size 1000 from the approximate posterior... 
    Chain 1: COMPLETED.

``` r
print(res_vb, pars = c("R", "A"))
```

    Inference for Stan model: c4a40178ede4cfb697c44fa20c54b029.
    1 chains, each with iter=1000; warmup=0; thin=1; 
    post-warmup draws per chain=1000, total post-warmup draws=1000.
    
           mean   sd 2.5%  25%  50%  75% 97.5%
    R[1,1] 1.00 0.00 1.00 1.00 1.00 1.00  1.00
    R[1,2] 0.37 0.01 0.34 0.36 0.37 0.38  0.39
    R[2,1] 0.37 0.01 0.34 0.36 0.37 0.38  0.39
    R[2,2] 1.00 0.00 1.00 1.00 1.00 1.00  1.00
    A[1]   0.82 0.01 0.79 0.81 0.82 0.82  0.84
    A[2]   0.84 0.01 0.82 0.84 0.84 0.85  0.87
    A[3]   0.81 0.02 0.78 0.80 0.81 0.83  0.85
    A[4]   0.76 0.01 0.73 0.75 0.76 0.77  0.78
    A[5]   0.75 0.01 0.73 0.74 0.75 0.76  0.78
    A[6]   0.71 0.02 0.67 0.69 0.71 0.72  0.74
    
    Approximate samples were drawn using VB(meanfield) at Tue Jan 22 13:29:06 2019.

    We recommend genuine 'sampling' from the posterior distribution for final inferences!

次はMCMCでちゃんと(genuine)サンプリングする。

``` r
stan.time <- system.time(
  res_mcmc <- rstan::sampling(cfa_mod, data = data_stan)
)
```

``` 

SAMPLING FOR MODEL 'c4a40178ede4cfb697c44fa20c54b029' NOW (CHAIN 1).
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
Chain 1:  Elapsed Time: 16.338 seconds (Warm-up)
Chain 1:                12.958 seconds (Sampling)
Chain 1:                29.296 seconds (Total)
Chain 1: 

SAMPLING FOR MODEL 'c4a40178ede4cfb697c44fa20c54b029' NOW (CHAIN 2).
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
Chain 2:  Elapsed Time: 17.038 seconds (Warm-up)
Chain 2:                12.512 seconds (Sampling)
Chain 2:                29.55 seconds (Total)
Chain 2: 

SAMPLING FOR MODEL 'c4a40178ede4cfb697c44fa20c54b029' NOW (CHAIN 3).
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
Chain 3:  Elapsed Time: 16.15 seconds (Warm-up)
Chain 3:                12.979 seconds (Sampling)
Chain 3:                29.129 seconds (Total)
Chain 3: 

SAMPLING FOR MODEL 'c4a40178ede4cfb697c44fa20c54b029' NOW (CHAIN 4).
Chain 4: 
Chain 4: Gradient evaluation took 0.001 seconds
Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 10 seconds.
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
Chain 4:  Elapsed Time: 17.401 seconds (Warm-up)
Chain 4:                13.425 seconds (Sampling)
Chain 4:                30.826 seconds (Total)
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

    Inference for Stan model: c4a40178ede4cfb697c44fa20c54b029.
    4 chains, each with iter=2000; warmup=1000; thin=1; 
    post-warmup draws per chain=1000, total post-warmup draws=4000.
    
           mean se_mean   sd 2.5%  25%  50%  75% 97.5% n_eff Rhat
    R[1,1] 1.00     NaN 0.00 1.00 1.00 1.00 1.00  1.00   NaN  NaN
    R[1,2] 0.53       0 0.03 0.48 0.52 0.53 0.55  0.58   936    1
    R[2,1] 0.53       0 0.03 0.48 0.52 0.53 0.55  0.58   936    1
    R[2,2] 1.00       0 0.00 1.00 1.00 1.00 1.00  1.00  3859    1
    A[1]   0.88       0 0.03 0.83 0.86 0.88 0.89  0.93  1387    1
    A[2]   0.92       0 0.02 0.88 0.91 0.92 0.94  0.97  1138    1
    A[3]   0.84       0 0.03 0.79 0.83 0.84 0.86  0.90  1309    1
    A[4]   0.90       0 0.03 0.85 0.88 0.90 0.91  0.95  1368    1
    A[5]   0.87       0 0.03 0.82 0.85 0.87 0.89  0.92  1429    1
    A[6]   0.82       0 0.03 0.77 0.81 0.82 0.84  0.88  1902    1
    
    Samples were drawn using NUTS(diag_e) at Tue Jan 22 13:31:14 2019.
    For each parameter, n_eff is a crude measure of effective sample size,
    and Rhat is the potential scale reduction factor on split chains (at 
    convergence, Rhat=1).

本当はEMアルゴリズムで付随(incidental)母数を積分消去してから推定すると，速度も速く，推定結果も安定するため望ましい。Stanでも周辺化してから推定するコードを書くことができるようだが，それはまた今度。

## まとめにかえて

今回，StanコードをRmdに混ぜて資料を作ったが，多分二度とやらないと思う。理由はcache機能が使えず，いちいちkiterするたびにコンパイル＆MCMCを繰り返さなければならず，非常に手間がかかるからである。あらかじめ分析結果を画像などで保存しておけばいいかもしれないが，アドホックな手続きが必要となるし，Rmdのメリットがない。


Turn to [home](index.html)
