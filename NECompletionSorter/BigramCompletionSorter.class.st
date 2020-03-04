"
I sort completions based on bigram frequencies
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'history',
		'ngram',
		'token',
		'pairs'
	],
	#category : #'NECompletionSorter-Bigram'
}

{ #category : #initialization }
BigramCompletionSorter >> initialize [
	sorter := BigramSorter new.
	"history := FrequencyTable uniqueInstance frequencyFor: token.
	ngram := BigramData new frequencyFor: pairs.
	sorter bigrams: (ngram / history)"
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [

	^ sorter sort: anOrderedCollection
]
