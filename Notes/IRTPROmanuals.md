# IRTPROの覚書

# Batchモードでの実行方法

Command Promptにて，executable folderに移動し，

```
-Run"hoge.irtpro"
```

で実行できる。デフォルトのフォルダは"c:\program files (x86)\irtpro21\irtpro"？


# Structure of a syntax file

Punctuation mark `:` のあとに続くパラグラフ(commands)からなる。最初の5つのコマンドは固定されている。改行は `;` 。

```
Project:
Name = <.ssig拡張子を除いた，IRTPROのデータファイル>;
Data:
File = <.ssig拡張子のついたIRTPROデータファイル>; # 多分ここにファイルのディレクトリを入力する。
Analysis :
Name = <Testn>; # Test1, test2, ...と分析ウィンドウの番号を指定する。タブの名前はユーザー任意
Mode = <Analysis type> ; # Traditional, Calibration, Scoringの3つから指定する。
# Traditional : 古典的な統計分析
# Calibration : IRTPRO分析（項目パラメタ推定）
# Scoring     : IRT Scoring（これは使わないかも）
Title :
<Description of the analysis> # 分析プログラムのタイトル
Comments :
<Additional comments about the analysis> # コメント
```

分析の詳細な指定をするには`Estimation`コマンドで指定する。