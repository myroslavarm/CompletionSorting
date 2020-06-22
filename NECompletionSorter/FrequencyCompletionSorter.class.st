"
I sort completions based on frequencies
"
Class {
	#name : #FrequencyCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter'
	],
	#category : #NECompletionSorter
}

{ #category : #description }
FrequencyCompletionSorter class >> kind [

	^ 'experimental'
]

{ #category : #utilities }
FrequencyCompletionSorter >> frequencies [

	^ UnigramTableCreator new readFile
]

{ #category : #sorting }
FrequencyCompletionSorter >> initialize [
	sorter := FrequencySorter new.
	sorter frequencies: self frequencies
]

{ #category : #sorting }
FrequencyCompletionSorter >> sortCompletionList: anOrderedCollection [
	^ sorter sort: anOrderedCollection
]
