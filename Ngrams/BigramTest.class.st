Class {
	#name : #BigramTest,
	#superclass : #TestCase,
	#instVars : [
		'handler',
		'dataForWord',
		'dataForPhrase'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
BigramTest >> setUp [
	super setUp.
	dataForWord := Dictionary newFrom: {'Object' -> 7. 'new' -> 3. 'hello' -> 2. 'initialize' -> 4}.
	dataForPhrase := Dictionary newFrom: {'Object new' -> 7. 'Object newSubclass' -> 3. 'Object hello' -> 0. 'Object instSpec' -> 1}.
	handler := Bigram new

]

{ #category : #running }
BigramTest >> testingGettingPhraseFrequency [
	| phrase actual expected |
	phrase := 'Object new'.
	expected := 7.
	actual := handler getFrequencyOf: phrase from: dataForPhrase.
	self assert: actual equals: expected
]

{ #category : #running }
BigramTest >> testingGettingPhraseFrequencyIfPhraseNotInTable [
	| phrase actual expected |
	phrase := 'Object badoom'.
	expected := 0.
	actual := handler getFrequencyOf: phrase from: dataForPhrase.
	self assert: actual equals: expected
]

{ #category : #running }
BigramTest >> testingGettingWordFrequency [
	| word actual expected |
	word := 'hello'.
	expected := 2.
	actual := handler getFrequencyOf: word from: dataForWord.
	self assert: actual equals: expected
]

{ #category : #running }
BigramTest >> testingGettingWordFrequencyIfWordNotInTable [
	| word actual expected |
	word := 'goodbye'.
	expected := 0.
	actual := handler getFrequencyOf: word from: dataForWord.
	self assert: actual equals: expected
]
