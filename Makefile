DIRECTORIES = 	module05 \
				module06 \
				module07 \
				module08 \
				module09


TARGETS_DIRS = $(DIRECTORIES:%=%/en.subject.pdf)

TARGETS = 	module05.pdf \
			module06.pdf \
			module07.pdf \
			module08.pdf \
			module09.pdf

all: clean dirs


%.pdf: 
	@$(MAKE) -C `dirname $@`
	cp $@ `dirname $@`.pdf

dirs: $(TARGETS_DIRS)


clean:
	rm -rf $(TARGETS) $(TARGETS_DIRS)

debug:
	echo $(TARGETS_DIRS)
