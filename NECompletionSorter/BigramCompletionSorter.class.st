"
I am class who sorts completion results based on a bigram model
"
Class {
	#name : #BigramCompletionSorter,
	#superclass : #CompletionSorter,
	#instVars : [
		'sorter',
		'model'
	],
	#category : #NECompletionSorter
}

{ #category : #accessing }
BigramCompletionSorter >> getWordBefore [
	| history visitor tokens |
	visitor := TokensCollectingVisitor new.
	tokens := (visitor visitNode: context ast) tokens.
	tokens isEmpty ifTrue: [ ^ '' ].
	history := tokens size > 1
		ifTrue: [ (tokens allButLast: 1) last ]
		ifFalse: [ tokens last ].
	^ history
]

{ #category : #sorting }
BigramCompletionSorter >> initialize [

	sorter := BigramSorter new.
	model := self model
]

{ #category : #accessing }
BigramCompletionSorter >> model [

	^ NgramModel readFromFile: (TokenProcessing dataFolder / BigramTableCreator new bigramFile)
]

{ #category : #accessing }
BigramCompletionSorter >> probabilitiesFromModel: aModel history: aHistory andCollection: anOrderedCollection [
	| collection ngrams probabilities |
	collection := anOrderedCollection collect: [ :each | each contents asString ].
	ngrams := aHistory = ''
		ifTrue: [ collection collect: [ :each |
				(Character space join: { '<s>' . each }) ] ]
		ifFalse: [ collection collect: [ :each |
				(Character space join: { aHistory . each }) ] ].
	probabilities := ngrams collect: [ :each | (each substrings second) ->
		(aModel probabilityOfNgram: (each substrings asArray asNgram)) ].
	^ probabilities asDictionary
]

{ #category : #sorting }
BigramCompletionSorter >> sortCompletionList: anOrderedCollection [
	| probabilities |
	probabilities := self probabilitiesFromModel: model
					history: self getWordBefore
					andCollection: anOrderedCollection. 
	sorter probabilities: probabilities.
	^ sorter sort: anOrderedCollection
]
