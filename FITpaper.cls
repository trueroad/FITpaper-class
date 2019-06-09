% -*- coding: utf-8; mode: latex; -*-
%
% FIT2019 向け LaTeX クラスファイル
% https://github.com/trueroad/FITpaper-class
%
% Copyright (C) 2018, 2019 Masamichi Hosoda.
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions
% are met:
%
% * Redistributions of source code must retain the above copyright notice,
%   this list of conditions and the following disclaimer.
%
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED.
% IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
% OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
% LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
% OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
% SUCH DAMAGE.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{FITpaper}[2019/06/09 FIT2019 paper class]

%%
%% エンジン判定
%%

\ifx\luatexversion\@undefined
  \ifx\kanjiskip\@undefined
    \ClassError{FITpaper}{LuaLaTeX or (u)pLaTeX is required.}{\@ehc}
  \else
    \let\fitclass@engine=p
  \fi
\else
  \let\fitclass@engine=l
\fi

%%
%% クラスオプション
%%

\newif\if@fitclass@no@ja@font
\newif\if@fitclass@no@lgc@font
\newif\if@fitclass@no@math@font

\@fitclass@no@ja@fontfalse
\@fitclass@no@lgc@fontfalse
\@fitclass@no@math@fontfalse

\DeclareOption{no_jafont_settings}{\@fitclass@no@ja@fonttrue}
\DeclareOption{no_lgcfont_settings}{\@fitclass@no@lgc@fonttrue}
\DeclareOption{no_mathfont_settings}{\@fitclass@no@math@fonttrue}
\ProcessOptions

%%
%% 前提条件
%%

%
% FIT2019
% Web 記載のページ設定
% https://www.ipsj.or.jp/event/fit/fit2019/paper_require.html
%
% 用紙サイズ
%   A4 (210 mm x 297 mm)
% マージン
%   上 30 mm、下 25 mm、左 20 mm、右 20 mm、カラム間 7 mm （いずれも目安）
%
% ※ Web では「カラム間」ではなくて「コラム間」表記
%

%
% FIT2019 サンプルファイル FITpaper.docx 設定より
%
% 本文フォントサイズ
%   9 ポイント = 9 bp
% 本文行送り
%  12 ポイント = 12 bp
%

%%
%% 横方向の計算
%%

% jlreq.cls にはカラム幅（一行の長さ）を指定すれば
% 和文文字幅の整数倍に補正してくれる機能があるが、
% ここでは二段組であり、カラム間も調整したいので自前で計算する。

% カラム幅
% (横 210 mm - 左 20 mm - 右 20 mm - カラム間 7 mm) ÷ 2 = 81.5 mm
% = 231.023622 bp

% カラム一行当たりの和文文字数
% 231.023622 bp ÷ 9 bp = 25 文字 あまり 6.02362205 bp

% 修正後カラム幅（カラム幅を和文文字幅の整数倍に修正する）
% 9 bp × 25 文字 = 225 bp

% 修正すると両カラムそれぞれ幅が 6.02362205 bp 短くなる
% 修正前後で両カラムそれぞれの左右中央を一致させるには、
% カラム間を長くする（増加させる）必要がある。

% カラム間増加分
% 6.02362205 bp = 2.125 mm

% 修正後のカラム間
% カラム間 7 mm + 増加分 2.125 mm = 9.125 mm

% 左右マージンは左右対称になればよいので jlreq.cls に計算してもらう
% （二段組として修正後カラム幅と修正後カラム間のみ指定する）

%%
%% 縦方向の計算
%%

% カラム高さ
% (縦 297 mm - 上 30 mm - 下 25 mm) = 242 mm
% = 685.984252 bp

% カラムの行数
% 685.984252 bp ÷ 行送り 12 bp = 57.1653543 行

%
% ・jlreq.cls 2018/02/01 まで
% 上下双方のマージンを同時に指定することができないが、
% 上マージンだけクラスオプション head_space で指定しておき、
% 裏技的に行数をクラスオプション number_of_lines で実数指定することで、
% 実質的に下マージンの指定をしているのと同等の設定が可能だった。
%
% ・jlreq.cls 2018/04/11
% 上下双方のマージンを同時に指定することはできない。
% （警告が出て下マージンの設定が無視される。）
% 行数指定に実数を指定するとエラーが出るようになった。
% 仕方ないのでクラスのロード後に版面の高さを直接指定する。
% また、クラスをロードする前に jlreq.cls のバージョン判定ができず、
% バージョンによって行数の実数指定可否の分岐ができないので、
% これ以前のバージョンでも、行数実数指定でなく版面高さの直接指定とする。
%
% ・jlreq.cls 2018/05/19 以降
% 天の空き量と地の空き量に異なる値を設定したい
% https://github.com/abenori/jlreq/issues/28
% の議論の結果、上下双方のマージンを同時に指定可能になった。
% クラスオプションとしては、双方を指定しておく。
% 2018/04/11 までであれば、下マージンを無視した旨の警告が出るが、
% 後からバージョン判定して版面高さを直接指定する、以前と同様の処理を行う。
% 対応バージョンと判定した場合は、クラスオプションのみで設定が完了しており、
% 後からすることは何もない。
%

