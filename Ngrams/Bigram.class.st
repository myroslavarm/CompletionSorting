"
I am class that gets a Bigram model using the NgramModel library -- WIP
"
Class {
	#name : #Bigram,
	#superclass : #Object,
	#instVars : [
		'model',
		'probabilities'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #utilities }
Bigram >> getFrequencyOf: aWord [
	^ self getFrequencyOf: aWord from: model
]

{ #category : #utilities }
Bigram >> getFrequencyOf: aWord from: aModel [
	
	^ aModel at: aWord ifAbsent: 0
]

{ #category : #accessing }
Bigram >> probabilitiesFromModel: aModel history: aHistory andCollection: anOrderedCollection [
	| collection ngrams |
	collection := anOrderedCollection collect: [ :each | each contents asString ].
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

{ #category : #utilities }
Bigram >> readFile [
	| file |
	file := TokenProcessing dataFolder / BigramTableCreator new bigramFile.
	model := NgramModel readFromFile: file.
	^ model
]
