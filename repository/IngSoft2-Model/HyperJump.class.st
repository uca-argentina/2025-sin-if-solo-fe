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
HyperJump class >> in: aPosition toMove: someParsecsToMove [
^self new initializeHyperJumpIn: aPosition parsecToMove: someParsecsToMove.
]

{ #category : 'action' }
HyperJump >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	| aSpaceShip squaresToMove |
	aParsecToMove := self getParsecToMove.

	aSpaceShip := allSpaceShips detect: [ :spaceShip |
		              spaceShip currentPosition = tilePosition ].

	squaresToMove := aSpaceShip currentPosition
	                 + (self calculateParsecDistribution: aBoard).


	aSpaceShip
		moveTo: squaresToMove
		consuming: (self calculateParsecDistribution: aBoard)
]

{ #category : 'action' }
HyperJump >> applyEffectToSpecific: spaceship on: board [

	| squaresToMove |
	aParsecToMove := self getParsecToMove.

	squaresToMove := spaceship currentPosition
	                 + (self calculateParsecDistribution: board).


	spaceship
		moveTo: squaresToMove
		consuming: (self calculateParsecDistribution: board)
]

{ #category : 'calculation' }
HyperJump >> calculateParsecDistribution: aBoard [

	^ aBoard squaresInParsec: aParsecToMove
]

{ #category : 'accessing' }
HyperJump >> getParsecToMove [

	| nextParsec |
	nextParsec := parsecsToMove first.
	parsecsToMove removeFirst.
	parsecsToMove add: nextParsec.
	^ nextParsec distance
]

{ #category : 'initialization' }
HyperJump >> initializeHyperJumpIn: aPosition parsecToMove: someParsecsToMove [

	tilePosition := aPosition.
	parsecsToMove := OrderedCollection new.
	parsecsToMove addAll:
		(someParsecsToMove sort: [ :aParsec :anotherParsec |
			 aParsec asParsecs > anotherParsec asParsecs ])
]
