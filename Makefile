APP_FILES=$(shell find lib/assets/**/*.coffee)
TEST_FILES=$(shell find test/*.coffee)

# For continuous rebuild of packages: `watch make .all`
.all: .app .test
	touch .all

# for now, exactly the same as .all
.pretestem: .all

.app: $(APP_FILES)
	browserify $(APP_FILES) -o dist/twine.js -t coffeeify

.test: $(TEST_FILES)
	browserify $(TEST_FILES) -o test/test_bundle.js -t coffeeify

.uglify: .app
	node_modules/uglify-js/bin/uglifyjs dist/twine.js -o dist/twine.min.js
