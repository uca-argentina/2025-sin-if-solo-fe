"
Tile WormHole
"
Class {
	#name : 'WormHole',
	#superclass : 'TileEffect',
	#instVars : [
		'wormHoleEntrance',
		'wormHoleExit'
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

	|aSpaceShip originalPosition destination distance |
	aSpaceShip:= allSpaceShips detect:[:spaceShip | spaceShip currentPosition = tilePosition ].
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

{ #category : 'initialization' }
WormHole >> initializeWormHoleFrom:aWormholeEntrance to:aWormholeExit [
wormHoleEntrance:=aWormholeEntrance.
wormHoleExit:=aWormholeExit .
tilePosition:=aWormholeEntrance .
]

{ #category : 'validating' }
WormHole >> validateCreationIn: boardSize and: maximumRolledNumber [

(wormHoleEntrance > boardSize or: wormHoleExit >boardSize ) ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].

]
