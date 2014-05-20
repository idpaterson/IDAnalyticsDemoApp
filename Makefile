# Generates documentation

all: docs

.PHONY: docs clean

docs: clean
	appledoc \
	--output appledoc/ \
	--project-name "IDAnalyticsDemoApp" \
	--project-version "`git describe  --long --abbrev=7 |sed -e 's/v//g' -e 's/-/./g'`" \
	--project-company "Ian Paterson" \
	--company-id io.github.idpaterson \
	--create-html \
	--verbose 2 \
	--keep-intermediate-files \
	--no-repeat-first-par \
	--explicit-crossref \
	--docset-platform-family iphoneos \
	--exit-threshold 2 \
	IDAnalyticsDemoApp
	cp -R appledoc/html/* docs/

clean:
	rm -rf appledoc
	find docs -depth 1 -not -name ".*" -exec rm -rf {} \;

