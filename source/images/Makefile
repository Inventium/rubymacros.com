# Makefile for images

# Change to use environment variable instead of hard path
INKSCAPE = /Applications/Inkscape.app/Contents/Resources/bin/inkscape

PDFS =  macro.pdf

pdfs: $(PDFS)

%.pdf : %.svg
	$(INKSCAPE) -f $< --export-pdf $@


clean:
	rm -rf *~ *.pdf

