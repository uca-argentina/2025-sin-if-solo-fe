"
A Real Dice  that rolls a random number
"
Class {
	#name : 'RealDice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces',
		'rolledNumber'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RealDice class >> hasAtLeastOneFace:aNumber [
 (aNumber negative or: aNumber =0 )ifTrue: [ 
        Error signal: 'A Dice has to have at least 1 face']
]

{ #category : 'initialization' }
RealDice class >> withNumberOfFaces:aNumber [
self hasAtLeastOneFace:aNumber.
^self new initializeNumberOfFaces: aNumber .
]

{ #category : 'initialization' }
RealDice >> initializeNumberOfFaces: aNumber [

	numberOfFaces := aNumber
]

{ #category : 'accessing' }
RealDice >> maximumFace [

	^ numberOfFaces
]

{ #category : 'accessing' }
RealDice >> numberJustRolled [

	^ rolledNumber
]

{ #category : 'accessing' }
RealDice >> numberOfFaces [

	^ numberOfFaces
]

{ #category : 'accessing' }
RealDice >> rolledNumber [

	rolledNumber := (1 to: numberOfFaces) atRandom.
	^ rolledNumber
]
