Class {
	#name : #CompletionEvaluation,
	#superclass : #Object,
	#category : #NgramsEvaluation
}

{ #category : #utilities }
CompletionEvaluation >> createCompletionsGiven: aText [
	| context |
	context := self createContextFor: aText at: aText size.
	^ context entries collect: #contents
]

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
	| sentences props results completions |
	sentences := self getPartsOfMethods.
	completions := self getCorrectCompletions.
	results := OrderedCollection new.
	sentences withIndexDo: [ :text :i |
		props := self createCompletionsGiven: text.
		(props includes: (completions at: i)) ifTrue: [
			results add: true ] ifFalse: [ results add: false ] ].
	^ results
]
