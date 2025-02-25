CMD = pandoc

METADATA_FILES = metadata.yaml
MD_FILES = \
	Compto-AML-Policy.md \
	Compto-Customer-Identification-Program.md \
	Compto-Data-Retention-Policy.md \
	Compto-Information-Security-Policy.md \
	Compto-Privacy-Policy.md \
	Compto-Production-Asset-Management-Policy.md \
	Compto-Security-Incident-Response-Process.md \
	Compto-User-Agreement.md \
#
PDF_FILES = $(patsubst %.md,%.pdf,$(MD_FILES))

default: all
all: $(PDF_FILES)

$(PDF_FILES): %.pdf: $(METADATA_FILES) %.md
	${CMD} -o $@ $^

.PHONY: list
list: # list all targets
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: clean
clean: # clean all generated files
	rm -f $(PDF_FILES)