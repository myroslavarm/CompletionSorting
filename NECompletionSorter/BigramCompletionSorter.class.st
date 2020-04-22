"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'model',
		'bigram'
	],
	#category : #NECompletionSorter
}

{ #category : #accessing }
BigramCompletionSorter >> getWordBefore [
	| history |
	(RBScanner scanTokens: context source) size > 1 ifTrue: [ 
		history := ((RBScanner scanTokens: context source asString) allButLast: 1) last ]
		ifFalse: [ history := (RBScanner scanTokens: context source) last ].
	(history asString size > 1 and: ((history asString at: 1) tokenish)) ifFalse: [ ^ '' ].
	"history := context source wordBefore: context position  - context completionToken size - 1."
	history := RBParser parseExpression: history asString.
	history value isNumber ifTrue: [ ^ '<num>' ].
	history value isSymbol ifTrue: [ ^ '<sym>' ].
	history value isString ifTrue: [ ^ '<str>' ].
	history value isCharacter ifTrue: [ ^ '<chr>' ].
	^ history value asString
]

{ #category : #sorting }
BigramCompletionSorter >> initialize [

	sorter := BigramSorter new.
	bigram := Bigram new.
	model := bigram readFile
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [
	| probabilities |
	probabilities := bigram probabilitiesFromModel: model
					history: self getWordBefore
					andCollection: anOrderedCollection. 
	sorter probabilities: probabilities.
	^ sorter sort: anOrderedCollection
]
