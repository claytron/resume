# README

## See It

https://claytron.github.io/resume

And believe it.

https://github.com/claytron/resume

## Build It

First, a few things need to be done.

Create a [gh-pages branch](https://help.github.com/articles/creating-project-pages-manually/)

Install dependencies:

```bash
brew bundle
```

Now create a PDF:

```bash
make pdf

## With contact info
vim contact-info.md
## Add info to be included
make pdf
```

Or build HTML:

```bash
make html
```

Or build both:

```bash
make all
```

Or push the latest changes to GitHub Pages:

```bash
make publish
```
