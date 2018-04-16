<!-- -*- coding: utf-8 -*- -->
# FIT2018 向け LuaLaTeX クラスファイル

[https://github.com/trueroad/FITpaper-class
](https://github.com/trueroad/FITpaper-class)

[FIT2018第17回情報科学技術フォーラム
](https://www.ipsj.or.jp/event/fit/fit2018/index.html)向けに
LuaLaTeXで使えるクラスファイルを作ってみました。
pLaTeX 等では使えません。
基本的には[サイトに記載のある紙サイズ、ページ設定（マージン等）
](https://www.ipsj.or.jp/event/fit/fit2018/paper_require.html#sak)や、
[サイトに掲載されている原稿見本のサンプルファイル
](https://www.ipsj.or.jp/event/fit/fit2018/paper_require.html#miho)
FITpaper.docx に
設定されているフォントサイズ、行送り、アキ等と
同様なものを指定しているつもりです。

## 必要なもの

* LuaLaTeX
    + pLaTeX 系には対応していません。
* LuaTeX-ja
* [jlreq.cls](https://github.com/abenori/jlreq)
    + 2018/04/11 以降が必要です。
    （それ以前でも[パッチ](https://github.com/abenori/jlreq/pull/25)を
    当てれば恐らく動きます。）
* 各種フォント
    + 源ノ明朝
    + 源ノ角ゴシック
    + [STIX 2](http://www.stixfonts.org/)
        - TeX Live 2017 には収録されていないようなので、
        自分でダウンロードしてインストールしておく必要があります。
    + TeX Gyre Heros
    + TeX Gyre Cursor

## サンプル

* [sample.tex](./sample.tex)
    + サンプルファイル
* [sample2.tex](./sample2.tex)
    + サンプルファイル（著者が多い場合）

以下のようにするとサンプルファイルをコンパイルして、
PDF （sample.pdf と sample2.pdf）を得ることができます。

```
$ lualatex sample.tex
$ lualatex sample.tex
$ lualatex sample2.tex
```

原稿の書き方は
[sample.tex](./sample.tex) や上記でコンパイルした sample.pdf
をご覧ください。
著者が多い場合の書き方は
[sample2.tex](./sample2.tex) や上記でコンパイルした sample2.pdf
をご覧ください。

## License

Copyright (C) 2018 Masamichi Hosoda. All rights reserved.

License: BSD-2-Clause

[LICENSE](./LICENSE) をご覧ください。
