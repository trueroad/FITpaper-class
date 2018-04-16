# -*- coding: utf-8; -*-
# サンプルファイル等をコンパイルして PDF を生成します

.PHONY: all clean dist-clean sample debug figure figure-clean

# 使用するコマンド類の定義
LATEXMK = latexmk -lualatex
LILYPOND = lilypond # 図を生成したいときのみ使用
RM = rm -f

# サンプルに生成する PDF
SAMPLEPDFS = sample.pdf sample2.pdf

# デバッグ用に生成する PDF
DEBUGPDFS = debug.pdf

# 図用に生成する PDF
FIGUREPDFS = invention1.pdf

# 図は `make all` では生成せず、配布ファイル中にある PDF をそのまま使う
# 図をソースファイルから生成したければ事前に `make figure` する
all: sample debug

clean:
	$(RM) *.aux *.log *.out *.fls *.fdb_latexmk *~

dist-clean: clean
	$(RM) $(SAMPLEPDFS) $(DEBUGPDFS)

figure-clean:
	$(RM) $(FIGUREPDFS)

sample: $(SAMPLEPDFS)

debug: $(DEBUGPDFS)

figure: $(FIGUREPDFS)

# LuaLaTeX ソースから PDF へコンパイル
%.pdf: %.tex
	$(LATEXMK) $<

# LilyPond で図 PDF を生成する
%.pdf: %.ly
	$(LILYPOND) $<
	$(RM) $*-1.eps $*-1.pdf \
		$*-systems.count $*-systems.tex $*-systems.texi
