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
CompletionEvaluation >> getCorrectCompletionsFrom: aList [
	^ aList reject: [ :each | each asString matchesRegex: '\W' ]
]

{ #category : #utilities }
CompletionEvaluation >> getPartsOfMethodsFrom: aList [
	| history sentences sequences |
	history := ''.
	sequences := ''.
	sentences := aList collect: [ :each | 
		sequences := history asString, ' ', (each asString truncateTo: 3). 
		history := history asString, ' ', each asString.
		sequences allButFirst ].
	^ sentences select: [ :each | each last isLetter ]
]

{ #category : #utilities }
CompletionEvaluation >> matchCorrectCompletions: aCompletionList from: aSentenceList [
	| results props |
	results := aSentenceList withIndexCollect: [ :text :i |
		props := self createCompletionsGiven: text.
		(props includes: (aCompletionList at: i)) 
			ifTrue: [ { true . props indexOf: (aCompletionList at: i) } ]
			ifFalse: [ { false . false } ] ].
	^ results
]

{ #category : #utilities }
CompletionEvaluation >> recordResults [
	| sentences completions tokens |
	tokens := self tokensFromClass: Collection.
	sentences := self getPartsOfMethodsFrom: tokens.
	completions := self getCorrectCompletionsFrom: tokens.
	^ self matchCorrectCompletions: completions from: sentences 
]

{ #category : #utilities }
CompletionEvaluation >> tokensFromClass: aClass [
	| method |
	method := (aClass methods collect: [ :each | each ast ]) second.
	^ RBScanner scanTokens: method sourceCode
]
