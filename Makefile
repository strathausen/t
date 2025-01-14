BIN = node_modules/.bin
DOCSRC = $(shell find docs -name '*.md')
DOCTRG = $(DOCSRC:.md=.html)


.PHONY: cleandocs docs install lint mocha


all: lint test

cleandocs:
	rm -f $(DOCTRG)

docs: $(DOCTRG)

install:
	npm link

lint:
	$(BIN)/jshint ./lib/*.js --config lint.json

mocha:
	rm -Rf test/.todo
	$(BIN)/mocha --growl --reporter 'dot' --require should ./test/*.test.js

%.html: %.md
	@echo "... $< -> $@"
	@markdown $< \
	  | cat docs/layout/head.html - docs/layout/foot.html \
	  > $@
