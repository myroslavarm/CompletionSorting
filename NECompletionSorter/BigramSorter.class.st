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

{ #category : #sorting }
BigramSorter >> sort: anOrderedCollection [

	^ anOrderedCollection sort: [ :a :b |
		(probabilities at: a contents ifAbsent: 0) > (probabilities at: b contents ifAbsent: 0) ]
]
