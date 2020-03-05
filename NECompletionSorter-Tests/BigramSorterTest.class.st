Class {
	#name : #BigramSorterTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter',
		'history',
		'collection',
		'frequency',
		'bigramFrequency'
	],
	#category : #'NECompletionSorter-Tests'
}

{ #category : #running }
BigramSorterTest >> setUp [
	super setUp.
	sorter := BigramSorter new.
	
	history := 'apple'.
	collection := { 'pie' . 'strudel' . 'house' . 'juice' . 'dream' }.
	frequency := { 'apple'->8 . 'hello'->10 . 'never'->5 } asDictionary.
	bigramFrequency := { 'apple pie'->3 . 'apple strudel'->4 . 'apple juice'->3} asDictionary.
	
]

{ #category : #tests }
BigramSorterTest >> testSort [
	| actual expected |
	sorter getHistory: history andCollection: collection.
	sorter probabilities: (sorter getProbabilitiesFromUnigrams: frequency andBigrams: bigramFrequency).
	actual := sorter sort: collection.
	expected := #(strudel juice pie dream house).
	self assert: actual equals: expected
]
