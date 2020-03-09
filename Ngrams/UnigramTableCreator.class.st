"
With the help of TokenProcessing, I create a table of frequencies to write to file, which will be used by the Unigram class
"
Class {
	#name : #UnigramTableCreator,
	#superclass : #Object,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #transforming }
UnigramTableCreator >> frequencies [
	"get single token frequencies"
	| tokens cleanedTokens counts |
	counts := OrderedCollection new.
	cleanedTokens := TokenProcessing returnProcessedData.
	tokens := (cleanedTokens column: 'tokens') asArray.
	(tokens flatCollect: #yourself) asBag valuesAndCounts keysAndValuesDo: [ :key :value | counts add: { key . value }  ].
	^ counts reject: [ :each | each second < 10 ]
]

{ #category : #transforming }
UnigramTableCreator >> writeToFile [
	| data stream |
	data := self frequencies.
	stream := TokenProcessing frequenciesFile writeStream.
	(NeoCSVWriter on: stream)
                nextPut: #(key value);
					nextPutAll: data.
	stream close
]
