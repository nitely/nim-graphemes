clean:
	rm -fr docs/*

docs:
	nim doc2 -o:./docs/index.html ./src/graphemes.nim

.PHONY: clean docs
