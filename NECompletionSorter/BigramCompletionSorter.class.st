"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'model',
		'bigram'
	],
	#category : #NECompletionSorter
}

{ #category : #accessing }
BigramCompletionSorter >> getWordBefore [
	^ context source wordBefore: context position  - context completionToken size - 1
]

{ #category : #sorting }
BigramCompletionSorter >> initialize [

	sorter := BigramSorter new.
	bigram := Bigram new.
	model := bigram readFile
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [
	| probabilities |
	probabilities := bigram probabilitiesFromModel: model
					history: self getWordBefore
					andCollection: anOrderedCollection. 
	sorter probabilities: probabilities.
	^ sorter sort: anOrderedCollection
]
