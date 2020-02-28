"
I am a class that gets bigram data

the idea is to:
-calculate frequency of the word before cursor
-calculate how often that word is followed by the tokens from the list of suggestions
-hand over those calculations to be used in the sorter
"
Class {
	#name : #BigramData,
	#superclass : #Object,
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'accessing - data' }
BigramData >> bigramFrequenciesFile [

	^ TokenProcessing dataFolder / 'bigrams.json'
]

{ #category : #'accessing - data' }
BigramData >> bigrams [
	| bigrams |
	bigrams := self readFile.
	^ bigrams 
]

{ #category : #'accessing - data' }
BigramData >> getFrequencyOf: aWord [
	| data |
	data := FrequencyTable uniqueInstance frequencies.
	^ self getFrequencyOf: aWord from: data
]

{ #category : #'accessing - data' }
BigramData >> getFrequencyOf: aWord from: aTable [
	^ (aTable at: aWord ifAbsent: 0)
]

{ #category : #'accessing - data' }
BigramData >> readFile [
	| bigrams |
	bigrams := self bigramFrequenciesFile readStreamDo: [ :readStream |
		STONJSON fromStream: readStream ].
	^ bigrams
	
]
