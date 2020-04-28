Extension { #name : #CompletionContext }

{ #category : #'*NECompletionSorter' }
CompletionContext >> ast [
	^ ast
]

{ #category : #'*NECompletionSorter' }
CompletionContext >> position [
	^ position
]

{ #category : #'*NECompletionSorter' }
CompletionContext >> source [
	^ source ifNil: [ ^ ''  ]
]
