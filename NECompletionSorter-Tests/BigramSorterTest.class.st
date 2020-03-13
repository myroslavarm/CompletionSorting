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
BigramSorterTest >> testSortOfAST [
	| history collection probabilities ast actual expected position node completionToken source |
	source := 'method1 | arr | arr := Array new . se'.
	position := source size.
	ast := UndefinedObject compiler
		source: source;
		parse.
	ast doSemanticAnalysis.
	TypingVisitor new visitNode: ast.
	node := ast nodeForOffset: position.
	completionToken := node completionToken: position.
	history := source wordBefore: position  - completionToken size - 1.
	collection := { 'new' . 'Object' . '<num>' . 'self' . '<str>' }.
	probabilities := sorter probabilitiesFromModel: model history: history andCollection: collection.
	sorter probabilities: probabilities.
	actual := sorter sort: collection.
	"so due to the way we get the history word, punctuation is not counted but it seems
	that at least for this case the order is not too bad"
	expected := #(self '<str>' '<num>' Object new).
	self assert: actual equals: expected
]

{ #category : #tests }
BigramSorterTest >> testSortOfPunctuationAsHistory [
	| history collection probabilities actual expected |
	history := '.'.
	collection := { 'new' . 'Object' . '<num>' . 'self' . '<str>' }.
	probabilities := sorter probabilitiesFromModel: model history: history andCollection: collection.
	sorter probabilities: probabilities.
	actual := sorter sort: collection.
	"i think it makes sense that at the start of a new statement something like self
	would be more probable than something like new"
	expected := #(self  '<num>' '<str>' new Object).
	self assert: actual equals: expected
]

{ #category : #tests }
BigramSorterTest >> testSortWithRegularData [
	| history collection probabilities actual expected |
	history := 'OrderedCollection'.
	collection := { 'new' . 'hello' . 'new:' . 'newFrom:' . 'needsSlotClassDefinition'}.
	probabilities := sorter probabilitiesFromModel: model history: history andCollection: collection.
	sorter probabilities: probabilities.
	actual := sorter sort: collection.
	expected := #(new new: needsSlotClassDefinition newFrom: hello).
	self assert: actual equals: expected
]
