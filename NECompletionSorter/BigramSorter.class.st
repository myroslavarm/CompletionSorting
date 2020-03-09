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
]

{ #category : #utilities }
BigramSorter >> getProbabilitiesFromUnigrams: aUnigramTable andBigrams: aBigramTable [
	| historyMapping ngramMapping results |
	historyMapping := self mapHistoryfrom: aUnigramTable.
	ngramMapping := self mapNgramPairsFrom: aBigramTable.
	results := Dictionary new.
	ngramMapping do: [ :each | 
		((historyMapping second asNumber = 0)
		ifTrue: [ results add: (each first substrings) second -> 0.0 ]
		ifFalse: [ results add: (each first substrings) second -> 
			(each second asNumber / historyMapping second asNumber) asFloat ]) ].
	^ results
]

{ #category : #utilities }
BigramSorter >> mapHistoryfrom: aTable [

	^ {history . Bigram new getFrequencyOf: history from: aTable}
]

{ #category : #utilities }
BigramSorter >> mapNgramPairsFrom: aTable [
	
	^ ngrams collect: [ :each |
		{each . (Bigram new getFrequencyOf: each from: aTable )} ]
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
