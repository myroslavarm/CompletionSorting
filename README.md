# CompletionSorting
[![Build Status](https://travis-ci.org/myroslavarm/CompletionSorting.svg?branch=master)](https://travis-ci.org/myroslavarm/CompletionSorting)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)

## Setup Info
In order to load the repo and its dependencies, execute:
```{Smalltalk}
Metacello new
  baseline: 'CompletionSorting';
  repository: 'github://myroslavarm/CompletionSorting/';
  load.
```

## Ngram-based Sorting
### Sorting Strategies Info
- we already have a Frequency based sorter, which is now fast enough to use when using code completion
- now the Bigram sorter is also available (there are some millisecond pauses but it's not critically slow)

### Testing for yourself
- Settings -> Code Completion -> Sorter
- choose `FrequencyCompletionSorter` or `BigramCompltionSorter`

### Backlog
- decide how to deal with first and second tokens separately
- fix other items from Issues
