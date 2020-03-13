Class {
	#name : #BigramSorterTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter',
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
	| history collection probabilities actual expected |
	history := 'OrderedCollection'.
	collection := { 'new' . 'hello' . 'new:' . 'newFrom:' . 'needsSlotClassDefinition'}.
	probabilities := sorter probabilitiesFromModel: model history: history andCollection: collection.
	sorter probabilities: probabilities.
	actual := sorter sort: collection.
	expected := #(new new: needsSlotClassDefinition newFrom: hello).
	self assert: actual equals: expected
]
