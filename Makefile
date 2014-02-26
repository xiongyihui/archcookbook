BOOK_FILE_NAME = archcookbook

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--latex-engine xelatex \
	--template common/pdf-template.tex \
	--listings

EPUB_BUILDER = pandoc
EPUB_BUILDER_FLAGS = \
	--epub-cover-image

MOBI_BUILDER = kindlegen

archcookbook.en.markdown:
	util/md2markdown.rb

en.wiki:
	util/md2wiki.rb

en.pdf: archcookbook.en.markdown
	$(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $^ -o $(BOOK_FILE_NAME).$@

en.epub: common/title.png common/title.txt archcookbook.en.markdown
	$(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) $^ -o $(BOOK_FILE_NAME).$@

en.mobi: archcookbook.en.epub
	$(MOBI_BUILDER) $^

clean:
	rm -f $(BOOK_FILE_NAME)*.markdown
	rm -f $(BOOK_FILE_NAME)*.pdf
	rm -f $(BOOK_FILE_NAME)*.epub
	rm -f $(BOOK_FILE_NAME)*.mobi
