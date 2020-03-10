Class {
	#name : #ExperimentalNgramTest,
	#superclass : #TestCase,
	#instVars : [
		'data',
		'ngrams',
		'model'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
ExperimentalNgramTest >> setUp [
	super setUp.
	data := BigramExperimental new bigrams.
	ngrams := data associations collect: [ :each |
		ExperimentalNgram words: each key substrings frequency: each value ].
	model := Bigram new readFile

]

{ #category : #tests }
ExperimentalNgramTest >> testNgramLibraryModel [
	| expected actual word |
	word := 'self'.
	actual := model mostLikelyContinuations: word asNgram top: 10.
	expected := #('assert:' 'assert:equals:' '.' 'new' 'class' 'deny:' 'subclassResponsibility' 'repository' 'model' 'error:').
	self assert: actual equals: expected
]

{ #category : #tests }
ExperimentalNgramTest >> testSelectionByFirstWord [
	| continuations result expected actual |
	continuations := ngrams select: [ :each | each words first = 'self' ].
	continuations sort: [ :a :b | a frequency > b frequency ].
	result := continuations collect: [ :each | each asString ].
	expected := 'self assert: 19966'.
	actual := result first.
	self assert: actual equals: expected
]

{ #category : #tests }
ExperimentalNgramTest >> testSelectionByPrefixInSecondWord [
	| assoc selection |
	assoc := data associations collect: [ :each | each key substrings -> each value ].
	selection := assoc select: [ :each | (each key first = 'super') and:
		(each key second beginsWith: 'ini')].
	self assert: selection size equals: 1
]
