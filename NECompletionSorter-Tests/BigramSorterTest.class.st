Class {
	#name : #BigramSorterTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter',
		'frequency',
		'bigramFrequency',
		'model'
	],
	#category : #'NECompletionSorter-Tests'
}

{ #category : #running }
BigramSorterTest >> setUp [
	super setUp.
	sorter := BigramSorter new.
	model := Bigram new readFile.
	
]

{ #category : #tests }
BigramSorterTest >> testSort [
	| history collection actual expected ngrams probabilities |
	history := 'OrderedCollection'.
	collection := { 'new' . 'hello' . 'new:' . 'newFrom:' . 'needsSlotClassDefinition'}.
	ngrams := sorter getHistory: history andCollection: collection.
	probabilities := sorter probabilitiesFromModel: model withNgrams: ngrams.
	sorter probabilities: probabilities.
	actual := sorter sort: collection.
	expected := #(new new: needsSlotClassDefinition newFrom: hello).
	self assert: actual equals: expected
]
