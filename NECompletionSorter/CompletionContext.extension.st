Extension { #name : #CompletionContext }

{ #category : #'*NECompletionSorter' }
CompletionContext >> position [
	^ position
]

{ #category : #'*NECompletionSorter' }
CompletionContext >> source [
	^ source ifNil: [ ^ ''  ]
]
