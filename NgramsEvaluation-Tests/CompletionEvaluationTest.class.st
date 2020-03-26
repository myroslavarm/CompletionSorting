Class {
	#name : #CompletionEvaluationTest,
	#superclass : #TestCase,
	#instVars : [
		'evaluator'
	],
	#category : #'NgramsEvaluation-Tests'
}

{ #category : #running }
CompletionEvaluationTest >> setUp [
	super setUp.
	evaluator := CompletionEvaluation new.
]

{ #category : #tests }
CompletionEvaluationTest >> testGetCompletionSequences [
	| tokens sentences methods |
	self skip.
	tokens := evaluator tokensFromClass: Collection.
	methods := evaluator getCompletionSequences: tokens from: 3 to: 3.
	sentences := methods collect: [ :each | each first ].
	self assert: sentences third asString equals: 'includes: anObject ^ sel'
]

{ #category : #tests }
CompletionEvaluationTest >> testGetCorrectCompletions [
	| tokens methods completions |
	self skip.
	tokens := evaluator tokensFromClass: Collection.
	methods := evaluator getCompletionSequences: tokens from: 3 to: 3.
	completions := methods collect: [ :each | each second ].
	self assert: completions second asString equals: 'anObject'
]

{ #category : #tests }
CompletionEvaluationTest >> testMatchingCorrectCompletions [
	| results tokens sentences methods completions |
	tokens := evaluator tokensFromClass: Collection.
	methods := evaluator getCompletionSequences: tokens from: 3 to: 3.
	sentences := methods collect: [ :each | each first ].
	completions := methods collect: [ :each | each second ].
	results := evaluator matchCorrectCompletions: completions from: sentences.
	self assert: results second first equals: true
]
