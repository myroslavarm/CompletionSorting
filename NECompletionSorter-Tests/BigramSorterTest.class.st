Class {
	#name : #BigramSorterTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter',
		'frequency',
		'bigramFrequency'
	],
	#category : #'NECompletionSorter-Tests'
}

{ #category : #running }
BigramSorterTest >> setUp [
	super setUp.
	sorter := ExperimentalBigramSorter new.

	frequency := { 'apple'->8 . 'hello'->10 . 'never'->5 } asDictionary.
	bigramFrequency := { 'apple pie'->3 . 'apple strudel'->4 . 'apple juice'->3} asDictionary.
	
]

{ #category : #tests }
BigramSorterTest >> testSort [
	| history collection actual expected |
	history := 'apple'.
	collection := { 'pie' . 'strudel' . 'house' . 'juice' . 'dream' }.
	
	sorter getHistory: history andCollection: collection.
	sorter probabilities: (sorter getProbabilitiesFromUnigrams: frequency andBigrams: bigramFrequency).
	actual := sorter sort: collection.
	expected := #(strudel juice pie dream house).
	self assert: actual equals: expected
]

{ #category : #tests }
BigramSorterTest >> testSortIfHistoryWordNotInTable [
	"all probabilities are 0 because the history word does not exist"
	| history collection actual expected |
	history := 'possible'.
	collection := { 'pie' . 'strudel' . 'house' . 'juice' . 'dream' }.
	
	sorter getHistory: history andCollection: collection.
	sorter probabilities: (sorter getProbabilitiesFromUnigrams: frequency andBigrams: bigramFrequency).
	actual := sorter sort: collection.
	expected := #(dream juice house strudel pie).
	self assert: actual equals: expected
]
