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

{ #category : #accessing }
Bigram >> probabilitiesFromModel: aModel history: aHistory andCollection: anOrderedCollection [
	| collection ngrams probabilities |
	collection := anOrderedCollection collect: [ :each | each contents asString ].
	ngrams := aHistory = ''
		ifTrue: [ collection collect: [ :each |
				(Character space join: { '<s>' . each }) ] ]
		ifFalse: [ collection collect: [ :each |
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
