"
Parsec
"
Class {
	#name : 'Parsec',
	#superclass : 'Object',
	#instVars : [
		'distance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Parsec class >> distance:aDistance [

^self new initializeParsec:aDistance .
]

{ #category : 'action' }
Parsec >> asParsecs [

	^ distance
]

{ #category : 'accessing' }
Parsec >> distance [

	^ distance
]

{ #category : 'initialization' }
Parsec >> initializeParsec: aDistance [

	distance := aDistance
]
