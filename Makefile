all: version
	docker build -t rstudio/checkrs-deploy:${VERSION} .

clean:

distclean: clean

version:
	$(eval VERSION:=$(shell ./version.sh | tee ./version.txt))
	echo "VERSION=$(VERSION)"

.PHONY: all clean distclean version
