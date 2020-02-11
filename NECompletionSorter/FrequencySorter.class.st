"
I sort elements of a collection based on a dictionary of frequencies
"
Class {
	#name : #FrequencySorter,
	#superclass : #Object,
	#instVars : [
		'frequencies'
	],
	#category : #NECompletionSorter
}

{ #category : #accessing }
FrequencySorter >> frequencies [
	^ frequencies
]

{ #category : #accessing }
FrequencySorter >> frequencies: anObject [
	frequencies := anObject
]

{ #category : #sorting }
FrequencySorter >> sort: anOrderedCollection [

	^ anOrderedCollection sort: [ :a :b |
		(frequencies at: a ifAbsent: 0) > (frequencies at: b ifAbsent: 0) ]
]
