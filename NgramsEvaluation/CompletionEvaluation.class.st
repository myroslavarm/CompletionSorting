"
I am an evaluator for code completion strategies
"
Class {
	#name : #CompletionEvaluation,
	#superclass : #Object,
	#instVars : [
		'countSuccess',
		'countAll'
	],
	#category : #NgramsEvaluation
}

{ #category : #utilities }
CompletionEvaluation >> calculateCompletionEvaluation [
	| sentences completions tokens methods |
	tokens := self tokensFromClass: FrequencyCompletionSorter.
	^ tokens collect: [ :method |
		methods := self getCompletionSequences: method from: 2 to: 8.
		sentences := methods collect: [ :each | each first ].
		completions := methods collect: [ :each | each second ].
		self matchCorrectCompletions: completions from: sentences ]
]

{ #category : #utilities }
CompletionEvaluation >> createCompletionsGiven: aText [
	"get completion candidates based on text"
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
CompletionEvaluation >> evaluateAccuracy [
	| matches |
	matches := self calculateCompletionEvaluation.
	^ { countSuccess/countAll asFloat . matches }
]

{ #category : #utilities }
CompletionEvaluation >> getCompletionSequences: aList from: aStart to: anEnd [
	"generate parts of each method to simulate how the method was developed.
	return only the ones ending with alphabetic tokens, instead of delimiters"
	| history sentences sequences interval |
	history := ''.
	sequences := ''.
	interval :=  Interval from: aStart to: anEnd.
	sentences := OrderedCollection new.
	aList do: [ :each |  
		interval do: [ :number |
			each asString size >= number asNumber ifTrue: [
				sequences := each asString truncateTo: number asNumber. 
				sentences add: { (history, ' ', sequences) allButFirst . each asString } ] ]. 
		history := history asString, ' ', each asString ].
	^ sentences select: [ :each | (each first) last isLetter ]
]

{ #category : #utilities }
CompletionEvaluation >> matchCorrectCompletions: aCompletionList from: aSentenceList [
	"for each valid part of the method record whether the correct completion was found.
	and if so, additionally record its position"
	| results props |
	countSuccess := 0.
	countAll := 0.
	results := aSentenceList withIndexCollect: [ :text :i |
		props := self createCompletionsGiven: text.
		(props includes: (aCompletionList at: i)) 
			ifTrue: [ 
				countSuccess := countSuccess + 1.
				countAll := countAll + 1.
				{ aCompletionList at: i. true . props indexOf: (aCompletionList at: i) } ]
			ifFalse: [ 
				countAll := countAll + 1.
				{ aCompletionList at: i. false . false } ] ].
	^ results
]

{ #category : #utilities }
CompletionEvaluation >> tokensFromClass: aClass [
	| allMethods tokens |
	allMethods := aClass methods collect: [ :each | each ast ].
	tokens := allMethods collect: [ :each | RBScanner scanTokens: each sourceCode ].
	^ tokens
]
