"
I sort completions based on frequencies
"
Class {
	#name : #FrequencyCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter'
	],
	#category : #'NECompletionSorter-Unigram'
}

{ #category : #description }
FrequencyCompletionSorter class >> kind [

	^ 'experimental'
]

{ #category : #sorting }
FrequencyCompletionSorter >> initialize [
	sorter := FrequencySorter new.
	sorter frequencies: Unigram uniqueInstance frequencies
]

{ #category : #sorting }
FrequencyCompletionSorter >> sortCompletionList: anOrderedCollection [

	^ sorter sort: anOrderedCollection
]
