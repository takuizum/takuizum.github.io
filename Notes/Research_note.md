# 研究ノート

### 2019/04/11
　最近はすっかり研究ノートの更新をとめてしまっていたが，ここらへんで再開しようと思う。再開を機に，wordでの環境をやめて，mdで記録して，Gitにmergeできるようにしたいと思った。  
##### Advancing Human Assessment [Chapter 3]
###### Psychometric Contributions: Focus on Test Scores
　テスト得点にフォーカスした章だった。基本的な古典的テスト理論の式から，信頼性係数，真値から観測値への回帰得点など盛りだくさんだった。基本的に古典的テスト理論(Classical Test Theory)の範疇の話だったが，途中で欠測値の話もあって面白かった。特にKristofの提案した，2部以上に分割した場合の信頼性係数などは日本のテキストでは今まで見たことがなかったもので興味深かった。  
　基本的なテスト$X$からテスト$Y$への回帰得点の式は，
$$
\begin{eqnarray}
Y = \mu(Y|X) + \epsilon = \mu_Y + \rho_{X, Y}\frac{\sigma_Y}{\sigma_Y}(X-\mu_X)+\epsilon
\end{eqnarray}
$$

である。$\rho_{X, Y}\frac{\sigma_Y}{\sigma_Y}$ が回帰係数の傾きにあたる。観測値から真値を推定する式は[池田(1973)](https://1drv.ms/b/s!AmmvfkpgY6-miNkvVhdUtaueG9-50Q)を参考にして，
$$
\hat T = \rho(X)X+(1-\rho(X))\mu(X)
$$
で表されることが分かる。なお $\rho(X)$ はテスト得点$X$の信頼性係数である。この式が意味するところはテスト$X$の信頼性係数が高ければ観測値の得点がそのまま真値に一致し，そうでなければテスト$X$の得点が重みづけられるという内容になっている。[Brennan](https://1drv.ms/b/s!AmmvfkpgY6-miNku6OA25627QDu-fw)のテキストにも同様の内容がある。

### 2019/04/12
