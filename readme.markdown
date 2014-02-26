# Arch Cookbook #
Arch Cookbook is a cookbook to get started with [mbed](http://mbed.org/).

## Formats ##
The book uses [The Little Mongodb Book](https://github.com/karlseguin/the-little-mongodb-book) as a starting point, is written in [Markdown](http://daringfireball.net/projects/markdown/) and converted to PDF using [Pandoc](http://johnmacfarlane.net/pandoc/).

The TeX template makes use of [Lena Herrmann's JavaScript highlighter](http://lenaherrmann.net/2010/05/20/javascript-syntax-highlighting-in-the-latex-listings-package).

Kindle and ePub format provided using [Pandoc](http://johnmacfarlane.net/pandoc/).

## Generating books ##
Packages listed below are for Ubuntu. If you use another OS or distribution names would be similar.

### PDF

#### Dependencies

Packages:

* `pandoc`
* `texlive-xetex`
* `texlive-latex-extra`
* `texlive-latex-recommended`

You should have "DejaVu Serif" and "Droid Sans Mono" fonts installed too. But you could change fonts in `common/pdf-template.tex` file if you want.

#### Building

Run `make en.pdf`.

### ePub

#### Dependencies

Packages:

* `pandoc`

#### Building

Run `make en.epub`.

### Mobi

#### Dependencies

Packages:

* `pandoc`

You should have [KindleGen](http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211) installed too.

#### Building

Run `make en.mobi`.

