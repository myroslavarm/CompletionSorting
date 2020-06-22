Class {
	#name : #BigramSortingContextTest,
	#superclass : #CompletionContextTest,
	#category : #'NECompletionSorter-Tests'
}

{ #category : #private }
BigramSortingContextTest >> createContextFor: aString at: anInteger [ 
	^ CompletionContext
		engine: CompletionEngine new
		class: NECTestClass
		source: aString
		position: anInteger
		sorter: BigramCompletionSorter new
]

{ #category : #tests }
BigramSortingContextTest >> testExpressionInIncompleteParanthesis [
	| text context props |
	text := 'testIt
	1 + (1 si'.
	context := self 
		createContextFor: text
		at: text size.

	props := context entries collect: #contents.	
		
	self assert: props isNotEmpty equals: true
]

{ #category : #tests }
BigramSortingContextTest >> testOrderOfMessageSend [
	| text context completions |
	self skip: 'something wrong'.
	text := 'testIt
		collection := OrderedCollection ne'.
	context := self 
		createContextFor: text
		at: text size.
	completions := context entries collect: #contents.
	self assert: ((completions first: 3) includes: #new).
	self assert: ((completions first: 3) includes: #new:)
]
