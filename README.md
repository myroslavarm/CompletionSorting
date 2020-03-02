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

## Unigram Sorting
### Sorting Strategies Info
- we already have a Frequency based sorter, which is now fast enough to use when using code completion

### Testing for yourself
- Settings -> Code Completion -> Sorter
- choose `FrequencyCompletionSorter`

## Bigram Sorting
For now we have the 5k pairs of tokens and their frequencies loaded. 
### TODO:
- get probabilities based on history
- decide how to deal with first and second tokens separately
