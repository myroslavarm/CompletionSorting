# CompletionSorting
[![Build Status](https://travis-ci.org/myroslavarm/CompletionSorting.svg?branch=master)](https://travis-ci.org/myroslavarm/CompletionSorting)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)

This project extends the default completion engine in Pharo 9 to add N-gram based sorting strategies.
The idea with using N-grams for sorting is to get completions that are most likely to be used given a certain context, based on source code history loaded from https://gitlab.inria.fr/rmod-public/2019-sourcecodedata.

## Setup Info
In order to load the repo and its dependencies, execute:
```{Smalltalk}
Metacello new
  baseline: 'CompletionSorting';
  repository: 'github://myroslavarm/CompletionSorting/';
  load.
```

> **_NOTE:_**  This is still in development and only works on Pharo 9. However, you should be able to use the Frequency sorter without any problems.

## Background
### Frequency based code completion
the unigram approach where we take into consideration the number of token occurences in history and sort the completion candidates based on that
### Bigram based code completion
the results are sorted based on the probability of them occuring given a previous history word, i.e. (occurences of the token before followed by the token being completed / total occurences of the token before), such as:

![example](https://github.com/myroslavarm/CompletionSorting/blob/master/example.PNG)

The bigram model is trained using the Pharo N-gram library https://github.com/pharo-ai/NgramModel.

## Using the Sorter
### Sorting Strategies Info
- we already have a Frequency based sorter, which is now fast enough to use when using code completion
- now the Bigram sorter is also available (there are some millisecond pauses but it's not critically slow)

### Testing for yourself
- Settings -> Code Completion -> Sorter
- choose `FrequencyCompletionSorter` or `BigramCompltionSorter`
