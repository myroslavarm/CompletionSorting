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
CompletionEvaluation >> averageSuccessRatio [
	| sumS sumA |
	sumS := 0.
	sumA := 0.
	countSuccess do: [ :each | sumS := sumS + each ].
	countAll do: [ :each | sumA := sumA + each ].
	^ (sumS / sumA) asFloat
]

{ #category : #utilities }
CompletionEvaluation >> calculateCompletionEvaluation [
	| sentences completions tokens methods results |
	tokens := self tokensFromClass: FrequencyCompletionSorter.
	results := OrderedCollection new.
	^ tokens collect: [ :method |
		methods := self getCompletionSequences: method from: 2 to: 8.
		countAll add: methods size.
		sentences := methods collect: [ :each | each first ].
		completions := methods collect: [ :each | each second ].
		results := (self matchCorrectCompletions: completions from: sentences).
		countSuccess add: results size.
		results ]
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
	^ { self calculateCompletionEvaluation . self averageSuccessRatio }
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
CompletionEvaluation >> initialize [
	countAll := OrderedCollection new.
	countSuccess := OrderedCollection new.
]

{ #category : #utilities }
CompletionEvaluation >> matchCorrectCompletions: aCompletionList from: aSentenceList [
	"for each valid part of the method record whether the correct completion was found.
	and if so, additionally record its position"
	| results props |
	results := OrderedCollection new.
	aSentenceList withIndexDo: [ :text :i |
		props := self createCompletionsGiven: text.
		props size >= 10
			ifTrue: [
				((props first: 10) includes: (aCompletionList at: i)) ifTrue: [
					results add: { text.
						text substrings last size.
						aCompletionList at: i.
						props indexOf: (aCompletionList at: i) } ] ]
			ifFalse: [
				(props includes: (aCompletionList at: i)) ifTrue: [ 
					results add: { text.
						text substrings last size.
						aCompletionList at: i.
						props indexOf: (aCompletionList at: i) } ] ] ].
	^ results
]

{ #category : #utilities }
CompletionEvaluation >> tokensFromClass: aClass [
	| allMethods tokens |
	allMethods := aClass methods collect: [ :each | each ast ].
	tokens := allMethods collect: [ :each | RBScanner scanTokens: each sourceCode ].
	^ tokens
]
