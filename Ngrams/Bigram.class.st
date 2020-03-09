"
I am a class that gets bigram data

the idea is to:
-calculate frequency of the word before cursor
-calculate how often that word is followed by the tokens from the list of suggestions
-hand over those calculations to be used in the sorter
"
Class {
	#name : #Bigram,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #utilities }
Bigram >> getFrequencyOf: aWord [
	^ self getFrequencyOf: aWord from: model
]

{ #category : #utilities }
Bigram >> getFrequencyOf: aWord from: aModel [
	
	^ (aModel at: aWord ifAbsent: 0)
]

{ #category : #utilities }
Bigram >> readFile [
	model := NgramModel readFromDirectory: TokenProcessing dataFolder
]
