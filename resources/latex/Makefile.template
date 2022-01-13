# List the pdf's to build. foo.tex will produce foo.pdf
TARGETS = foo.pdf

# List the files included in the slides
DEPS = somePicture.png someSound.flac someOtherPicture.png

# Relative path to the LaTeX documentclass setup files
# Adapt as needed
RELPATH = $(shell git rev-parse --show-toplevel)/templates/latex/

# You should not touch this either
include $(RELPATH)/Makefile.LaTeX
