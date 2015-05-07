#!/usr/bin/env bash

# TODO: move this stuff into the make file

[ -n "$1" ] && height="$1" || height='860mm'

make clean && make html

rsync -av _build/html/ claytron.com:/usr/local/www/data/resume

wkhtmltopdf --user-style-sheet pdf.css  -B 0 -L 0 -R 0 -T 0 --page-width 210mm --page-height $height --disable-forms page http://claytron.com/static/resume/ _build/html/clayton_parker_resume.pdf

rsync -av _build/html/ claytron.com:/usr/local/www/data/resume

echo
echo 'WARNING: Check the bottom of the file to see if it made a page break.'
echo 'Then pass in the height accordingly'
