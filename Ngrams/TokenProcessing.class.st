"
class for cleaning the source code token data & getting token frequencies
"
Class {
	#name : #TokenProcessing,
	#superclass : #Object,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #utilities }
TokenProcessing class >> dataFolder [
	^ 'pharo-local/iceberg/myroslavarm/CompletionSorting/data' asFileReference
]

{ #category : #transforming }
TokenProcessing >> bigramFrequencies [
	"get processed tokens, count frequencies for each pair, return as dictionary"
	| tokens cleanedTokens counts |
	counts := OrderedCollection new.
	cleanedTokens := self returnProcessedData.
	tokens := (cleanedTokens column: 'tokens') asArray.
	tokens do: [ :each | each overlappingPairsDo: [ :one :two | counts add: { one . two } ] ].
	counts := counts collect: [ :each | each first, ' ', each second ].
	^ counts asBag valuesAndCounts
]

{ #category : #utilities }
TokenProcessing >> bigramFrequenciesFile [
	^ self class dataFolder / 'bigrams.json'
]

{ #category : #separator }
TokenProcessing >> bigramFrequenciesShortened [
	"get rid of all the pairs of tokens whose frequency is less than 50"
	| counts |
	counts := self bigramFrequencies.
	counts := counts reject: [ :each | each value < 50 ].
	^ counts
]

{ #category : #utilities }
TokenProcessing >> emptyStringPlaceholder [
	^ '<empty>'
]

{ #category : #utilities }
TokenProcessing >> frequenciesFile [
	^ self class dataFolder / 'frequencies.csv'
]

{ #category : #processing }
TokenProcessing >> insertEmptyStringAndCommentPlaceholder: tokensDataFrame [
	"clean token data by eliminating double tabs"
	tokensDataFrame toColumn: 'tokens' applyElementwise: [ :each |
		each
			copyReplaceAll: (String tab, String tab)
			with: (String tab, self emptyStringPlaceholder, String tab) ]
]

{ #category : #processing }
TokenProcessing >> insertNumberPlaceholder: tokensDataFrame [
	"clean token data by replacing each number with a <num> placeholder"
	^ tokensDataFrame toColumn: 'tokens' applyElementwise: 
		[ :each | each copyWithRegex: '(\+|-)?\d+(\.\d*)?((e|E)(\+|-)?\d+)?'
			matchesReplacedWith: self numberPlaceholder]
]

{ #category : #utilities }
TokenProcessing >> numberPlaceholder [
	^ '<num>'
]

{ #category : #utilities }
TokenProcessing >> readFile [
	^ DataFrame readFromCsv: self tokensFile
]

{ #category : #processing }
TokenProcessing >> rejectInvalidTokens: tokensDataFrame [
	"clean token data by dealing with token/tokenType mismatch"
	^ tokensDataFrame reject: [ :row |
		(row at: 'tokens') size ~= (row at: 'tokenTypes') size ]
]

{ #category : #processing }
TokenProcessing >> returnProcessedData [
	"return a cleaned token dataset"
	| tokensDataFrame |
	tokensDataFrame := self readFile.
	self insertEmptyStringAndCommentPlaceholder: tokensDataFrame.
	tokensDataFrame := self insertNumberPlaceholder: tokensDataFrame.
	self splitTokensAndTokenTypes: tokensDataFrame.
	^ self rejectInvalidTokens: tokensDataFrame
]

{ #category : #processing }
TokenProcessing >> splitTokensAndTokenTypes: tokensDataFrame [
	tokensDataFrame toColumn: 'tokens' applyElementwise: [ :each |
		each substrings: self tokenSeparators  ].
	
	tokensDataFrame toColumn: 'tokenTypes' applyElementwise: [ :each |
		each substrings: self tokenTypeSeparators ].
]

{ #category : #transforming }
TokenProcessing >> tokenFrequencies [
	"get single token frequencies"
	| tokens cleanedTokens counts |
	counts := OrderedCollection new.
	cleanedTokens := self returnProcessedData.
	tokens := (cleanedTokens column: 'tokens') asArray.
	(tokens flatCollect: #yourself) asBag valuesAndCounts keysAndValuesDo: [ :key :value | counts add: { key . value }  ].
	^ counts
]

{ #category : #separator }
TokenProcessing >> tokenFrequenciesShortened [
	"get rid of all single tokens with frequency less than 10"
	| counts |
	counts := self tokenFrequencies .
	counts := counts reject: [ :each | each second < 10 ].
	^ counts
]

{ #category : #separator }
TokenProcessing >> tokenSeparators [
	^ { Character tab }
]

{ #category : #separator }
TokenProcessing >> tokenTypeSeparators [
	^ { Character space }
]

{ #category : #utilities }
TokenProcessing >> tokensFile [
	^ self class dataFolder / 'tokens.csv'
]

{ #category : #processing }
TokenProcessing >> writeBigramFile [
	| data |
	data := self bigramFrequenciesShortened.
	self bigramFrequenciesFile writeStreamDo: [ :writeStream |
		STONJSON put: data onStream: writeStream ]
]

{ #category : #processing }
TokenProcessing >> writeFile [
	| data stream |
	data := self tokenFrequenciesShortened.
	stream := self frequenciesFile writeStream.
	(NeoCSVWriter on: stream)
                nextPut: #(key value);
					nextPutAll: data.
	stream close
]