%%
%% 版面設定して jlreq.cls をロード
%%

% 和欧文フォントサイズ比
% LuaLaTeX では 1: 和文を基準として欧文をフォント設定で拡大する
\def\fitclass@jafontscale{1}
\ifx p\fitclass@engine
  % (u)pLaTeX では 0.952381 = 1/1.05: 欧文を 5 % 拡大相当にする
  \def\fitclass@jafitscale{0.952381}
\fi

\LoadClass[%
  twocolumn,%          二段組
  paper=a4,%           用紙サイズ A4
  jafontsize=9bp,%     本文フォントサイズ 9 ポイント
  jafontscale=\fitclass@jafontscale,% 和欧文フォントサイズ比
  line_length=25zw,%   カラム幅は和文文字幅 25 文字分
  head_space=30mm,%    上マージン 30 mm
  foot_space=25mm,%    下マージン：jlreq 2018/04/11 まで指定しても無視される
  %number_of_lines=57.1653543,% 行数（jlreq 2018/04/11 以降、実数指定できず）
  baselineskip=12bp,%  行送り（JLReq コメント出るが FITpaper 設定値）
  column_gap=9.125mm,% カラム間
  jlreq_notes%         JLReq コメントを表示
]{jlreq}

% 版面の高さ
\@ifclasslater{jlreq}{2018/05/19}{%
  % jlreq 2018/05/19 から
  % クラスオプション head_space, foot_space
  % 両方同時指定可能になったのでクラスオプションで完結、何もしない。
  \relax}{%
  % jlreq 2018/04/11 まで
  % 2018/04/11 で行数の実数指定できなくなったため直接版面の高さを設定する。
  % 行送りの整数倍に補正しない。
  \setlength{\textheight}{242mm}}

% ノンブル無し
\pagestyle{empty}

% 和欧文スケール比を設定
\ifx\Cjascale\@undefined
  \edef\Cjascale{\fitclass@jafontscale}
\fi

%%
%% フォント設定
%%

%
% 和文フォント設定
%
\if@fitclass@no@ja@font
\else

\ifx l\fitclass@engine
%
% LuaLaTeX 用和文フォント設定
%
% LuaTeX-ja を使う
% （LuaLaTeX を使っていれば jlreq.cls が自動的にロードする）
% sourcehan: 和文フォントは源ノ明朝 / 源ノ角ゴシックを使う
% deluxe:    複数のウェイトを使う
% match:     欧文フォントのファミリ指定と連動させる
% nfss-only: luatexja-fontspec を使わない（メモリ・時間節約）
% jfm_...:   JFM は jlreq のものを使う
%
\RequirePackage[sourcehan,deluxe,match,nfssonly,%
  jfm_yoko=jlreq,jfm_tate=jlreqv]{luatexja-preset}
\fi

\fi

%
% 数式フォント設定
%
\if@fitclass@no@math@font
\else

\ifx l\fitclass@engine
%
% LuaLaTeX 用数式フォント設定
%
% 数式フォントは STIX 2 を使用
% 和文と同サイズだと小さく見えるため 5% 拡大
%
\RequirePackage[no-math]{fontspec}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\unimathsetup{math-style=ISO,bold-style=ISO}
\setmathfont[Scale=1.05]{STIX Two Math}
\fi

\ifx p\fitclass@engine
%
% (u)pLaTeX 用数式フォント設定
%
% newtx を使用
%
\RequirePackage{amsmath}
\RequirePackage{newtxmath}
\fi

\fi

%
% 欧文 (LGC) フォント設定
%
\if@fitclass@no@lgc@font
\else

