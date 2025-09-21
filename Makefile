build 	:= $(project)/.devbox/.build
prepare := $(project)/.devbox/.prepare

fonts := $(wildcard $(project)/workshop/public/fonts/*.ttf)
scss 	:= $(shell find $(project)/workshop/src/styles -name '*.scss')

.PHONY: build prepare clean

build: $(build)
prepare: $(prepare)

$(build): $(prepare)
	@app build
	@touch $(build)

$(prepare): $(fonts) $(scss) $(project)/workshop/astro.config.mjs
	@app prepare
	@touch $(prepare)

clean:
	@app clean
	@workshop clean
	@rm -f $(build) $(prepare)
