"
With the help of NgramModel, I create and write to file an ngram model, which will be used by the Bigram class
"
Class {
	#name : #BigramTableCreator,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #transforming }
BigramTableCreator >> processedTokens [
	| cleanedTokens |
	cleanedTokens := TokenProcessing returnProcessedData.
	^ (cleanedTokens column: 'tokens') asArray.
]

{ #category : #transforming }
BigramTableCreator >> writeToFile [
	| tokens |
	model := NgramModel order: 2.
	tokens := self processedTokens.
	model trainOn: tokens.
	model removeNgramsWithCountsLessThan: 50.
	model saveToDirectory: TokenProcessing dataFolder
]
