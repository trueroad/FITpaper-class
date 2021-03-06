<!-- -*- coding: utf-8 -*- -->
# FIT2019 向け LaTeX クラスファイル

[https://github.com/trueroad/FITpaper-class
](https://github.com/trueroad/FITpaper-class)

[FIT2019第18回情報科学技術フォーラム
](https://www.ipsj.or.jp/event/fit/fit2019/)向けに
LaTeXで使えるクラスファイルを作ってみました。
LuaLaTeX、pLaTeX、upLaTeX に対応しています。
基本的には[サイトに記載のある紙サイズ、ページ設定（マージン等）
](https://www.ipsj.or.jp/event/fit/fit2019/paper_require.html#sak)や、
[サイトに掲載されている原稿見本のサンプルファイル
](https://www.ipsj.or.jp/event/fit/fit2019/paper_require.html#miho)
FITpaper.docx に
設定されているフォントサイズ、行送り、アキ等と
同様なものを指定しているつもりです。

## 必要なもの

### LuaLaTeX で使う場合

* LuaLaTeX
* LuaTeX-ja
* [jlreq.cls](https://github.com/abenori/jlreq)
    + 2018/04/11 以降が必要です。
        - TeX Live 2018 初版に収録されているものは古くてダメですが
          TeX Live 2018 frozen や TeX Live 2019 なら大丈夫です。
* 各種フォント（本クラスファイルのデフォルト設定で使用するフォント）
    + 源ノ明朝 / 源ノ角ゴシック
        - TeX Live には収録されていないようなので
          LuaLaTeX から見えるところにインストールしておく必要があります。
    + STIX 2
        - TeX Live 2018 初版には収録されていなかったようですが
          TeX Live 2018 frozen や TeX Live 2019 なら収録されているようです。
    + TeX Gyre Heros
    + TeX Gyre Cursor

### pLaTeX / upLaTeX で使う場合

作成者は基本的に LuaLaTeX を使っているため、
うまく動かないことがあるかもしれません。

* pLaTeX または upLaTeX
* [jlreq.cls](https://github.com/abenori/jlreq)
    + 2018/04/11 以降が必要です。
        - TeX Live 2018 初版に収録されているものは古くてダメですが
          TeX Live 2018 frozen や TeX Live 2019 なら大丈夫です。
* 各種フォント（本クラスファイルのデフォルト設定で使用するフォント）
    + newtx
    + TeX Gyre Terms
    + TeX Gyre Heros
    + TeX Gyre Cursor

## サンプル

2 種類のサンプルがあります。

* [sample.tex](./sample.tex)
    + サンプルファイル
* [sample2.tex](./sample2.tex)
    + サンプルファイル（著者が多い場合）

### LuaLaTeX でサンプルをコンパイル

LuaLaTeX の場合は、以下のようにするとサンプルファイルをコンパイルして、
PDF （sample.pdf と sample2.pdf）を得ることができます。

```
$ lualatex sample.tex
$ lualatex sample.tex
$ lualatex sample2.tex
```

もしくは、 GNU make と latexmk があるなら、
`make` でサンプルファイル等をコンパイルすることもできます。

### pLaTeX / upLaTeX でサンプルをコンパイル

pLaTeX / upLaTeX の場合は、まず[sample.tex](./sample.tex)の

```tex
\usepackage{graphicx}
```

の行にお使いの DVI ドライバオプションを追加してください。
dvipdfmx の場合は、以下のようになります。

```tex
\usepackage[dvipdfmx]{graphicx}
```

それからコンパイルしてください。
コンパイルの方法は参考書などをご覧ください。

## 原稿の書き方

原稿の書き方は
[sample.tex](./sample.tex) や上記でコンパイルした sample.pdf
をご覧ください。
著者が多い場合の書き方は
[sample2.tex](./sample2.tex) や上記でコンパイルした sample2.pdf
をご覧ください。

## 履歴

* 2019-06-09
    + `\paragraph` と `\subparagprah` を使えるようにしました。
      特に FITpaper.docx に該当する設定があるわけではありません。
    + `hyperref` パッケージ用に `ackbibsection` の toclevel を追加しました。
      これによって警告が出なくなります。
* 2019-05-21
    + LuaLaTeX で luatexja-fontspec を使わないようにしました。
      これによってメモリ使用量やコンパイル時間の低減が見込まれます。
    + ただし、 `no_jafont_settings` オプションを使って
      和文フォント設定をしなかった場合は和欧文ファミリ連携しなくなったため、
      自分で和文フォント設定する際に
      luatexja-preset または luatexja-fontspec に対して
      `match` オプションを使うなどの必要があります。
* 2019-04-21
    + FIT2019 向けに更新
        - フォーマットは FIT2018 から変更されていないようです。
            - テンプレートファイル FITpaper.dotx は FIT2018 とバイナリ一致、
              サンプルファイル FITpaper.docx は FIT2018 から変更があるものの
              原稿で使用するスタイル定義には変更なし。
    + あわせて「必要なもの」の内容を更新
* 2018-05-19
    + `\Cjascale` 設定追加に伴うバグを修正
    + jlreq 2018-05-19 に対応
* 2018-04-21
    + 和欧文スケール比 `\Cjascale` の設定を追加
    + フォントの設定を行わないクラスオプションの組み合わせによって
    エラーが発生したり、和欧文ファミリ連動しなくなったりすることを修正
* 2018-04-16
    + (u)pLaTeX に対応
    + フォントの設定を行わないクラスオプション
    `no_jafont_settingss`, `no_lgcfont_settings`, `no_mathfont_settings`
    を追加
* 2018-04-15
    + 初版

## License

Copyright (C) 2018, 2019 Masamichi Hosoda. All rights reserved.

License: BSD-2-Clause

[LICENSE](./LICENSE) をご覧ください。
