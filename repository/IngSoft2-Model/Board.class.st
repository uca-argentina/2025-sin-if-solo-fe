Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numberOfSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withNumberOfSquares: aNumber [ 
	^self new initializeNumberOfSquares: aNumber .
]

{ #category : 'initialization' }
Board >> initializeNumberOfSquares: aNumber [
	numberOfSquares:= aNumber.
]

{ #category : 'initialization' }
Board >> numberOfSquares [
	^numberOfSquares 
]
