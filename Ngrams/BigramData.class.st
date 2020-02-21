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
