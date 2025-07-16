# Makefile for Resume (Pandoc-based)
#

# You can set these variables from the command line.
BUILDDIR      = _build
GITHUBIO      = https://claytron.github.io/resume
PANDOC        = pandoc
RESUME_MD     = resume.md
TEMPLATE_HTML = template.html
CSS_FILE      = style.css

.PHONY: help clean html pdf all

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML file"
	@echo "  pdf        to make PDF file"
	@echo "  all        to make both HTML and PDF"
	@echo "  clean      to remove build files"
	@echo "  publish    to publish to GitHub Pages"

clean:
	rm -rf $(BUILDDIR)/*

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

html: $(BUILDDIR)
	$(PANDOC) $(RESUME_MD) \
		--template=$(TEMPLATE_HTML) \
		--css=$(CSS_FILE) \
		--variable=favicon:favicon.svg \
		--variable=pagetitle:"Clayton Parker | Cloud Archaeologist" \
		--standalone \
		--output=$(BUILDDIR)/index.html
	cp $(CSS_FILE) $(BUILDDIR)/
	cp favicon.svg $(BUILDDIR)/
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/index.html."

pdf: $(BUILDDIR)
	$(PANDOC) $(RESUME_MD) \
		--template=$(TEMPLATE_HTML) \
		--css=$(CSS_FILE) \
		--variable=pagetitle:"Clayton Parker's Resume" \
		--pdf-engine=weasyprint \
		--output=$(BUILDDIR)/Clayton\ Parker\'s\ Resume.pdf
	@echo
	@echo "Build finished. The PDF is in $(BUILDDIR)/Clayton Parker's Resume.pdf."
	which open && open $(BUILDDIR)/Clayton\ Parker\'s\ Resume.pdf || rifle $(BUILDDIR)/Clayton\ Parker\'s\ Resume.pdf

all: html pdf

# This will fail, on purpose.
dirty:
	[ -n "$(shell git status -s)" ] && echo 'There are unsaved changes. Please commit.' && exit 1 || true

# Publish to GitHub Pages
publish: dirty html
	cp -r $(BUILDDIR) /tmp/rhtml
	touch /tmp/rhtml/.nojekyll
	cp .gitignore /tmp/rhtml/.
	git checkout gh-pages
	rsync -av --exclude=.git/ --exclude=env/ --delete /tmp/rhtml/ .
	git add .
	git commit -m 'new build'
	git push origin gh-pages
	git checkout master
	rm -rf /tmp/rhtml
	@echo
	@echo 'Congrats. Published.'
	open $(GITHUBIO)