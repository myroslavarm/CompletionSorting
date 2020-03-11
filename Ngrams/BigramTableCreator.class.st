"
With the help of NgramModel, I create and write to file an ngram model, which will be used by the Bigram class
"
Class {
	#name : #BigramTableCreator,
	#superclass : #Object,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #transforming }
BigramTableCreator >> model [
	| model tokens |
	model := NgramModel order: 2.
	tokens := self processedTokens.
	model trainOn: tokens.
	model removeNgramsWithCountsLessThan: 50.
	^ model
]

{ #category : #transforming }
BigramTableCreator >> processedTokens [
	| tokens |
	tokens := TokenProcessing replaceWithPlaceholders.
	^ tokens
]

{ #category : #transforming }
BigramTableCreator >> writeToFile [
	| model |
	model := self model.
	model saveToDirectory: TokenProcessing dataFolder
]
