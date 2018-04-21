<!-- -*- coding: utf-8 -*- -->
# FIT2018 向け LaTeX クラスファイル

[https://github.com/trueroad/FITpaper-class
](https://github.com/trueroad/FITpaper-class)

[FIT2018第17回情報科学技術フォーラム
](https://www.ipsj.or.jp/event/fit/fit2018/index.html)向けに
LaTeXで使えるクラスファイルを作ってみました。
LuaLaTeX、pLaTeX、upLaTeX に対応しています。
基本的には[サイトに記載のある紙サイズ、ページ設定（マージン等）
](https://www.ipsj.or.jp/event/fit/fit2018/paper_require.html#sak)や、
[サイトに掲載されている原稿見本のサンプルファイル
](https://www.ipsj.or.jp/event/fit/fit2018/paper_require.html#miho)
FITpaper.docx に
設定されているフォントサイズ、行送り、アキ等と
同様なものを指定しているつもりです。

## 必要なもの

### LuaLaTeX で使う場合

* LuaLaTeX
* LuaTeX-ja
* [jlreq.cls](https://github.com/abenori/jlreq)
    + 2018/04/11 以降が必要です。
    （それ以前でも[パッチ](https://github.com/abenori/jlreq/pull/25)を
    当てれば恐らく動きます。）
* 各種フォント（本クラスファイルのデフォルト設定で使用するフォント）
    + 源ノ明朝
    + 源ノ角ゴシック
    + [STIX 2](http://www.stixfonts.org/)
        - TeX Live 2017 には収録されていないようなので、
        自分でダウンロードしてインストールしておく必要があります。
    + TeX Gyre Heros
    + TeX Gyre Cursor

### pLaTeX / upLaTeX で使う場合

作成者は基本的に LuaLaTeX を使っているため、
うまく動かないことがあるかもしれません。

* pLaTeX または upLaTeX
* [jlreq.cls](https://github.com/abenori/jlreq)
    + 2018/04/11 以降が必要です。
    （それ以前でも[パッチ](https://github.com/abenori/jlreq/pull/25)を
    当てれば恐らく動きます。）
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

Copyright (C) 2018 Masamichi Hosoda. All rights reserved.

License: BSD-2-Clause

[LICENSE](./LICENSE) をご覧ください。
