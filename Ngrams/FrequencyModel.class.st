"
I'm a class for sorting tokn frequencies
"
Class {
	#name : #FrequencyModel,
	#superclass : #Object,
	#category : #'Ngrams-FrequencyModel'
}

{ #category : #utilities }
FrequencyModel >> frequencies [
	| frequencies |
	frequencies := self readFile.
	^ frequencies 
]

{ #category : #utilities }
FrequencyModel >> frequenciesFile [

	^ DataPreprocessing new dataFolder / 'frequencies.csv'
]

{ #category : #utilities }
FrequencyModel >> readFile [
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
FrequencyModel >> sortResults [
	| data sorted |
	data := self readFile.
	sorted := (data associations asSortedCollection: [:x :y | x value > y value]) 
            collect: [ :assoc | assoc key -> assoc value ].
	^ sorted asOrderedDictionary
]
