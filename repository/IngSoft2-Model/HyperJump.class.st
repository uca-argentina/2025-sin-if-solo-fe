"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'HyperJump',
	#superclass : 'TileEffect',
	#instVars : [
		'parsecDestinations',
		'parsecsToMove',
		'aParsecToMove'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJump class >> in: aPosition parsecToMove: someParsecsToMove [
^self new initializeHyperJumpIn: aPosition parsecToMove: someParsecsToMove.
]

{ #category : 'action' }
HyperJump >> applyConsequenceTo:allSpaceShips onBoardOfSize: aBoard [

|  aSpaceShip  squaresToMove|
aParsecToMove:= self getParsecToMove.

aSpaceShip:= allSpaceShips detect:[:spaceShip | spaceShip currentPosition = tilePosition ].

squaresToMove:=aSpaceShip currentPosition + (self calculateParsecDistribution: aBoard).


aSpaceShip moveTo:(squaresToMove)consuming: (self calculateParsecDistribution: aBoard).
]

{ #category : 'calculation' }
HyperJump >> calculateParsecDistribution: aBoard [
	
	^ aBoard squaresInParsec:aParsecToMove.
	

	
]

{ #category : 'accessing' }
HyperJump >> getParsecToMove [

 | nextParsec |
    nextParsec := parsecsToMove first.
    parsecsToMove removeFirst.
    parsecsToMove add: nextParsec.
    ^ nextParsec
]

{ #category : 'initialization' }
HyperJump >> initializeHyperJumpIn: aPosition parsecToMove: someParsecsToMove [
tilePosition:=aPosition .
parsecsToMove :=OrderedCollection new.
parsecsToMove addAll:((someParsecsToMove)sort: [:aParsec :anotherParsec | aParsec> anotherParsec]).

]

{ #category : 'testing' }
HyperJump >> isHyperJump [
^true.
]

{ #category : 'accessing' }
HyperJump >> parsecDestinations [
	^ parsecDestinations 
]

{ #category : 'accessing' }
HyperJump >> position [
^tilePosition .
]

{ #category : 'validating' }
HyperJump >> validateCreationIn: boardSize and: maximumRolledNumber [

tilePosition > boardSize ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].

]
