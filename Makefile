# -*- coding: utf-8; -*-
# サンプルファイル等をコンパイルして PDF を生成します

.PHONY: all clean dist-clean sample debug figure platex uplatex figure-clean

# 使用するコマンド類の定義
LLMK = llmk
LILYPOND = lilypond # 図を生成したいときのみ使用
RM = rm -f
SED = sed

# サンプルに生成する PDF
SAMPLEPDFS = sample.pdf sample2.pdf

# デバッグ用に生成する PDF
DEBUGPDFS = debug.pdf

# 図用に生成する PDF
FIGUREPDFS = invention1.pdf

# 図は `make all` では生成せず、配布ファイル中にある PDF をそのまま使う
# 図をソースファイルから生成したければ事前に `make figure` する
all: sample debug

# LuaLaTeX で生成する PDF
LUALATEXPDFS = $(SAMPLEPDFS) $(DEBUGPDFS)

# pLaTeX で生成する PDF
PLATEXPDFS = $(LUALATEXPDFS:.pdf=.platex.pdf)

# upLaTeX で生成する PDF
UPLATEXPDFS = $(LUALATEXPDFS:.pdf=.uplatex.pdf)

# 生成した TeX ソースから生成する PDF
GENPDFS = $(PLATEXPDFS) $(UPLATEXPDFS)

clean:
	$(RM) *~
	$(LLMK) --clean $(LUALATEXPDFS:.pdf=.tex)
	for filename in $(GENPDFS:.pdf=.tex);\
	  do \
	    if [ -e "$$filename" ]; then \
	      $(LLMK) --clean "$$filename"; \
	    fi; \
	  done

dist-clean: clean
	$(LLMK) --clobber $(LUALATEXPDFS:.pdf=.tex)
	for filename in $(GENPDFS:.pdf=.tex);\
	  do \
	    if [ -e "$$filename" ]; then \
	      $(LLMK) --clobber "$$filename"; \
	    fi; \
	  done
	$(RM) $(GENPDFS:.pdf=.tex)

figure-clean:
	$(RM) $(FIGUREPDFS)

sample: $(SAMPLEPDFS)

debug: $(DEBUGPDFS)

figure: $(FIGUREPDFS)

platex: $(PLATEXPDFS) $(PLATEXPDFS:.pdf=.tex)

uplatex: $(UPLATEXPDFS) $(UPLATEXPDFS:.pdf=.tex)

# TeX ソースから PDF へコンパイル
%.pdf: %.tex
	$(LLMK) $<

# LuaLaTeX ソースから pLaTeX ソースを生成
%.platex.tex: %.tex
	$(SED) -f platex.sed $< > $@

# LuaLaTeX ソースから upLaTeX ソースを生成
%.uplatex.tex: %.tex
	$(SED) -f uplatex.sed $< > $@

# LilyPond で図 PDF を生成する
%.pdf: %.ly
	$(LILYPOND) $<
	$(RM) $*-1.eps $*-1.pdf \
		$*-systems.count $*-systems.tex $*-systems.texi
