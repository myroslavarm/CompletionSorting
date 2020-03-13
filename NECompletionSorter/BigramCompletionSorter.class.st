"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'model'
	],
	#category : #NECompletionSorter
}

{ #category : #sorting }
BigramCompletionSorter >> initialize [
	sorter := BigramSorter new.
	model := Bigram new readFile
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [
	| history collection probabilities |
	history := context source wordBefore: context position  - context completionToken size - 1.
	collection := anOrderedCollection collect: [ :each | each contents asString ].
	probabilities := sorter probabilitiesFromModel: model 
		history: history andCollection: collection. 
	sorter probabilities: probabilities.
	^ sorter sort: anOrderedCollection
]
