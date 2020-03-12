Extension { #name : #NgramModel }

{ #category : #'*NECompletionSorter' }
NgramModel class >> readCountsFromFile: aFileReference [
	| counts stream values ngram count |
	counts := Bag new.
	stream := aFileReference readStream.
	
	
	[stream atEnd] whileFalse: [ 
		values := stream nextLine substrings: ','.
		ngram := values first substrings asNgram.
		count := values last asNumber.
		counts add: ngram withOccurrences: count ].
	
	stream close.
	^ counts
]
