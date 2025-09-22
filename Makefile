build   := $(project)/.devbox/.build
prepare := $(project)/.devbox/.prepare

fonts := $(wildcard $(project)/workshop/public/fonts/*.ttf)
scss  := $(shell find $(project)/workshop/src/styles -name '*.scss')
src   := $(shell find $(project)/app -name '*.astro' -o -name '*.elm' -o -name '*.json' -o -name '*.mjs')

.PHONY: build prepare clean

build: $(build)
prepare: $(prepare)

$(build): $(prepare) $(src)
	@app build
	@touch $(build)

$(prepare): $(fonts) $(scss) $(project)/workshop/astro.config.mjs
	@app prepare
	@touch $(prepare)

clean:
	@app clean
	@workshop clean
	@rm -f $(build) $(prepare)
