BOOKS := $(shell ls -d */ | grep --invert "util")

test:
	$(foreach book, $(BOOKS), cd $(book)/ && xmllint --noout --dtdvalid ../util/dtd/culiturgical.dtd chapters/*.xml || exit $$?; cd ..;)
	$(foreach book, $(BOOKS), cd $(book)/ && xmllint --noout --dtdvalid ../util/dtd/manifest.dtd manifest.xml || exit $$?; cd ..;)

