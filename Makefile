app := $(project)/app/dist/index.html
app_src := $(shell find $(project)/app -name '*.astro' -o -name '*.elm' -o -name '*.json' -o -name '*.mjs')

workshop := $(project)/workshop/dist/index.html
workshop_src := $(shell find $(project)/workshop -name '*.mjs' -name '*.scss' -o -name '*.ttf')

.PHONY: build clean deploy prepare

build: $(app)
prepare: $(workshop)

$(app): $(app_src) $(workshop)
	@app build

$(workshop): $(workshop_src)
	@app prepare

deploy: build
	@app deploy

clean:
	@app clean
	@workshop clean
