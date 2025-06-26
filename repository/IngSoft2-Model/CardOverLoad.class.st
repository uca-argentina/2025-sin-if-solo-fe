"
OverLoad Card

"
Class {
	#name : 'CardOverLoad',
	#superclass : 'Card',
	#instVars : [
		'spaceShipToOverLoad'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardOverLoad class >> for: aSpaceShip [

	^ self new initializationFor: aSpaceShip
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
CardOverLoad >> initializationFor: aSpaceShip [

	spaceShipToOverLoad := aSpaceShip
]

{ #category : 'abstract' }
CardOverLoad >> isInstantaneous [
	^ false.
]

{ #category : 'testing' }
CardOverLoad >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self
]

{ #category : 'testing' }
CardOverLoad >> isPermanent [

	^ true
]
