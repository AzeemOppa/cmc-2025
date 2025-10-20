.PHONY: all

_lectures_latex := $(wildcard code/latex/lecture-*.tex)
_lectures_pdf := $(patsubst code/latex/lecture-%.tex,\
  build/lecture-%.pdf, $(_lectures_latex))

all: $(_lectures_pdf)

build:
	mkdir -p $@

LATEX_COMPILER := \
  TEXINPUTS=./code/latex:./code/sty: lualatex -halt-on-error

$(_lectures_pdf): build/lecture-%.pdf: code/latex/lecture-%.tex\
  code/latex/preamble.tex | build
	$(LATEX_COMPILER) -output-directory=$| $<
	$(LATEX_COMPILER) -output-directory=$| $<

build/website: | build
	mkdir -p $@

_lectures_pdf_website := $(patsubst build/lecture-%.pdf,\
  build/website/lecture-%.pdf, $(_lectures_pdf))

PHONY: website
website: build/website/index.html build/website/style.css\
  $(_lectures_pdf_website)

build/website/index.html: code/html/index.html | build/website
	cp $< $|

build/website/style.css: code/css/style.css | build/website
	cp $< $|

$(_lectures_pdf_website): build/website/lecture-%.pdf: build/lecture-%.pdf\
  | build/website
	cp $< $|

.PHONY: website_clean
website_clean:
	-$(RM) -r build/website

.PHONY: clean
clean:
	-$(RM) build/lecture-*

.PHONY: distclean
distclean:
	-$(RM) -r build
