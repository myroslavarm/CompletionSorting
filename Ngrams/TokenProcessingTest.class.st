Class {
	#name : #TokenProcessingTest,
	#superclass : #TestCase,
	#instVars : [
		'data',
		'preprocessor'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
TokenProcessingTest >> setUp [
	| tokens tokenTypes |
	
	tokens := #(
		'self	new	initialize:	3	.'
		'"comment"	self	new	initialize:	3	.'). 
	
	tokenTypes := #(
		'SLF MSG MSG NUM DOT'
		'COM SLF MSG MSG NUM DOT').
							
	data := DataFrame
		withColumns: { tokens . tokenTypes }
		columnNames: #(tokens tokenTypes).
		
	preprocessor := TokenProcessing new.
]

{ #category : #tests }
TokenProcessingTest >> testSplitTokensAndTokenTypes [
	| expectedTokens expectedTokenTypes expected |
	
	expectedTokens := #(
		(self new initialize: '3' .)
		('"comment"' self new initialize: '3' .)). 
	
	expectedTokenTypes := #(
		(SLF MSG MSG NUM DOT)
		(COM SLF MSG MSG NUM DOT)).
		
	expected := DataFrame
		withColumns: { expectedTokens . expectedTokenTypes }
		columnNames: #(tokens tokenTypes).
		
	preprocessor splitTokensAndTokenTypes: data.
	self assert: data equals: expected.
]
