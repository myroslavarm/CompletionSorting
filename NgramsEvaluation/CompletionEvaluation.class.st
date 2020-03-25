Class {
	#name : #CompletionEvaluation,
	#superclass : #Object,
	#category : #NgramsEvaluation
}

{ #category : #private }
CompletionEvaluation >> createContextFor: aString at: anInteger [ 
	^ CompletionContext
		engine: CompletionEngine new
		class: NECTestClass
		source: aString
		position: anInteger
		sorter: BigramCompletionSorter new
]

{ #category : #utilities }
CompletionEvaluation >> getCorrectCompletions [
	| tokens |
	tokens := self methodTokens.
	^ tokens reject: [ :each | each asString matchesRegex: '\W' ]
]

{ #category : #utilities }
CompletionEvaluation >> getPartsOfMethods [
	| history tokens sentences sequences |
	tokens := self methodTokens.
	history := ''.
	sequences := ''.
	sentences := tokens collect: [ :each | 
		sequences := history asString, ' ', (each asString truncateTo: 3). 
		history := history asString, ' ', each asString.
		sequences allButFirst ].
	^ sentences select: [ :each | each last isLetter ]
]

{ #category : #utilities }
CompletionEvaluation >> methodTokens [
	| method |
	method := (Collection methods collect: [ :each | each ast ]) second.
	^ RBScanner scanTokens: method sourceCode
]

{ #category : #utilities }
CompletionEvaluation >> recordResults [
	| sentences context props results |
	sentences := self getPartsOfMethods.
	results := OrderedCollection new.
	results := sentences collect: [ :text |
		context := self createContextFor: text at: text size.
		props := context entries collect: #contents. props ].
	^ results
]
