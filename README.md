# 概要
ffmpeg の concat コマンドによる動画結合を簡単に行うための windows powershell のコマンドレットです。

# 使い方
## ffmpegのインストール
ffmpegをインストールして，powershellで使える状態にしてください。

https://ffmpeg.org/

## ファイルのインポート
コマンドを実行するには，psm1 ファイルをpowershellにインポートする必要があります。

その場で試用のみの場合は Import-Module コマンドを利用します。

```
Import-Module ./catmov.psm1
```

powershell 起動時に毎回インポートを行う場合は，環境変数の PSModulePath 下にファイルを置きます。

PSModulePath配下に、

```
(PSModulePath)/catmov/catmov.psm1
```

という形で保存してください。

これで、起動時に自動インポートされます。

## コマンドの実行
### 動画ファイルの用意
結合する動画ファイルを用意してください。

この時ファイル名は、`<動画名><結合子><添え字>.<拡張子>` としてください。

`hoge-1.mp4 hoge-2.mp4 hoge-3.mp4`といった形です。

### コマンド実行
catmovコマンドを実行します。

`hoge-1.mp4 hoge-2.mp4 hoge-3.mp4`を結合するコマンドは、

```
catmov hoge -sep -
```

と、なります。

hogeの部分が、結合するファイルの<動画名>です。

sepオプションで<結合子>を指定します。未指定の場合、<結合子>は無しとみなします。（例：hoge1.mp4）

全オプションについては次章で書きます。

## オプション

|オプション名|記述例|意味|デフォルト|
|:---:|:---:|:---:|:---:|
|out|出力ファイル名の指定|-out hoge|<動画名>.<拡張子>|
|start|先頭になる入力動画の添え字|-start 3|1|
|end|末尾になる入力動画の添え字|-end 5|なし(存在するだけ結合)|
|sep|結合子の指定|-sep -|なし|
|ext|動画の拡張子指定|-ext avi|mp4|
|copy|動画を再エンコードしない|-copy |False|
|alp|添え字にアルファベットを使用|-alp |False(数字)|

### 実行例
フォルダに

`hoge_A.avi hoge_B.avi hoge_C.avi hoge_D.avi hoge_E.avi`

が存在し、`hoge_B.avi hoge_C.avi hoge_D.avi`を再エンコードなしで結合し、`hogehoge.avi`を出力する場合、

```
catmov hoge -out hogehoge -start B -end D -sep _ -ext avi -copy -alp
```

となります。