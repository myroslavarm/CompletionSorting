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
	^ (MyProjectBridge root / 'data') asFileReference
]

{ #category : #utilities }
TokenProcessing class >> emptyStringPlaceholder [
	^ '<empty>'
]

{ #category : #utilities }
TokenProcessing class >> frequenciesFile [

	^ self dataFolder / 'frequencies.csv'
]

{ #category : #processing }
TokenProcessing class >> insertEmptyStringAndCommentPlaceholder: tokensDataFrame [
	"clean token data by eliminating double tabs"
	tokensDataFrame toColumn: 'tokens' applyElementwise: [ :each |
		each
			copyReplaceAll: (String tab, String tab)
			with: (String tab, self emptyStringPlaceholder, String tab) ]
]

{ #category : #utilities }
TokenProcessing class >> readFile [
	^ DataFrame readFromCsv: self tokensFile
]

{ #category : #processing }
TokenProcessing class >> rejectInvalidTokens: tokensDataFrame [
	"clean token data by dealing with token/tokenType mismatch"
	^ tokensDataFrame reject: [ :row |
		(row at: 'tokens') size ~= (row at: 'tokenTypes') size ]
]

{ #category : #processing }
TokenProcessing class >> replaceWithPlaceholders [
	"return a cleaned token dataset"
	| data tokens tokenTypes arr |
	data := self returnProcessedData.
	tokens := (data column: 'tokens') asArray.
	tokenTypes := (data column: 'tokenTypes') asArray.
	arr := {'ARR'. 'STR'. 'SYM'. 'CHR'. 'NUM'.'COM'}.
	1 to: tokenTypes size do: [ :i |
		1 to: (tokenTypes at: i) size do: [ :j |
			(arr includes: ((tokenTypes at: i) at: j)) ifTrue: [
				(tokens at: i) at: j put:
					(self selectPlaceholderFrom: ((tokenTypes at: i) at: j)) ] ] ].
	^ tokens
]

{ #category : #processing }
TokenProcessing class >> returnProcessedData [
	"return a cleaned token dataset"
	| tokensDataFrame |
	tokensDataFrame := self readFile.
	self insertEmptyStringAndCommentPlaceholder: tokensDataFrame.
	self splitTokensAndTokenTypes: tokensDataFrame.
	^ self rejectInvalidTokens: tokensDataFrame
]

{ #category : #processing }
TokenProcessing class >> selectPlaceholderFrom: aTag [
	aTag = 'ARR' ifTrue: [ ^ '<arr>' ].
	aTag = 'STR' ifTrue: [ ^ '<str>' ].
	aTag = 'SYM' ifTrue: [ ^ '<sym>' ].
	aTag = 'CHR' ifTrue: [ ^ '<chr>' ].
	aTag = 'NUM' ifTrue: [ ^ '<num>' ].
	aTag = 'COM' ifTrue: [ ^ '<com>' ].
]

{ #category : #processing }
TokenProcessing class >> splitTokensAndTokenTypes: tokensDataFrame [
	tokensDataFrame toColumn: 'tokens' applyElementwise: [ :each |
		each substrings: self tokenSeparators  ].
	
	tokensDataFrame toColumn: 'tokenTypes' applyElementwise: [ :each |
		each substrings: self tokenTypeSeparators ].
]

{ #category : #separator }
TokenProcessing class >> tokenSeparators [
	^ { Character tab }
]

{ #category : #separator }
TokenProcessing class >> tokenTypeSeparators [
	^ { Character space }
]

{ #category : #utilities }
TokenProcessing class >> tokensFile [
	^ self dataFolder / 'tokens.csv'
]
