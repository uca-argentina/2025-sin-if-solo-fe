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
TileTest >> test10WhenTheSpaceShipFallsInMoonWalkThenAllTheOtherSpaceShipsMoveBack [

|aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:2 .
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {7. 5. 3. 4 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom:1 to: 2.
	aGameSetUp withMaximumLapsToWin: 3. 
	aGameSetUp withSpecialTiles: {MoonWalk in: 5 moveBack:2 }.
	aGameSetUp createGameInstance.
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 7.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 11.
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 8.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 9.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7.

]

{ #category : 'tests' }
TileTest >> test11WhenASpaceShipDoesntHaveEnoughFuelToMoveBackThenLosesTurnsAndGoBackToInitialPosition [

   | aGameSetUp aPlayer1 aPlayer2 aBoard |
	aGameSetUp:= GameSetup new.
	
	aGameSetUp withNumberOfPlayers:2.
	aGameSetUp withRiggedDiceConfigs: {
       aGameSetUp withRiggedDiceNumbers:  {8. 7. 1 . 1 . 8. 5. 1. 1 } andNumberOfFaces: 8.
		aGameSetUp withRiggedDiceNumbers:  {2. 4. 1 . 2 . 3. 2. 1 . 1 } andNumberOfFaces: 4.}.
			
	aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: {MoonWalk in: 23 moveBack: 4}.
	aGameSetUp createGameInstance .
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	
	aBoard:=(aGameSetUp board).
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 12.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 12.
	self assert: (aBoard positionOf: aPlayer2 ) equals: 14.
	self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 10.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 23.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 1.
	self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer2 ) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 22.

	
	
	
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

{ #category : 'tests' }
TileTest >> test5WhenASpaceShipFallsToTheAtomicBombThenAllSpaceShipsMoveToTheStart [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 4. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles: {AtomicBomb in: 7}.

    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
    self assert: (aBoard positionOf: aPlayer2) equals: 4.
    self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.
    self assert: (aBoard positionOf: aPlayer2) equals: 9.
    self assert: (aBoard currentFuleOf: aPlayer2) equals: 7.


   
]

{ #category : 'tests' }
TileTest >> test6WhenASpaceShipFallsInToTheBlackHoleThenItMoves4StepsBack [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 4. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles: {BlackHole in: 7}.

    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	 aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
    self assert: (aBoard positionOf: aPlayer2) equals: 4.
    self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1) equals: 3.
    self assert: (aBoard currentFuleOf: aPlayer1) equals: 9.
    self assert: (aBoard positionOf: aPlayer2) equals: 13.
    self assert: (aBoard currentFuleOf: aPlayer2) equals: 7.


   
]

{ #category : 'tests' }
TileTest >> test7WhenASpaceShipFallsInToTheBlackHoleAndDoesntHaveEnoughFuleToBackThenItLoses2Turns [


   | aGameSetUp aPlayer1 aBoard |

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {8. 7. 1 . 1 . 4} andNumberOfFaces: 8.
			aGameSetUp withRiggedDiceNumbers:  {2. 4. 1 . 2 . 1} andNumberOfFaces: 4.}.
			
	aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: {BlackHole in: 23}.
	
	aGameSetUp createGameInstance .

	aPlayer1:=(aGameSetUp spaceShips) first.
	aBoard:=(aGameSetUp board).
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 21.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 3.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 21.
]

{ #category : 'tests' }
TileTest >> test8WhenSpaceshipFallsInBlackHoleOfLaterLapThenItGoesToPreviousLap [
|aGameSetUp aBoard aPlayer1 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:1 .
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 4 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 3. 
	aGameSetUp withSpecialTiles: {BlackHole in: 3}.
	aGameSetUp createGameInstance.

	
	aPlayer1:=(aGameSetUp spaceShips) first.

	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals:11. 
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
   aBoard playOneRound.
   self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals:4.
]

{ #category : 'tests' }
TileTest >> test9WhenSpaceShipFallsInBlackHoleAtTheBeginingOfTheGameThenItGoesBackToInitialPosition [
|aGameSetUp aBoard aPlayer1 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:1 .
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {3. 1. 3. 4 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 3. 
	aGameSetUp withSpecialTiles: {BlackHole in: 3}.
	aGameSetUp createGameInstance.

	
	aPlayer1:=(aGameSetUp spaceShips) first.

	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 10.

]

{ #category : 'tests' }
TileTest >> testF1WhenAHyperGravityHasAGreaterRequiringRollThanTheMaximumRolledNumberThenTheGameCreationFails [


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
TileTest >> testF2WhenASpecialTilePositionIsOutOfTheBoardMaximumSizeThenTheGameCreationFails [


    | aGameSetUp  |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 1.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 1. 5. 4 . 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

    aGameSetUp withSpecialTiles:{(AtomicBomb in: 101) .}.


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
