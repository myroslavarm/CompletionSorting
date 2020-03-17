"
With the help of NgramModel, I create and write to file an ngram model, which will be used by the Bigram class
"
Class {
	#name : #BigramTableCreator,
	#superclass : #Object,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #transforming }
BigramTableCreator >> bigramFile [

	^ 'ngram_model.json'
]

{ #category : #transforming }
BigramTableCreator >> model [
	| model |
	model := NgramModel order: 2.
	model trainOn: self processedTokens.
	model removeNgramsWithCountsLessThan: 50.
	^ model
]

{ #category : #transforming }
BigramTableCreator >> processedTokens [
	^ TokenProcessing replaceWithPlaceholders
]

{ #category : #transforming }
BigramTableCreator >> writeToFile [
	self model saveToFile: TokenProcessing dataFolder / self bigramFile
]
