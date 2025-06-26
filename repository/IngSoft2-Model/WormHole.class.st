"
Tile WormHole
"
Class {
	#name : 'WormHole',
	#superclass : 'TileEffect',
	#instVars : [
		'wormHoleEntrance',
		'wormHoleExit',
		'distance',
		'destination'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
WormHole class >> from:wormholeEntrance to:wormholeExit [
^self new initializeWormHoleFrom:wormholeEntrance to:wormholeExit.
]

{ #category : 'action' }
WormHole >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	| aSpaceShip originalPosition |
	aSpaceShip := allSpaceShips detect: [ :spaceShip |
		              spaceShip currentPosition = wormHoleEntrance or:
			              spaceShip currentPosition = wormHoleExit ].
	originalPosition := aSpaceShip currentPosition.
	originalPosition = wormHoleEntrance ifTrue: [
		destination := wormHoleExit.
		distance := aBoard distanceFrom: originalPosition to: destination.
		aSpaceShip moveTo: destination consuming: distance ].

	originalPosition = wormHoleExit ifFalse: [ ^ self ].
	destination := wormHoleEntrance.
	distance := aBoard distanceFrom: originalPosition to: destination.
	aSpaceShip moveTo: destination consuming: distance
]

{ #category : 'action' }
WormHole >> applyEffectToSpecific: spaceship on: board [

	spaceship moveTo: destination consuming: distance
]

{ #category : 'testing' }
WormHole >> includesA: position [

	^ position = wormHoleEntrance or: [ position = wormHoleExit ]
]

{ #category : 'initialization' }
WormHole >> initializeWormHoleFrom: aWormholeEntrance to: aWormholeExit [

	wormHoleEntrance := aWormholeEntrance.
	wormHoleExit := aWormholeExit.
	tilePosition := aWormholeEntrance
]

{ #category : 'validating' }
WormHole >> validateCreationIn: boardSize and: maximumRolledNumber [

	(wormHoleEntrance > boardSize or: wormHoleExit > boardSize) ifTrue: [
		Error signal: 'Tile position is out of board bounds.' ].
	wormHoleEntrance > wormHoleExit ifTrue: [
		Error signal:
			'The worm hole exit must be smaller than the number of squares' ].

	(wormHoleEntrance < 0 or: wormHoleExit < 0) ifTrue: [
		Error signal: 'Should be a positive number' ]
]
