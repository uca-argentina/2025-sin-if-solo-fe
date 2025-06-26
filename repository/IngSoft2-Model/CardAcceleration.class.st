"
A
"
Class {
	#name : 'CardAcceleration',
	#superclass : 'Card',
	#instVars : [
		'accelerationIncrement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
CardAcceleration class >> isPositive: aNumber [

	aNumber < 0 ifTrue: [
		Error signal: 'A CardAcceleration has to have a positive increment' ]
]

{ #category : 'initialization' }
CardAcceleration class >> withIncrement: aNumber [

	self isPositive: aNumber.

	^ self new initializationFor: aNumber
]

{ #category : 'action' }
CardAcceleration >> applyEffectTo: spaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [

	game move: spaceShip forwardBy: accelerationIncrement
]

{ #category : 'action' }
CardAcceleration >> changeTo: anImplementation [

	^ self class withIncrement: anImplementation.
]

{ #category : 'initialization' }
CardAcceleration >> initializationFor: aNumber [

	permanent := true.
	instantaneous := false.

	accelerationIncrement := aNumber
]

{ #category : 'testing' }
CardAcceleration >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self 
]
