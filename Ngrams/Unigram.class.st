"
I'm a class for getting token frequencies from file
"
Class {
	#name : #Unigram,
	#superclass : #Object,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'Ngrams-DataExtraction'
}

{ #category : #'instance creation' }
Unigram class >> new [
	self error: 'FrequencyTable is a singleton -- send uniqueInstance instead'
]

{ #category : #'instance creation' }
Unigram class >> new: aClass [
	self error: 'FrequencyTable is a singleton -- send uniqueInstance instead'
]

{ #category : #'instance creation' }
Unigram class >> reset [ 
	UniqueInstance := nil
]

{ #category : #'instance creation' }
Unigram class >> uniqueInstance [

	UniqueInstance ifNil: [ UniqueInstance := self basicNew ].
	^ UniqueInstance
]

{ #category : #utilities }
Unigram >> frequencies [
	^ self readFile
]

{ #category : #utilities }
Unigram >> readFile [
	| frequencies dict |
	frequencies := TokenProcessing frequenciesFile readStreamDo: [ :readStream |
		(NeoCSVReader on: readStream)
			skipHeader;
			addField;
			addIntegerField;
			upToEnd ].
	dict := Dictionary new.
	frequencies do: [ :each | dict at: each first put: each second ].
	^ dict 
]
