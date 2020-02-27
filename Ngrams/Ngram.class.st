Class {
	#name : #Ngram,
	#superclass : #Object,
	#instVars : [
		'words',
		'frequency'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'as yet unclassified' }
Ngram class >> fromString: aString [
	| substrings words frequency |
	substrings := aString substrings.
	words := substrings copyFrom: 1 to: substrings size - 1.
	frequency := substrings last asInteger.
	
	^ self words: words frequency: frequency
]

{ #category : #'as yet unclassified' }
Ngram class >> words: aCollectionOfWords frequency: aNumber [ 
	^ self new initializeWords: aCollectionOfWords frequency: aNumber
]

{ #category : #converting }
Ngram >> asString [
	^ ' ' join: (words copyWith: frequency asString).
]

{ #category : #accessing }
Ngram >> frequency [
	^ frequency
]

{ #category : #initialization }
Ngram >> initializeWords: aCollectionOfWords frequency: aNumber [ 
	words := aCollectionOfWords.
	frequency := aNumber
]

{ #category : #accessing }
Ngram >> words [
	^ words
]
