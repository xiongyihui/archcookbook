# Arch Cookbook #
Arch Cookbook is a cookbook to get started with [mbed](http://mbed.org/).

## Formats ##
The book uses [The Little Mongodb Book](https://github.com/karlseguin/the-little-mongodb-book) as a starting point, is written in [Markdown](http://daringfireball.net/projects/markdown/) and converted to PDF using [Pandoc](http://johnmacfarlane.net/pandoc/).

The TeX template makes use of [Lena Herrmann's JavaScript highlighter](http://lenaherrmann.net/2010/05/20/javascript-syntax-highlighting-in-the-latex-listings-package).

Kindle and ePub format provided using [Pandoc](http://johnmacfarlane.net/pandoc/).

## Generating books ##
On Ubuntu

```
sudo apt-get install pandoc texlive texlive-xetex texlive-latex-extra texlive-latex-recommended ruby mercurial
make en.markdown                                 # update markdown file
make en.pdf                                      # generate pdf
make en.epub                                     # generate epub
```

You should have "DejaVu Serif" and "Droid Sans Mono" fonts installed too. But you could change fonts in `common/pdf-template.tex` file if you want.

For Mobi, you should have [KindleGen](http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211) installed. Run `make en.mobi`.

For mbed wiki, you should have [redcarpet](https://github.com/vmg/redcarpet) installed. Run `make archcookbook.en.wiki`.


