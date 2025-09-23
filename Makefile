app := $(project)/app/dist/index.html
app_root := $(shell find $(project)/app -maxdepth 1 -name '*.json' -o -name '*.mjs')
app_public := $(shell find $(project)/app/public -type f)
app_src := $(shell find $(project)/app/src -type f)
app_tests := $(shell find $(project)/app/tests -type f)

workshop := $(project)/workshop/dist/index.html
workshop_root := $(shell find $(project)/workshop -maxdepth 1 -name '*.json' -o -name '*.mjs')
workshop_public := $(shell find $(project)/workshop/public -type f)
workshop_src := $(shell find $(project)/workshop/src -name '*.scss')

.PHONY: build clean deploy prepare

build: $(app)
prepare: $(workshop)

$(app): $(app_root) $(app_public) $(app_src) $(app_tests) $(workshop)
	@app build

$(workshop): $(workshop_root) $(workshop_public) $(workshop_src)
	@app prepare

deploy: build
	@app deploy

clean:
	@app clean
	@workshop clean
