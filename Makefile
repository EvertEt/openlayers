PLOVR_JAR=bin/plovr-4b3caf2b7d84.jar
comma := ,
empty :=
space := $(empty) $(empty)

.PHONY: all
all: build webgl-debug.js

.PHONY: build
build: ol.js ol-skeleton.js ol-skeleton-debug.js ol-skeleton-dom.js ol-skeleton-webgl.js

.PHONY: ol.js
ol.js: $(PLOVR_JAR)
	java -jar $(PLOVR_JAR) build $(basename $@).json >$@
	@echo $@ "uncompressed:" $(shell wc -c <$@) bytes
	@echo $@ "  compressed:" $(shell gzip -9 -c <$@ | wc -c) bytes

.PHONY: ol-skeleton.js
ol-skeleton.js: $(PLOVR_JAR)
	java -jar $(PLOVR_JAR) build $(basename $@).json >$@
	@echo $@ "uncompressed:" $(shell wc -c <$@) bytes
	@echo $@ "  compressed:" $(shell gzip -9 -c <$@ | wc -c) bytes

.PHONY: ol-skeleton-debug.js
ol-skeleton-debug.js: $(PLOVR_JAR)
	java -jar $(PLOVR_JAR) build $(basename $@).json >$@
	@echo $@ "uncompressed:" $(shell wc -c <$@) bytes
	@echo $@ "  compressed:" $(shell gzip -9 -c <$@ | wc -c) bytes

.PHONY: ol-skeleton-dom.js
ol-skeleton-dom.js: $(PLOVR_JAR)
	java -jar $(PLOVR_JAR) build $(basename $@).json >$@
	@echo $@ "uncompressed:" $(shell wc -c <$@) bytes
	@echo $@ "  compressed:" $(shell gzip -9 -c <$@ | wc -c) bytes

.PHONY: ol-skeleton-webgl.js
ol-skeleton-webgl.js: $(PLOVR_JAR)
	java -jar $(PLOVR_JAR) build $(basename $@).json >$@
	@echo $@ "uncompressed:" $(shell wc -c <$@) bytes
	@echo $@ "  compressed:" $(shell gzip -9 -c <$@ | wc -c) bytes

.PHONY: serve
serve: $(PLOVR_JAR)
	java -jar $(PLOVR_JAR) serve *.json

.PHONY: lint
lint:
	gjslint --strict --limited_doc_files=$(subst $(space),$(comma),$(shell find externs -name \*.js)) $(shell find externs src/ol -name \*.js) skeleton.js

webgl-debug.js:
	curl https://cvs.khronos.org/svn/repos/registry/trunk/public/webgl/sdk/debug/webgl-debug.js > $@

$(PLOVR_JAR):
	curl http://plovr.googlecode.com/files/$(notdir $@) > $@

clean:
	rm -f ol-skeleton.js
	rm -f ol-skeleton-debug.js
	rm -f ol-skeleton-dom.js
	rm -f ol-skeleton-webgl.js

reallyclean: clean
	rm -f $(PLOVR_JAR)
	rm -f webgl-debug.js
