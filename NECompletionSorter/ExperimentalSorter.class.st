Class {
	#name : #ExperimentalSorter,
	#superclass : #CompletionSorter,
	#category : #NECompletionSorter
}

{ #category : #description }
ExperimentalSorter class >> kind [

	^ 'experimental'
]

{ #category : #sorting }
ExperimentalSorter >> sortCompletionList: aList [

	^ aList asOrderedCollection sort reverse
]
