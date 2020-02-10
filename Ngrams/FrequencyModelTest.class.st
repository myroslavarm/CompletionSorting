Class {
	#name : #FrequencyModelTest,
	#superclass : #TestCase,
	#instVars : [
		'frequency'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
FrequencyModelTest >> setUp [ 

	frequency := FrequencyModel new
]

{ #category : #running }
FrequencyModelTest >> testCorrectSorting [
	| sorted |
	sorted := frequency sortResults.
	self assert: (sorted first at: 'value') > (sorted second at: 'value') equals: true
]
