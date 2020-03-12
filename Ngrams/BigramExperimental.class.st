"
keep this before fixing the NgramModel library
"
Class {
	#name : #BigramExperimental,
	#superclass : #Object,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #utilities }
BigramExperimental >> bigramFrequencies [
	"get processed tokens, count frequencies for each pair, return as dictionary"
	| tokens counts |
	counts := OrderedCollection new.
	tokens := BigramTableCreator new processedTokens.
	tokens do: [ :each | each overlappingPairsDo: [ :one :two | counts add: { one . two } ] ].
	counts := counts collect: [ :each | each first, ' ', each second ].
	counts := counts asBag valuesAndCounts.
	^ counts reject: [ :each | each value < 10 ]
]

{ #category : #utilities }
BigramExperimental >> bigramFrequenciesFile [

	^ TokenProcessing dataFolder / 'bigrams.json'
]

{ #category : #utilities }
BigramExperimental >> bigrams [
	| bigrams |
	bigrams := self readFile.
	^ bigrams 
]

{ #category : #utilities }
BigramExperimental >> readFile [
	| bigrams |
	bigrams := self bigramFrequenciesFile readStreamDo: [ :readStream |
		STONJSON fromStream: readStream ].
	^ bigrams
]

{ #category : #utilities }
BigramExperimental >> writeBigramFile [
	| data |
	data := self bigramFrequencies.
	self bigramFrequenciesFile writeStreamDo: [ :writeStream |
		STONJSON put: data onStream: writeStream ]
]
