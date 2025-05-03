"
Board Game
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withNumberOfSquares: aNumber [ 
	^self new initializationBoardGame: aNumber .
]

{ #category : 'initialization' }
Board >> initializationBoardGame: aNumber [
	maximumSquares:= aNumber.
]

{ #category : 'accessing' }
Board >> numberOfSquares [
	^maximumSquares .
]

{ #category : 'accessing' }
Board >> positionOf: aPlayer [
^ aPlayer currentPosition.
 
]
