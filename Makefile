JEKYLL      := jekyll
NPM         := npm
ASSETS_DIR  := assets/
SASS_DIR    := _sass/
JS_DIR      := assets/js/

install:
	bundle
	$(NPM) install

include-npm-deps:
	mkdir -p $(JS_DIR)
	cp node_modules/jquery/dist/jquery.min.js $(JS_DIR)
	cp node_modules/popper.js/dist/umd/popper.min.js $(JS_DIR)
	cp node_modules/bootstrap/dist/js/bootstrap.min.js $(JS_DIR)
	cp -R node_modules/bootstrap/scss $(SASS_DIR)bootstrap

build: install include-npm-deps
	$(JEKYLL) build

serve: install include-npm-deps
	JEKYLL_ENV=production $(JEKYLL) serve
