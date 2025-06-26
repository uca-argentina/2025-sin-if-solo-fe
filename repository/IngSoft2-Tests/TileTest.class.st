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

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 2).
			(MoonWalk in: 5 moveBack: 2) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 7.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 11.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 8.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 9.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7
]

{ #category : 'tests' }
TileTest >> test11WhenASpaceShipDoesntHaveEnoughFuelToMoveBackThenLosesTurnsAndGoBackToInitialPosition [

	| aGameSetUp aDice aDice2 aPlayer1 aPlayer2 aBoard aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 1. 1. 8. 5. 1. 1 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 4. 1. 2. 3. 2. 1. 1 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(MoonWalk in: 23 moveBack: 4) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12.
	self assert: (aBoard positionOf: aPlayer2) equals: 14.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 10.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 23.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 22
]

{ #category : 'tests' }
TileTest >> test12WhenPlayerFallsOnMoonWalkTileThenMovesBackAndConsumesFuel [

	| aGameSetUp aDice aDice2 aPlayer1 aPlayer2 aBoard aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 2. 1. 1. 8. 5. 1. 1 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 3. 1. 2. 3. 2. 1. 1 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(MoonWalk in: 5 moveBack: 4) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 20.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.

	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 19.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 8.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0
]

{ #category : 'tests' }
TileTest >> test13WhenASpaceSHipFallsInAMoonWalkButDosentHaveEnoughFulleToMoveBackThenMovesToInitialPositionInCurrentLap [

	| aGameSetUp aDice aDice2 aPlayer1 aPlayer2 aBoard aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 5. 8. 2. 5. 5. 5. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 1. 4. 1. 1. 1. 1. 1 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.





	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.

	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(MoonWalk in: 4 moveBack: 6) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 1.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 18.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 15.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1
]

{ #category : 'tests' }
TileTest >> test14WhenSpaceShipFallsInHyperJumpThenItAdvancesTheAmountOfParsecs [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 2. 5. 8. 2. 5. 5. 5. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 1. 4. 1. 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withBoardsLengthInMetric: (Parsec distance: 100).
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperJump in: 4 toMove: {
					 (Parsec distance: 8).
					 (Parsec distance: 4).
					 (Parsec distance: 2).
					 (Parsec distance: 1) }) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12
]

{ #category : 'tests' }
TileTest >> test15WhenManySpaceShipsFallInHyperJumpThenTheyAllAdvanceTheAmountOfParsecs [

	| aGameSetUp aPlayer1 aPlayer2 aPlayer3 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 2. 2. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 2. 2 }.

	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	aPlayer3 := SpaceShip named: 'Jorge'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2.
			aPlayer3 }.

	aGameSetUp withDices: {
			aDice.
			aDice2 }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2.
			                aPlayer3 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withBoardsLengthInMetric: (Parsec distance: 100).
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperJump in: 4 toMove: {
					 (Parsec distance: 8).
					 (Parsec distance: 4).
					 (Parsec distance: 2).
					 (Parsec distance: 1) }) }.

	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12.

	self assert: (aBoard positionOf: aPlayer2) equals: 8.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.

	self assert: (aBoard positionOf: aPlayer3) equals: 6.
	self assert: (aBoard currentFuleOf: aPlayer3) equals: 18
]

{ #category : 'tests' }
TileTest >> test1WhenMinimumRollIsntMetThenTheSpaceshipIsHeldByTheHyperGravity [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.


	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperGravity in: 2 requiringMinimumRoll: 4) }.

	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 13
]

{ #category : 'tests' }
TileTest >> test2WhenThereAreDifferentHyperGravityTilesThenEachHeldsTheSpaceShipAcordingToTheirIndependentCriteria [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperGravity in: 2 requiringMinimumRoll: 4).
			(HyperGravity in: 7 requiringMinimumRoll: 8) }.


	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 16.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4
]

{ #category : 'tests' }
TileTest >> test4WhenAHyperGravityPositionIsOutOfTheBoardMaximumSizeThenTheGameCreationFails [

	| aGameSetUp aDice aPlayer1 aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.


	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperGravity in: 101 requiringMinimumRoll: 9) }.


	aGameSetUp withMaximumLapsToWin: 100.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Tile position is out of board bounds.'
]

{ #category : 'tests' }
TileTest >> test5WhenASpaceShipFallsToTheAtomicBombThenAllSpaceShipsMoveToTheStart [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new. 

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 4. 5. 9 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(AtomicBomb in: 7) }.

	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 13.
	self assert: (aBoard positionOf: aPlayer2) equals: 9.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7
]

{ #category : 'tests' }
TileTest >> test6WhenASpaceShipFallsInToTheBlackHoleThenItMoves4StepsBack [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 4. 5. 9 }.

	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(BlackHole in: 7) }.

	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 9.
	self assert: (aBoard positionOf: aPlayer2) equals: 13.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7
]

{ #category : 'tests' }
TileTest >> test7WhenASpaceShipFallsInToTheBlackHoleAndDoesntHaveEnoughFuleToBackThenItLoses2Turns [

	| aGameSetUp aDice aDice2 aPlayer1 aBoard aTurnManager |
	aGameSetUp := GameSetup new.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 1. 1. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 4. 1. 2. 1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(BlackHole in: 23) }.

	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 21.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 3.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 21
]

{ #category : 'tests' }
TileTest >> test8WhenSpaceshipFallsInBlackHoleOfLaterLapThenItGoesToPreviousLap [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(BlackHole in: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 11.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4
]

{ #category : 'tests' }
TileTest >> test9WhenSpaceShipFallsInBlackHoleAtTheBeginingOfTheGameThenItGoesBackToInitialPosition [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 1. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(BlackHole in: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 10
]

{ #category : 'tests' }
TileTest >> testF1WhenTheBonusCardPositionIsNegativeThenTheCreationFails [

	| aGameSetUp aDice aPlayer1 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperGravity in: 2 requiringMinimumRoll: 11) }.


	aGameSetUp withMaximumLapsToWin: 100.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText:
		'The Requiring Minimum Roll Must Be Less Than Maximum Rolled Number'
]

{ #category : 'tests' }
TileTest >> testF2WhenASpecialTilePositionIsOutOfTheBoardMaximumSizeThenTheGameCreationFails [

	| aGameSetUp aDice aPlayer1 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(AtomicBomb in: 101) }.


	aGameSetUp withMaximumLapsToWin: 100.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Tile position is out of board bounds.'
]
