Class {
	#name : #BaselineOfCompletionSorting,
	#superclass : #BaselineOf,
	#category : #BaselineOfCompletionSorting
}

{ #category : #baselines }
BaselineOfCompletionSorting >> baselineOf: spec [
	<baseline>

	spec for: #common do: [ 
		spec 
			baseline: 'NeoCSV' with: [ spec
				repository: 'github://svenvc/NeoCSV:master' ];
			baseline: 'DataFrame' with: [ spec
				repository: 'github://PolyMathOrg/DataFrame:v2.0/src' ];
			baseline: 'GitBridge' with: [ spec
				repository: 'github://jecisc/GitBridge:v1.x.x/src' ];
			baseline: 'NgramModel' with: [ spec
				repository: 'github://pharo-ai/NgramModel/src' ].
		spec
			package: 'Ngrams' with: [ spec requires: #(GitBridge) ];
			package: 'NECompletionSorter' with: [ spec requires: #(Ngrams) ];
			package: 'NECompletionSorter-Tests' with: [ spec requires: #(NECompletionSorter) ] ]
]
