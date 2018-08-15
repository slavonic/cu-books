BOOKS := $(shell ls -d */ | grep --invert "util")

test:
	$(foreach book, $(BOOKS), cd $(book)/ && xmllint --noout --dtdvalid ../util/dtd/culiturgical.dtd chapters/*.xml || exit $$?; cd ..;)
	$(foreach book, $(BOOKS), cd $(book)/ && xmllint --noout --dtdvalid ../util/dtd/manifest.dtd manifest.xml || exit $$?; cd ..;)

erratum:
	rm -fr erratum.diff
	git log --grep='@erratum' | awk '/commit/{print $$NF}' | xargs -L 1 bash -c 'trap "exit 1" ERR; for commit; do echo Errors fixed in commit $$commit; git diff $$commit; echo ; done' bash > erratum.diff

clean:
	rm -fr erratum.diff
