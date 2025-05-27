Class {
	#name : 'TileTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
TileTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals:
				errorMessage ]
]

{ #category : 'tests' }
TileTest >> test1WhenMinimumRollIsntMetThenTheSpaceshipIsHeldByTheHyperGravity [


    | aGameSetUp aBoard aPlayer1  aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 1.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 1. 5. 4 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles: {HyperGravity in: 2 requiringMinimumRoll: 4}.

    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 7.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.

   
]

{ #category : 'tests' }
TileTest >> test2WhenThereAreDifferentHyperGravityTilesThenEachHeldsTheSpaceShipAcordingToTheirIndependentCriteria [


    | aGameSetUp aBoard aPlayer1  aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 1.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 1. 5. 4 . 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles:{(HyperGravity in: 2 requiringMinimumRoll: 4) . (HyperGravity in: 7 requiringMinimumRoll: 8)}.


    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 7.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.
     aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 7.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.
 	aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 16.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 4.
 

   
]

{ #category : 'tests' }
TileTest >> test3WhenAHyperGravityHasAGreaterRequiringRollThanTheMaximumRolledNumberThenTheGameCreationFails [


    | aGameSetUp  |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 1.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 1. 5. 4 . 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles:{(HyperGravity in: 2 requiringMinimumRoll: 11) .}.


    aGameSetUp withMaximumLapsToWin: 100.

	self should:[aGameSetUp createGameInstance ] 
	raise: Error
	withMessageText: 'The Requiring Minimum Roll Must Be Less Than Maximum Rolled Number'.
 

   
]

{ #category : 'tests' }
TileTest >> test4WhenAHyperGravityPositionIsOutOfTheBoardMaximumSizeThenTheGameCreationFails [


    | aGameSetUp  |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 1.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 1. 5. 4 . 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles:{(HyperGravity in: 101 requiringMinimumRoll: 9) .}.


    aGameSetUp withMaximumLapsToWin: 100.

	self should:[aGameSetUp createGameInstance ] 
	raise: Error
	withMessageText: 'Tile position is out of board bounds.'.
 

   
]

{ #category : 'TileDistributorTest' }
TileTest >> testReturnsADictionary [

	| aDistributor aBoard |
	aDistributor := TileEffectDistributor new.
	aBoard := BoardGame new.

	aDistributor initalizeWith: aBoard.

	self assert: (aDistributor instVarNamed: 'tileEffectsByPosition') class equals: Dictionary .
]

{ #category : 'tests' }
TileTest >> testTileEffectPolymorphism [

	| effects aBoard aSpaceShip results|
	
	effects := { 
	BlackHole new.
	MoonWalk new.
	HyperGravity new.
	HyperJump new.
	AtomicBomb new.
	}.
	
	aBoard := BoardGame new.
	aSpaceShip := SpaceShip new.
	results := effects collect: [:effect | 
		(effect applyTo: aSpaceShip on: aBoard) asString 
	].

	self assert: (results asSet size > 1).
]
