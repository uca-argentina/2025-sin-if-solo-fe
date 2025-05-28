"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'HyperJump',
	#superclass : 'TileEffect',
	#instVars : [
		'parsecDestinations',
		'tilePosition',
		'parsecsToMove'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJump class >> in: aPosition parsecToMove: someParsecsToMove [
^self new initializeHyperJumpIn: aPosition parsecToMove: someParsecsToMove.
]

{ #category : 'action' }
HyperJump >> applyConsequenceTo:allSpaceShips onBoardOfSize: maximumSquares [

|  aSpaceShip aParsecToMove|
aParsecToMove:= self getParsecToMove.

aSpaceShip:= allSpaceShips detect:[:spaceShip | spaceShip currentPosition = tilePosition ].
aSpaceShip moveTo:(aParsecToMove +aSpaceShip currentPosition )consuming: aParsecToMove.
]

{ #category : 'calculation' }
HyperJump >> calculateParsecDistribution: boardLength [
	| jump numberOfHyperJumps |
	
	numberOfHyperJumps := (boardLength*0.08) rounded .
	
	jump := (boardLength/numberOfHyperJumps) rounded .
	
	parsecDestinations := (1 to: numberOfHyperJumps) collect: [ :i | i * jump ].

	
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

{ #category : 'creation' }
HyperJump >> initializeWithBoardLength: boardLength [
	super initialize.
	self calculateParsecDistribution: boardLength.
	^ self.
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
