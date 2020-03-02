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
			package: 'Ngrams';
			package: 'NECompletionSorter' with: [ spec requires: #(Ngrams) ];
			package: 'NECompletionSorter-Tests' with: [ spec requires: #(NECompletionSorter) ] ]
]
