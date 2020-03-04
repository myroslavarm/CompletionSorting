"
I sort elements of a collection based on bigrams
"
Class {
	#name : #BigramSorter,
	#superclass : #Object,
	#instVars : [
		'history',
		'collection',
		'ngrams',
		'probabilities'
	],
	#category : #'NECompletionSorter-Bigram'
}

{ #category : #utilities }
BigramSorter >> getHistory: aPreviousWord andCollection: aCollection [
	
	history := aPreviousWord.
	collection := aCollection.
	ngrams := collection collect: [ :each | (Character space join: {history . each}) ].
	^ ngrams
]

{ #category : #accessing }
BigramSorter >> probabilities [
	^ probabilities
]

{ #category : #accessing }
BigramSorter >> probabilities: anObject [
	probabilities := anObject
]

{ #category : #sorting }
BigramSorter >> sort: anOrderedCollection [

	^ anOrderedCollection sort: [ :a :b |
		(probabilities at: a ifAbsent: 0) > (probabilities at: b ifAbsent: 0) ]
]
