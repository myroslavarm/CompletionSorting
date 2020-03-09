"
I am class that gets a Bigram model using the NgramModel library -- WIP
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
