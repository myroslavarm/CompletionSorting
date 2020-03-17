"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'model',
		'probabilities',
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

	bigram := Bigram new.
	sorter := BigramSorter new.
	model := Bigram new readFile
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [

	probabilities := bigram probabilitiesFromModel: model 
		history: self getWordBefore andCollection: anOrderedCollection. 
	sorter probabilities: probabilities.
	^ sorter sort: anOrderedCollection
]
