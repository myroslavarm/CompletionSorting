"
I sort completions based on bigram frequencies
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter'
	],
	#category : #'NECompletionSorter-Bigram'
}

{ #category : #initialization }
BigramCompletionSorter >> initialize [
	sorter := FrequencySorter new.
	sorter frequencies: BigramData new bigrams
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [

	^ sorter sort: anOrderedCollection
]
