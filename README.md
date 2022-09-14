# cu-books

[![Build Status](https://travis-ci.org/slavonic/cu-books.svg?branch=master)](https://travis-ci.org/slavonic/cu-books)

Church Slavonic text corpus

This corpus contains Church Slavonic liturgical texts in XML format
as well as utilities for working with these texts.

**Note** that this corpus is now deprecated.
All texts are available in Markdown format in the
[cu-md-sandbox repository](https://github.com/slavonic/cu-md-sandbox).
You should use those texts, and any further updates should
be pushed to that repository.

## Validate xml files
```
make test
```

## Correction of errors in corpus

Errors and typos are corrected and committed with the @erratum flag.
To generate a list of all corrected errors and typos, type:

```
make erratum
```

This produces `erratum.diff`. To clean up, type:

```
make clean
```


