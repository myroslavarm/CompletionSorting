Class {
	#name : #FrequencySorterTest,
	#superclass : #TestCase,
	#instVars : [
		'frequencies',
		'sorter'
	],
	#category : #'NECompletionSorter-Tests'
}

{ #category : #running }
FrequencySorterTest >> setUp [

	frequencies := {
		'apple'->4 .
		'banana'->3 .
		'orange'->42 .
		'mango'->10 .
		'avocado'->13 } asDictionary.

	sorter := FrequencySorter new.
	sorter frequencies: frequencies
]

{ #category : #running }
FrequencySorterTest >> testSort [
	| candidates actual expected |
	candidates := #(apple banana avocado orange).
	actual := sorter sort: candidates.
	expected := #(orange avocado apple banana).
	self assert: actual equals: expected
	
]

{ #category : #running }
FrequencySorterTest >> testSortWithCandidatesEmpty [
	| candidates actual expected |
	candidates := #().
	actual := sorter sort: candidates.
	expected := #().
	self assert: actual equals: expected
	
]

{ #category : #running }
FrequencySorterTest >> testSortWithCandidatesNotInDictionary [
	| candidates actual expected |
	candidates := #(apple dragonfruit banana avocado).
	actual := sorter sort: candidates.
	expected := #(avocado apple banana dragonfruit).
	self assert: actual equals: expected
	
]

{ #category : #running }
FrequencySorterTest >> testSortWithFrequenciesEmpty [
	| candidates actual expected |
	sorter frequencies: Dictionary new.
	candidates := #(apple dragonfruit banana avocado).
	actual := sorter sort: candidates.
	expected := #(apple dragonfruit banana avocado).
	self assert: actual equals: expected
	
]
