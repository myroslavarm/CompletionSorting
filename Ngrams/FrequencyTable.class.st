"
I'm a class for sorting tokn frequencies
"
Class {
	#name : #FrequencyTable,
	#superclass : #Object,
	#category : #'Ngrams-FrequencyTable'
}

{ #category : #utilities }
FrequencyTable >> frequencies [
	| frequencies |
	frequencies := self readFile.
	^ frequencies 
]

{ #category : #utilities }
FrequencyTable >> frequenciesFile [

	^ TokenProcessing new dataFolder / 'frequencies.csv'
]

{ #category : #utilities }
FrequencyTable >> readFile [
	| frequencies dict |
	frequencies := self frequenciesFile readStreamDo: [ :readStream |
		(NeoCSVReader on: readStream)
			skipHeader;
			addField;
			addIntegerField;
			upToEnd ].
	dict := Dictionary new.
	frequencies do: [ :each | dict at: each first put: each second ].
	^ dict 
]

{ #category : #utilities }
FrequencyTable >> sortResults [
	| data sorted |
	data := self readFile.
	sorted := (data associations asSortedCollection: [:x :y | x value > y value]) 
            collect: [ :assoc | assoc key -> assoc value ].
	^ sorted asOrderedDictionary
]
