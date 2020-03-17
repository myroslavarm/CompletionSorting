Class {
	#name : #BigramSorterTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter',
		'model',
		'bigram'
	],
	#category : #'NECompletionSorter-Tests'
}

{ #category : #running }
BigramSorterTest >> setUp [
	super setUp.
	sorter := BigramSorter new.
	bigram := Bigram new.
	model := bigram readFile
	
]

{ #category : #tests }
BigramSorterTest >> testSortOfAST [
	| collection probabilities ast actual expected position node completionToken source |
	source := 'method1 | arr | arr := Array new . se'.
	position := source size.
	ast := UndefinedObject compiler
		source: source;
		parse.
	TypingVisitor new visitNode: ast doSemanticAnalysis.
	node := ast nodeForOffset: position.
	completionToken := node completionToken: position.
	
	collection := { 'new' . 'Object' . '<num>' . 'self' . '<str>' }.
	probabilities := bigram probabilitiesFromModel: model 
					history: (source wordBefore: position  - completionToken size - 1)
					andCollection: collection.
	actual := (sorter probabilities: probabilities) sort: collection.
	"so due to the way we get the history word, punctuation is not counted but it seems
	that at least for this case the order is not too bad"
	expected := #(self '<str>' '<num>' Object new).
	self assert: actual equals: expected
]

{ #category : #tests }
BigramSorterTest >> testSortOfPunctuationAsHistory [
	| collection probabilities actual expected |
	collection := { 'new' . 'Object' . '<num>' . 'self' . '<str>' }.
	probabilities := bigram probabilitiesFromModel: model
					history: '.'
					andCollection: collection.
	actual := (sorter probabilities: probabilities) sort: collection.
	"i think it makes sense that at the start of a new statement something like self
	would be more probable than something like new"
	expected := #(self  '<num>' '<str>' new Object).
	self assert: actual equals: expected
]

{ #category : #tests }
BigramSorterTest >> testSortWithRegularData [
	| collection probabilities actual expected |
	collection := { 'new' . 'hello' . 'new:' . 'newFrom:' . 'needsSlotClassDefinition'}.
	probabilities := bigram probabilitiesFromModel: model
					history: 'OrderedCollection'
					andCollection: collection.
	actual := (sorter probabilities: probabilities) sort: collection.
	expected := #(new new: needsSlotClassDefinition newFrom: hello).
	self assert: actual equals: expected
]
