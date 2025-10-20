.PHONY: all
all: build/lecture-01.pdf build/lecture-02.pdf

build:
	mkdir -p $@

LATEX_COMPILER := TEXPINPUTS=./code/sty: lualatex -halt-on-error

build/lecture-01.pdf: code/latex/lecture-01.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/lecture-02.pdf: code/latex/lecture-02.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

clean:
	-$(RM) -r build
