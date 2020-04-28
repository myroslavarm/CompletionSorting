Extension { #name : #TokensCollectingVisitor }

{ #category : #'*NgramsEvaluation' }
TokensCollectingVisitor >> encodeLiteral: aLiteral [
	aLiteral isNumber
		ifTrue: [ ^ '<num>' ].
	aLiteral isSymbol
		ifTrue: [ ^ '<sym>' ].
	aLiteral isString
		ifTrue: [ ^ '<str>' ].
	aLiteral isCharacter 
		ifTrue: [ ^ '<chr>' ].
	aLiteral isComment
		ifTrue: [ ^ '<com>' ].
	aLiteral isArray
		ifTrue: [ ^ '<arr>' ].
	^ aLiteral asString "true, false, or nil"
]
