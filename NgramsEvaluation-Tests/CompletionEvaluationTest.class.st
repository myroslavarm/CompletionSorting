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
CompletionEvaluationTest >> testMatchingCorrectCompletions [
	| results |
	results := evaluator recordResults.
	self assert: results second first equals: true
]
