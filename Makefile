DIRECTORIES = 	module00 \
				module01 \
				module02 \
				module03 \
				module04

TARGETS_DIRS = $(DIRECTORIES:%=%/subject/en.subject.pdf)

TARGETS = 	$(DIRECTORIES:%=%.pdf)

$(info "From top Makefile")

all: clean dirs

%.pdf: 
	@$(MAKE) -C $(shell dirname $@)
	cp $@ $(shell dirname `dirname $@`).pdf

dirs: $(TARGETS_DIRS)


clean:
	rm -rf $(TARGETS) $(TARGETS_DIRS)

debug:
	echo $(TARGETS_DIRS)
