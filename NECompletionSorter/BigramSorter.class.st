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

{ #category : #utilities }
BigramSorter >> getHistory: aPreviousWord andCollection: aCollection [
	| collection |
	collection := aCollection.
	aPreviousWord = '' ifTrue: [ 
		^ collection collect: [ :each | (Character space join: { '<s>' . each }) ] ].
	^ collection collect: [ :each | (Character space join: { aPreviousWord . each }) ]
]

{ #category : #accessing }
BigramSorter >> probabilities [
	^ probabilities
]

{ #category : #accessing }
BigramSorter >> probabilities: anObject [
	probabilities := anObject
]

{ #category : #accessing }
BigramSorter >> probabilitiesFromModel: aModel withNgrams: anArray [
	probabilities := anArray collect: [ :each | 
			(each substrings second) -> (aModel probabilityOfNgram: (each substrings asArray asNgram)) ].
	^ probabilities asDictionary
]

{ #category : #sorting }
BigramSorter >> sort: anOrderedCollection [

	^ anOrderedCollection sort: [ :a :b |
		(probabilities at: a contents ifAbsent: 0) > (probabilities at: b contents ifAbsent: 0) ]
]
