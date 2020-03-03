"
this is to have access to files in the repository when testing using the CI
"
Class {
	#name : #MyProjectBridge,
	#superclass : #GitBridge,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'class initialization' }
MyProjectBridge class >> initialize [
	SessionManager default registerSystemClassNamed: self name
]
