"
I'm a class for getting token frequencies from file
"
Class {
	#name : #FrequencyTable,
	#superclass : #Object,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'instance creation' }
FrequencyTable class >> new [
	self error: 'FrequencyTable is a singleton -- send uniqueInstance instead'
]

{ #category : #'instance creation' }
FrequencyTable class >> new: aClass [
	self error: 'FrequencyTable is a singleton -- send uniqueInstance instead'
]

{ #category : #'instance creation' }
FrequencyTable class >> reset [ 
	UniqueInstance := nil
]

{ #category : #'instance creation' }
FrequencyTable class >> uniqueInstance [

	UniqueInstance ifNil: [ UniqueInstance := self basicNew ].
	^ UniqueInstance
]

{ #category : #utilities }
FrequencyTable >> frequencies [
	| frequencies |
	frequencies := self readFile.
	^ frequencies 
]

{ #category : #utilities }
FrequencyTable >> frequenciesFile [

	^ TokenProcessing dataFolder / 'frequencies.csv'
]

{ #category : #utilities }
FrequencyTable >> frequencyFor: aWord [
	^ (self frequencies at: aWord ifAbsent: 0.001) asNumber
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
	"this is not used"
	| data sorted |
	data := self readFile.
	sorted := (data associations asSortedCollection: [:x :y | x value > y value]) 
            collect: [ :assoc | assoc key -> assoc value ].
	^ sorted asOrderedDictionary
]
