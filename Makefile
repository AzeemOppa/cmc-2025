.PHONY: all
all: build/lecture-01.pdf build/lecture-02.pdf build/lecture-03.pdf build/lecture-04.pdf build/lecture-05.pdf

build:
	mkdir -p $@

LATEX_COMPILER := TEXPINPUTS=./code/sty: lualatex -halt-on-error

build/lecture-01.pdf: code/latex/lecture-01.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/lecture-02.pdf: code/latex/lecture-02.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/lecture-03.pdf: code/latex/lecture-03.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/lecture-04.pdf: code/latex/lecture-04.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/lecture-05.pdf: code/latex/lecture-05.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/website: | build
	mkdir -p $@

PHONY: website
website: build/website/index.html build/website/style.css \
  build/website/lecture-01.pdf build/website/lecture-02.pdf \
  build/website/lecture-03.pdf build/website/lecture-04.pdf

build/website/index.html: code/html/index.html | build/website
	cp $< $|

build/website/style.css: code/css/style.css | build/website
	cp $< $|

build/website/lecture-01.pdf: build/lecture-01.pdf | build/website
	cp $< $|

build/website/lecture-02.pdf: build/lecture-02.pdf | build/website
	cp $< $|

build/website/lecture-03.pdf: build/lecture-03.pdf | build/website
	cp $< $|

build/website/lecture-04.pdf: build/lecture-04.pdf | build/website
	cp $< $|

build/website/lecture-05.pdf: build/lecture-05.pdf | build/website
	cp $< $|

.PHONY: website_clean
website_clean:
	-$(RM) -r build/website

.PHONY: clean
clean:
	-$(RM) -r build
