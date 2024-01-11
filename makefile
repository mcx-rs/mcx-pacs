SHELL := /usr/bin/env bash

SVDTOOLS ?= svdtools
SVD2RUST ?= svd2rust
FORM ?= form

DEVICES := mcxn947
YAMLS := $(foreach device, $(DEVICES), svd/$(device).yaml)
PATCHED_SVDS := $(foreach device, $(DEVICES), svd/$(device).svd.patched)
CARGO_TOMLS := $(foreach device, $(DEVICES), pacs/$(device)/Cargo.toml)

svd/%.svd.patched: svd/%.yaml svd/%.svd
	$(SVDTOOLS) patch $<

patch: $(PATCHED_SVDS)

pacs/%/src/lib.rs: svd/%.svd.patched
	rm -rf pacs/$*
	mkdir -p pacs/$*
	svd2rust -c svd2rust.toml -i $< -o pacs/$*
	form -i pacs/$*/lib.rs -o pacs/$*/src
	rm pacs/$*/lib.rs

pacs/%/Cargo.toml: Cargo.toml.template pacs/%/src/lib.rs
	sed 's/@NAME@/$*/g' Cargo.toml.template > $@
	cargo fmt --manifest-path $@

crates: $(CARGO_TOMLS)

clean-patch:
	rm -rf svd/*.svd.patched

clean-crates:
	rm -rf pacs

clean: clean-patch clean-crates