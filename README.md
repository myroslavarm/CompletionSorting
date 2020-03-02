# CompletionSorting
[![Build Status](https://travis-ci.com/myroslavarm/CompletionSorting.svg?branch=master)](https://travis-ci.org/myroslavarm/CompletionSorting/)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)

## Setup Info
- needs DataFrame (installation script [here](https://github.com/PolyMathOrg/DataFrame)) and NeoCSV (installation script [here](https://github.com/svenvc/NeoCSV)) dependencies loaded
- should already have the data files fetched with this repo

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
