Class {
	#name : #MyProjectBridge,
	#superclass : #GitBridge,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'class initialization' }
MyProjectBridge class >> initialize [
	SessionManager default registerSystemClassNamed: self name
]
