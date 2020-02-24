Class {
	#name : #BigramDataTest,
	#superclass : #TestCase,
	#instVars : [
		'data',
		'handler'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
BigramDataTest >> setUp [
	super setUp.
	data := Dictionary newFrom: {'Object' -> 7. 'new' -> 3. 'hello' -> 2. 'initialize' -> 4}.
	handler := BigramData new

]

{ #category : #running }
BigramDataTest >> testingGettingWordFrequency [
	| word actual expected |
	word := 'hello'.
	expected := 2.
	actual := handler getFrequencyOf: word from: data.
	self assert: actual equals: expected
]

{ #category : #running }
BigramDataTest >> testingGettingWordFrequencyIfWordNotInTable [
	| word actual expected |
	word := 'goodbye'.
	expected := 0.
	actual := handler getFrequencyOf: word from: data.
	self assert: actual equals: expected
]