\ifx l\fitclass@engine
%
% LuaLaTeX 用欧文フォント設定
%
% ここでは和欧文ファミリ連動の考慮はしない。
% 和文フォント設定時に luatexja-preset または luatexja-fontspec に対して
% match オプションを使うなどの必要がある。
%
% セリフフォントは STIX 2 を使用
% サンセリフフォント、等幅フォントは TeX Gyre を使用
% 和文と同サイズだと小さく見えるため 5% 拡大
%
\RequirePackage[no-math]{fontspec}
\setmainfont[Scale=1.05]{STIX Two Text}
\setsansfont[Scale=1.05]{TeX Gyre Heros}
\setmonofont[Scale=1.05]{TeX Gyre Cursor}
\fi

\ifx p\fitclass@engine
%
% (u)pLaTeX 用欧文フォント設定
%
% TeX Gyre を使用
%
\renewcommand{\rmdefault}{qtm}% TeX Gyre Termes
\renewcommand{\sfdefault}{qhv}% TeX Gyre Hereos
\renewcommand{\ttdefault}{qcr}% TeX Gyre Cursor
\fi

\fi

%%
%% 所属
%%

% 著者名の右肩につける所属番号
\newcommand{\affmark}[1]{\footnotemark[#1]}

% 脚注に出す所属名
\def\fitpaper@affiliations{}
\newcommand{\afftext}[2]{%
  \expandafter\def\expandafter\fitpaper@affiliations\expandafter{%
    \fitpaper@affiliations \footnotetext[#1]{#2}}}

%%
%% タイトル設定
%%

% 段抜きでタイトル、脚注に所属名を出力
% 所属名のフォントサイズは FITpaper.docx 設定値
\renewcommand\maketitle{%
  \twocolumn[\@maketitle]%
  {\let\footnotesize\normalsize \fitpaper@affiliations}}

%
% 和文タイトル：
%   明朝・セリフ系フォント、サイズ 12 bp （FITpaper.docx 設定値）
%   行送りは本文のサイズ／行送り比と同等に設定
%   （FITpaper.docx 設定値は「行間 1 行」だが、これはフォント依存の設定？）
%   段落前のアキ 10 bp （FITpaper.docx 設定値）
%   段落後のアキ 0 行（FITpaper.docx 設定値）
% 欧文タイトル：
%   ゴシック・サンセリフ系フォント、サイズ 12 bp （FITpaper.docx 設定値）
%   行送りは本文のサイズ／行送り比と同等に設定
%   （FITpaper.docx 設定値は「行間 1 行」だが、これはフォント依存の設定？）
%   段落前後のアキ 0 行（FITpaper.docx 設定値）
% 著者（和文）:
%   ゴシック・サンセリフ系フォント、サイズ 10.5 bp （FITpaper.docx 設定値）
%   行送りは本文のサイズ／行送り比と同等に設定
%   （FITpaper.docx 設定値は「行間 1 行」だが、これはフォント依存の設定？）
%   段落前のアキ 5 bp （FITpaper.docx 設定値）
%   段落後のアキ 0 行（FITpaper.docx 設定値）
% 著者（英文）:
%   ゴシック・サンセリフ系フォント、サイズ 10.5 bp （FITpaper.docx 設定値）
%   行送りは本文のサイズ／行送り比と同等に設定
%   （FITpaper.docx 設定値は「行間 1 行」だが、これはフォント依存の設定？）
%   段落前後のアキ 0 行（FITpaper.docx 設定値）
% タイトル後のアキ 9 bp はタイトル部と本文部のアキを
% 目視で確認して適当に設定したもの
%
\def\@maketitle{%
  \centering

  \vspace{10bp}

  {\jafontsize{12bp}{16bp}\selectfont {\fitpaper@jtitle}} \par
  {\jafontsize{12bp}{16bp}\selectfont \sffamily {\fitpaper@etitle}} \par

  \vspace{5bp}

  {\jafontsize{10.5bp}{14bp}\selectfont \sffamily
    \begin{tabular}{\fitpaper@authors}
      \fitpaper@jauthors \\
      \fitpaper@eauthors
    \end{tabular}

    \ifx \fitpaper@authorstwo \@undefined
    \else

    \vspace{5bp}

    \begin{tabular}{\fitpaper@authorstwo}
      \fitpaper@jauthorstwo \\
      \fitpaper@eauthorstwo
    \end{tabular}

    \fi

  } \par

  \vspace{9bp}
}

% タイトル設定
\newcommand{\jtitle}[1]{\def\fitpaper@jtitle{#1}}% 和文
\newcommand{\etitle}[1]{\def\fitpaper@etitle{#1}}% 欧文
% 著者 1 段目設定
\newcommand{\authors}[1]{\def\fitpaper@authors{#1}}% 著者数
\newcommand{\jauthors}[1]{\def\fitpaper@jauthors{#1}}% 和文
\newcommand{\eauthors}[1]{\def\fitpaper@eauthors{#1}}% 欧文
% 著者 2 段目設定
\newcommand{\authorstwo}[1]{\def\fitpaper@authorstwo{#1}}% 著者数
\newcommand{\jauthorstwo}[1]{\def\fitpaper@jauthorstwo{#1}}% 和文
\newcommand{\eauthorstwo}[1]{\def\fitpaper@eauthorstwo{#1}}% 欧文

%%
%% 見出し
%%

%
% \section, \subsection, \subsubsection
%
% フォントサイズ、行送り、前後のアキ（いずれも FITpaper.docx の設定値）
% ゴシック太字からゴシックへ変更
%
\ModifyHeading{section}{font={\jafontsize{10.5bp}{12bp}\selectfont\sffamily},%
  lines=1, before_lines=0, after_lines=0,%
  before_space=8bp, after_space=6bp}
\ModifyHeading{subsection}{font={\jafontsize{10bp}{12bp}\selectfont\sffamily},%
  lines=1, before_lines=0, after_lines=0,%
  before_space=6bp, after_space=6bp}
\ModifyHeading{subsubsection}{font={\normalsize\sffamily},%
  lines=1, before_lines=0, after_lines=0,%
  before_space=0pt, after_space=0pt}

%
% \paragraph, \subparagprah
%
% 特に FITpaper.docx には設定されていないが使えるようにしておく
% ゴシック太字からゴシックへ変更
%
\ModifyHeading{paragraph}{font={\normalsize\sffamily}}
\ModifyHeading{subparagraph}{font={\normalsize\sffamily}}

%
% caption 関係
%
% フォントサイズ、行送り（いずれも FITpaper.docx の設定値）
% フォントをゴシック太字からゴシックへ変更
%
\jlreqsetup{caption_font={\normalsize\selectfont\sffamily},%
  caption_label_font={\normalsize\selectfont\sffamily}}

%
% 謝辞と参考文献
%
% フォントサイズ、行送り、前後のアキ（いずれも FITpaper.docx の設定値）
% フォントをゴシック太字からゴシックへ変更
% 節番号のような数字をつけない、センタリング
%
% jlreq 2017/06/11 でセンタリングが変更になっている
\@ifclasslater{jlreq}{2017/06/11}{%
  % jlreq 2017/06/11 から
  \NewBlockHeading{ackbibsection}{1}{font={\normalsize\selectfont\sffamily},%
    lines=1, before_lines=0, after_lines=0,%
    before_space=6bp, after_space=2pt, label_format={},%
    align=center}}{%
  % jlreq 2017/04/29 まで
  \NewBlockHeading{ackbibsection}{1}{font={\normalsize\selectfont\sffamily},%
    lines=1, before_lines=0, after_lines=0,%
    before_space=6bp, after_space=2pt, label_format={},%
    indent=center}}
\newcommand{\toclevel@ackbibsection}{1}

%%
%% 参考文献
%%

%
% 参考文献の行長を字幅の整数倍にする
% https://gist.github.com/trueroad/80630e95df5af0234e36270b019e6458
% を改変
% ・フォントサイズ（FITpaper.docx の設定値）
% ・行送りは本文のサイズ／行送り比と同等に設定
%   （FITpaper.docx 設定値は「行間 1 行」だが、これはフォント依存の設定？）
% ・見出しを参考文献用に変更
%
\renewenvironment{thebibliography}[1]{%
  \jlreq@oldfontcommand@enable
  \jafontsize{8bp}{10.666667bp}\selectfont% 追加：フォントサイズ・行送り変更
  \ackbibsection{\refname}% 変更：section* -> ackbibsection
  \@mkboth{\refname}{\refname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
      {\settowidth\labelwidth{\@biblabel{#1}}%
      \@tempdima\linewidth
      \advance\@tempdima-\labelwidth
      \advance\@tempdima-\labelsep
      \@tempdimb\@tempdima
      \@tempdimc 1\zw
      \divide\@tempdima\@tempdimc
      \multiply\@tempdima\@tempdimc
      \advance\@tempdimb-\@tempdima
      \advance\labelsep\@tempdimb
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \itemindent=0pt
      \@openbib@code
      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
  \jlreq@oldfontcommand@disable
}

%%
%% 謝辞
%%

\newcommand{\acknowledgment}[1]{%
  \ackbibsection{謝辞}
  #1}
