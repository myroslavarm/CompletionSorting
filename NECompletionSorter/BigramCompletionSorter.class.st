"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter'
	],
	#category : #NECompletionSorter
}

{ #category : #sorting }
BigramCompletionSorter >> initialize [
	sorter := FrequencySorter new.
	sorter frequencies: Unigram uniqueInstance frequencies
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [

	^ sorter sort: anOrderedCollection
]
