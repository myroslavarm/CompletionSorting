"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'history',
		'model',
		'probabilities',
		'ngrams',
		'collection'
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
	history := context source wordBefore: context position  - context completionToken size - 1.
	collection := anOrderedCollection collect: [ :each | each contents asString ].
	ngrams := sorter getHistory: history andCollection: collection.
	probabilities := sorter probabilitiesFromModel: model withNgrams: ngrams.
	sorter probabilities: probabilities.
	^ sorter sort: anOrderedCollection
]
