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

	^ DataFrame readFromCsv: self frequenciesFile
]

{ #category : #utilities }
FrequencyModel >> sortResults [
	| data sorted |
	data := self readFile.
	sorted := data sorted: [ :a :b | (a at: 'value') > (b at: 'value') ].
	^ sorted
]
