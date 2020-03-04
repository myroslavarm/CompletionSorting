Class {
	#name : #BigramSorterTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter',
		'handler',
		'probabilities'
	],
	#category : #'NECompletionSorter-Tests'
}

{ #category : #running }
BigramSorterTest >> setUp [
	super setUp.
	sorter := BigramSorter new.
	handler := BigramData new.
	probabilities := Dictionary new.
	
]

{ #category : #tests }
BigramSorterTest >> testSort [
	| actual expected ngrams historyMapping ngramMapping history collection frequency bigramFrequency |
	history := 'apple'.
	collection := { 'pie' . 'strudel' . 'house' . 'juice' . 'dream' }.
	frequency := { 'apple'->8 . 'hello'->10 . 'never'->5 } asDictionary.
	bigramFrequency := { 'apple pie'->3 . 'apple strudel'->4 . 'apple juice'->3} asDictionary.
	ngrams := sorter getHistory: history andCollection: collection.
	
	historyMapping := {history . handler getFrequencyOf: history from: frequency}.
	ngramMapping := ngrams collect: [ :each |
		{each . (handler getFrequencyOf: each from: bigramFrequency )} ].
	ngramMapping do: [ :each | (probabilities add: (each first substrings) second -> (each second asNumber / historyMapping second asNumber) asFloat) ].

	sorter probabilities: probabilities.
	actual := sorter sort: collection.
	expected := #(strudel juice pie dream house).
	self assert: actual equals: expected
]
