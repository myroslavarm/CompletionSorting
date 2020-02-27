Class {
	#name : #NgramTest,
	#superclass : #TestCase,
	#instVars : [
		'data',
		'ngrams'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
NgramTest >> setUp [
	super setUp.
	data := BigramData new bigrams.
	ngrams := data associations collect: [ :each |
		Ngram words: each key substrings frequency: each value ]

]

{ #category : #tests }
NgramTest >> testSelectionByFirstWord [
	| continuations result expected actual |
	continuations := ngrams select: [ :each | each words first = 'self' ].
	continuations sort: [ :a :b | a frequency > b frequency ].
	result := continuations collect: [ :each | each asString ].
	expected := 'self assert: 19966'.
	actual := result first.
	self assert: actual equals: expected
]

{ #category : #tests }
NgramTest >> testSelectionByPrefixInSecondWord [
	| assoc selection |
	assoc := data associations collect: [ :each | each key substrings -> each value ].
	selection := assoc select: [ :each | (each key first = 'super') and:
		(each key second beginsWith: 'ini')].
	self assert: selection size equals: 1
]
