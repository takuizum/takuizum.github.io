20180118\_install\_irtfun2
================
T.SHIBUYA
1/18/2019

## install irtfun2

　`irtfun2`のいくつかの関数はC++で記述されています。代表的なものは`estip`や`estdist`などですが，`estip2`や`estGip`などのエンジン部分はC++で記述されています。

　C++で記述することのメリットは高速化ですが，一方でインストールにはコンパイラが必要になります。ここでは`irtfun2`のインストールを通して，お使いのPCもしくはMacにC++のコンパイラをインストールしましょう。

　といっても，別に大変な作業ではありません。偉大なる先人たち[1](https://teuder.github.io/rcpp4everyone_ja/)[2](https://sudori.info/stat/stat_rcpp_01.html)のサイトを参考にすればすんなりインストールできることでしょう（丸投げ）。

　基本的にWinではRtoolsを，MacではXcode（の一部）をインストールするだけでOKです。先人たちのサイトを参考にやってください（丸投げ）。

　次にR側での操作です。`irtfun2`は`Rcpp`を依存パッケージとしてありますが，念のため先に`Rcpp`をインストールしておきましょう。それと同時にGitHubから`irtfun2`をインストールしてくるために必要な`devtools`と呼ばれるパッケージ作成支援パッケージをインストールしておきます。
　

``` r
# install.packages(c("Rcpp", "devtools"))
```

　問題なく終了すれば，下準備はOKです。あとはGitHubからリポジトリを叩いて，`irtfun2`を持ってくるだけです。これには`devtools::install_github()`を使います。
　

``` r
devtools::install_github("takuizum/irtfun2")
```

    ## Downloading GitHub repo takuizum/irtfun2@master

    ## backports   (1.1.2    -> 1.1.3   ) [CRAN]
    ## BH          (1.66.0-1 -> 1.69.0-1) [CRAN]
    ## checkmate   (1.8.5    -> 1.9.1   ) [CRAN]
    ## colorspace  (1.3-2    -> 1.4-0   ) [CRAN]
    ## data.table  (1.11.8   -> 1.12.0  ) [CRAN]
    ## evaluate    (0.11     -> 0.12    ) [CRAN]
    ## ggplot2     (3.0.0    -> 3.1.0   ) [CRAN]
    ## htmlTable   (1.12     -> 1.13.1  ) [CRAN]
    ## htmlwidgets (1.2      -> 1.3     ) [CRAN]
    ## jsonlite    (1.5      -> 1.6     ) [CRAN]
    ## knitr       (1.20     -> 1.21    ) [CRAN]
    ## markdown    (0.8      -> 0.9     ) [CRAN]
    ## mime        (0.5      -> 0.6     ) [CRAN]
    ## rlang       (0.3.0.1  -> 0.3.1   ) [CRAN]
    ## rstudioapi  (0.8      -> 0.9.0   ) [CRAN]
    ## scales      (0.5.0    -> 1.0.0   ) [CRAN]
    ## tibble      (1.4.2    -> 2.0.1   ) [CRAN]
    ## xfun        (0.3      -> 0.4     ) [CRAN]

    ## Installing 18 packages: backports, BH, checkmate, colorspace, data.table, evaluate, ggplot2, htmlTable, htmlwidgets, jsonlite, knitr, markdown, mime, rlang, rstudioapi, scales, tibble, xfun

    ## Installing packages into '/Users/takuizum/Library/R/3.5/library'
    ## (as 'lib' is unspecified)

    ## 
    ##   There is a binary version available but the source version is
    ##   later:
    ##       binary source needs_compilation
    ## knitr   1.20   1.21             FALSE
    ## 
    ## 
    ## The downloaded binary packages are in
    ##  /var/folders/11/87n0fpwj2zx53hmphpnxz6q00000gn/T//RtmpjRcEnP/downloaded_packages

    ## installing the source package 'knitr'

    ##   
       checking for file ‘/private/var/folders/11/87n0fpwj2zx53hmphpnxz6q00000gn/T/RtmpjRcEnP/remotes69364dcbf64e/takuizum-irtfun2-9f386a9/DESCRIPTION’ ...
      
    ✔  checking for file ‘/private/var/folders/11/87n0fpwj2zx53hmphpnxz6q00000gn/T/RtmpjRcEnP/remotes69364dcbf64e/takuizum-irtfun2-9f386a9/DESCRIPTION’ (414ms)
    ## 
      
    ─  preparing ‘irtfun2’:
    ## 
      
       checking DESCRIPTION meta-information ...
      
    ✔  checking DESCRIPTION meta-information
    ## 
      
    ─  cleaning src
    ## 
      
    ─  checking for LF line-endings in source and make files and shell scripts (374ms)
    ## 
      
    ─  checking for empty or unneeded directories
    ## 
      
    ─  looking to see if a ‘data/datalist’ file should be added
    ## 
      
    ─  building ‘irtfun2_0.6.7.0.tar.gz’
    ## 
      
       
    ## 

    ## Installing package into '/Users/takuizum/Library/R/3.5/library'
    ## (as 'lib' is unspecified)

これでインストール完了です。

Have a good irtfun2 life\!
