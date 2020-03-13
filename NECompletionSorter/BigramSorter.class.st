"
I am a class for sorting based on ngrams
"
Class {
	#name : #BigramSorter,
	#superclass : #Object,
	#instVars : [
		'probabilities'
	],
	#category : #NECompletionSorter
}

{ #category : #accessing }
BigramSorter >> probabilities: anObject [
	probabilities := anObject
]

{ #category : #accessing }
BigramSorter >> probabilitiesFromModel: aModel history: aHistory andCollection: aCollection [
	| collection ngrams |
	collection := aCollection.
	ngrams := Array new.
	aHistory = ''
		ifTrue: [ ngrams := collection collect: [ :each |
				(Character space join: { '<s>' . each }) ] ]; 
		ifFalse: [ ngrams := collection collect: [ :each |
				(Character space join: { aHistory . each }) ] ].
	probabilities := ngrams collect: [ :each | (each substrings second) ->
		(aModel probabilityOfNgram: (each substrings asArray asNgram)) ].
	^ probabilities asDictionary
]

{ #category : #sorting }
BigramSorter >> sort: anOrderedCollection [

	^ anOrderedCollection sort: [ :a :b |
		(probabilities at: a contents ifAbsent: 0) > (probabilities at: b contents ifAbsent: 0) ]
]
