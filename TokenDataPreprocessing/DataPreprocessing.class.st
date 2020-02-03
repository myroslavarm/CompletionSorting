"
class for cleaning the source code token data & getting token frequencies
"
Class {
	#name : #DataPreprocessing,
	#superclass : #Object,
	#category : #TokenDataPreprocessing
}

{ #category : #utilities }
DataPreprocessing >> dataFolder [
	^ 'D:/INRIA/data' asFileReference.
]

{ #category : #utilities }
DataPreprocessing >> emptyStringPlaceholder [
	^ '<empty>'
]

{ #category : #utilities }
DataPreprocessing >> frequenciesFile [
	^ self dataFolder / 'frequencies.csv'
]

{ #category : #processing }
DataPreprocessing >> insertEmptyStringAndCommenPlaceholder: tokensDataFrame [
	tokensDataFrame toColumn: 'tokens' applyElementwise: [ :each |
		each
			copyReplaceAll: (String tab, String tab)
			with: (String tab, self emptyStringPlaceholder, String tab) ]
]

{ #category : #utilities }
DataPreprocessing >> readFile [
	^ DataFrame readFromCsv: self tokensFile
]

{ #category : #processing }
DataPreprocessing >> rejectInvalidTokens: tokensDataFrame [
	^ tokensDataFrame reject: [ :row |
		(row at: 'tokens') size ~= (row at: 'tokenTypes') size ]
]

{ #category : #processing }
DataPreprocessing >> returnProcessedData [
	| tokensDataFrame |
	tokensDataFrame := self readFile.
	self insertEmptyStringAndCommenPlaceholder: tokensDataFrame.
	self splitTokensAndTokenTypes: tokensDataFrame.
	^ self rejectInvalidTokens: tokensDataFrame
]

{ #category : #processing }
DataPreprocessing >> splitTokensAndTokenTypes: tokensDataFrame [
	tokensDataFrame toColumn: 'tokens' applyElementwise: [ :each |
		each substrings: self tokenSeparators  ].
	
	tokensDataFrame toColumn: 'tokenTypes' applyElementwise: [ :each |
		each substrings: self tokenTypeSeparators ].
]

{ #category : #transforming }
DataPreprocessing >> tokenFrequencies [
	| tokens cleanedTokens counts |
	counts := OrderedCollection new.
	cleanedTokens := self returnProcessedData.
	tokens := (cleanedTokens column: 'tokens') asArray.
	(tokens flatCollect: #yourself) asBag valuesAndCounts keysAndValuesDo: [ :key :value | counts add: { key . value }  ].
	^ counts
]

{ #category : #separator }
DataPreprocessing >> tokenSeparators [
	^ { Character tab }
]

{ #category : #separator }
DataPreprocessing >> tokenTypeSeparators [
	^ { Character space }
]

{ #category : #utilities }
DataPreprocessing >> tokensFile [
	^ self dataFolder / 'tokens.csv'
]

{ #category : #processing }
DataPreprocessing >> writeFile [
	| data stream |
	data := self tokenFrequencies.
	stream := self frequenciesFile writeStream.
	(NeoCSVWriter on: stream)
                nextPut: #(key value);
					nextPutAll: data.
	stream close
]
