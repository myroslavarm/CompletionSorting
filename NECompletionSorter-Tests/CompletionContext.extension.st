Extension { #name : #CompletionContext }

{ #category : #'*NECompletionSorter-Tests' }
CompletionContext >> engine: aCompletionEngine class: aClass source: aString position: anInteger sorter: aSorter [
	class := aClass. 
	source := aString.
	position := anInteger.
	engine := aCompletionEngine.
	sorter := aSorter context: self.	
	self parseSource.
	node := ast nodeForOffset: position.
	completionToken := node completionToken: position
]

{ #category : #'*NECompletionSorter-Tests' }
CompletionContext class >> engine: aCompletionEngine class: aClass source: aString position: anInteger sorter: aSorter [
	^ self new
		engine: aCompletionEngine
		class: aClass
		source: aString
		position: anInteger
		sorter: aSorter
]
