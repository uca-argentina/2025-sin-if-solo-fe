"
OverLoad Card

"
Class {
	#name : 'CardOverLoad',
	#superclass : 'Object',
	#instVars : [
		'spaceShipToOverLoad'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardOverLoad class >> for: aSpaceShip [

	^ self new initializeOverLoadFor: aSpaceShip
]

{ #category : 'action' }
CardOverLoad >> applyEffectTo: spaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [

	| rolledNumberAdjust |
	rolledNumberAdjust := 0.


	spaceShip = spaceShipToOverLoad ifTrue: [
		spaceShip goBack: 2 onBoardOfSize: aBoard numberOfSquares ].

	game upDateLastCardPlayed: self
]

{ #category : 'action' }
CardOverLoad >> changeTo: anImplementation [

	^ self class for: anImplementation
]

{ #category : 'initialization' }
CardOverLoad >> initializeOverLoadFor: aSpaceShip [

	spaceShipToOverLoad := aSpaceShip
]

{ #category : 'testing' }
CardOverLoad >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self
]

{ #category : 'testing' }
CardOverLoad >> isPermanent [

	^ true
]
