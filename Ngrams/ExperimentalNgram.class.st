"
I handle the ngrams
"
Class {
	#name : #ExperimentalNgram,
	#superclass : #Object,
	#instVars : [
		'words',
		'frequency'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'as yet unclassified' }
ExperimentalNgram class >> fromString: aString [
	| substrings words frequency |
	substrings := aString substrings.
	words := substrings copyFrom: 1 to: substrings size - 1.
	frequency := substrings last asInteger.
	
	^ self words: words frequency: frequency
]

{ #category : #'as yet unclassified' }
ExperimentalNgram class >> words: aCollectionOfWords frequency: aNumber [ 
	^ self new initializeWords: aCollectionOfWords frequency: aNumber
]

{ #category : #converting }
ExperimentalNgram >> asString [
	^ ' ' join: (words copyWith: frequency asString).
]

{ #category : #accessing }
ExperimentalNgram >> frequency [
	^ frequency
]

{ #category : #initialization }
ExperimentalNgram >> initializeWords: aCollectionOfWords frequency: aNumber [ 
	words := aCollectionOfWords.
	frequency := aNumber
]

{ #category : #accessing }
ExperimentalNgram >> words [
	^ words
]
