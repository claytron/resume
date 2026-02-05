# Makefile for Resume (Pandoc-based)
#

# You can set these variables from the command line.
BUILDDIR      = _build
GITHUBIO      = https://claytron.github.io/resume
PANDOC        = pandoc
RESUME_MD     = resume.md
TEMPLATE_HTML = template.html
CSS_FILE      = style.css
COVER_LETTER  ?= tmp/cover-letter.md

.PHONY: help clean html pdf all cover-letter

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML file"
	@echo "  pdf        to make PDF file"
	@echo "  all        to make both HTML and PDF"
	@echo "  cover-letter  to make cover letter PDF (use COVER_LETTER=path to specify file)"
	@echo "  clean      to remove build files"
	@echo "  publish    to publish to GitHub Pages"

clean:
	rm -rf $(BUILDDIR)
	rm -rf .venv

$(BUILDDIR):
	uv sync
	mkdir -p $(BUILDDIR)

html: $(BUILDDIR)
	. .venv/bin/activate && $(PANDOC) $(RESUME_MD) \
		--template=$(TEMPLATE_HTML) \
		--css=$(CSS_FILE) \
		--variable=favicon:favicon.svg \
		--variable=pagetitle:"Clayton Parker | Cloud Archaeologist" \
		--variable=html:true \
		--filter=.venv/bin/pandoc-include \
		--standalone \
		--output=$(BUILDDIR)/index.html
	cp $(CSS_FILE) $(BUILDDIR)/
	cp favicon.svg $(BUILDDIR)/
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/index.html."
	which open && open -a Firefox _build/index.html

pdf: $(BUILDDIR)
	. .venv/bin/activate && $(PANDOC) $(RESUME_MD) \
		--template=$(TEMPLATE_HTML) \
		--css=$(CSS_FILE) \
		--variable=pagetitle:"Clayton Parker's Resume" \
		--filter=.venv/bin/pandoc-include \
		--pdf-engine=weasyprint \
		--output=$(BUILDDIR)/Clayton\ Parker\'s\ Resume.pdf
	@echo
	@echo "Build finished. The PDF is in $(BUILDDIR)/Clayton Parker's Resume.pdf."
	which open && open $(BUILDDIR)/Clayton\ Parker\'s\ Resume.pdf || rifle $(BUILDDIR)/Clayton\ Parker\'s\ Resume.pdf

cover-letter: $(BUILDDIR)
	. .venv/bin/activate && $(PANDOC) $(COVER_LETTER) \
		--template=$(TEMPLATE_HTML) \
		--css=$(CSS_FILE) \
		--variable=pagetitle:"Clayton Parker's Cover Letter" \
		--filter=.venv/bin/pandoc-include \
		--pdf-engine=weasyprint \
		--output=tmp/Clayton\ Parker\'s\ Cover\ Letter.pdf
	@echo
	@echo "Build finished. The cover letter PDF is in $(BUILDDIR)/Clayton Parker's Cover Letter.pdf."
	which open && open tmp/Clayton\ Parker\'s\ Cover\ Letter.pdf || rifle tmp/Clayton\ Parker\'s\ Cover\ Letter.pdf

all: html pdf

# This will fail, on purpose.
dirty:
	[ -n "$(shell git status -s)" ] && echo 'There are unsaved changes. Please commit.' && exit 1 || true

clean_perso:
	truncate -s 0 contact-info.md

# Publish to GitHub Pages
publish: clean_perso dirty html
	cp -r $(BUILDDIR) /tmp/rhtml
	touch /tmp/rhtml/.nojekyll
	cp .gitignore /tmp/rhtml/.
	git checkout gh-pages
	rsync -av --exclude=.git/ --exclude=tmp/ --exclude=CLAUDE.md --exclude=.venv/ --delete /tmp/rhtml/ .
	git add .
	git commit -m 'new build'
	git push origin gh-pages
	git checkout master
	rm -rf /tmp/rhtml
	@echo
	@echo 'Congrats. Published.'
	open $(GITHUBIO)
