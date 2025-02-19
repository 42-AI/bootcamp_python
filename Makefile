DIRECTORIES = 	module00 \
				module01 \
				module02 \
				module03 \
				module04

TARGETS_DIRS = $(DIRECTORIES:%=%/subject/en.subject.pdf)

TARGETS = 	$(DIRECTORIES:%=%.pdf)

all: clean dirs

%.pdf: 
	@echo "We are taking care of: $@"
	@$(MAKE) -C $(shell dirname $@)
	@$(MAKE) clean -C $(shell dirname $@)
	cp $@ build/$(shell dirname `dirname $@`).pdf

dirs: $(TARGETS_DIRS)


build_pdfs:
	sudo docker run -v "$(shell pwd)/build:/data/bootcamp_python/build" -i latex_build_py make

build_builder:
	sudo docker build -t latex_build_py .

clean:
	rm -rf $(TARGETS) $(TARGETS_DIRS)

debug:
	echo $(TARGETS_DIRS)
