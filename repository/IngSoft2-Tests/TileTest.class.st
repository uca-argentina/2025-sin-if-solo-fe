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

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 5. 3. 4 }.

	aGameSetUp withDices: { aDice }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 2.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withSpecialTiles: { (MoonWalk in: 5 moveBack: 2) }.
	aGameSetUp createGameInstance.
	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 7.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 11.

	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 8.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 9.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7
]

{ #category : 'tests' }
TileTest >> test11WhenASpaceShipDoesntHaveEnoughFuelToMoveBackThenLosesTurnsAndGoBackToInitialPosition [

	| aGameSetUp aDice aDice2 aPlayer1 aPlayer2 aBoard |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 2.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 1. 1. 8. 5. 1. 1 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 4. 1. 2. 3. 2. 1. 1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: { (MoonWalk in: 23 moveBack: 4) }.
	aGameSetUp createGameInstance.
	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

	aBoard := aGameSetUp board.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12.
	self assert: (aBoard positionOf: aPlayer2) equals: 14.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 10.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 23.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 22
]

{ #category : 'tests' }
TileTest >> test12WhenPlayerFallsOnMoonWalkTileThenMovesBackAndConsumesFuel [

	| aGameSetUp aDice aDice2 aPlayer1 aPlayer2 aBoard |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 2.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 2. 1. 1. 8. 5. 1. 1 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 3. 1. 2. 3. 2. 1. 1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: { (MoonWalk in: 5 moveBack: 4) }.
	aGameSetUp createGameInstance.
	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

	aBoard := aGameSetUp board.
	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 20.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.

	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 19.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 8.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0
]

{ #category : 'tests' }
TileTest >> test13WhenASpaceSHipFallsInAMoonWalkButDosentHaveEnoughFulleToMoveBackThenMovesToInitialPositionInCurrentLap [

	| aGameSetUp aDice aDice2 aPlayer1 aPlayer2 aBoard |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 2.
	aGameSetUp withNumberOfPlayers: 2.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 5. 8. 2. 5. 5. 5. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 1. 4. 1. 1. 1. 1. 1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.




	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom: 1 to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: { (MoonWalk in: 4 moveBack: 6) }.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 18.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 1.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 18.

	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 15.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1
]

{ #category : 'tests' }
TileTest >> test14WhenSpaceShipFallsInHyperJumpThenItAdvancesTheAmountOfParsecs [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 2.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 2. 5. 8. 2. 5. 5. 5. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 1. 4. 1. 1. 1. 1. 1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withBoardsLengthInParsec: 100.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles:
		{ (HyperJump in: 4 parsecToMove: { 8. 4. 2. 1 }) }.
	aGameSetUp createGameInstance.
	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12
]

{ #category : 'tests' }
TileTest >> test15WhenManySpaceShipsFallInHyperJumpThenTheyAllAdvanceTheAmountOfParsecs [
	| aGameSetUp aPlayer1 aPlayer2 aPlayer3 aBoard aDice aDice2 |

	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 3.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 2. 2. 2. }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 2. 2. }.

	aGameSetUp withDices: { aDice. aDice2 }.
	aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.
	aGameSetUp withBoardsLengthInParsec: 100.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: { HyperJump in: 4 parsecToMove: { 8. 4. 2. 1 } }.

	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aPlayer3 := aGameSetUp spaceShips third.
	aBoard := aGameSetUp board.

	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 12.  
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12.

	self assert: (aBoard positionOf: aPlayer2) equals: 8.   
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 16.

	self assert: (aBoard positionOf: aPlayer3) equals: 6.   
	self assert: (aBoard currentFuleOf: aPlayer3) equals: 18.

]

{ #category : 'tests' }
TileTest >> test1WhenMinimumRollIsntMetThenTheSpaceshipIsHeldByTheHyperGravity [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4 }.
	aGameSetUp withDices: { aDice }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles:
		{ (HyperGravity in: 2 requiringMinimumRoll: 4) }.

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
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 13
]

{ #category : 'tests' }
TileTest >> test2WhenThereAreDifferentHyperGravityTilesThenEachHeldsTheSpaceShipAcordingToTheirIndependentCriteria [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles: {
			(HyperGravity in: 2 requiringMinimumRoll: 4).
			(HyperGravity in: 7 requiringMinimumRoll: 8) }.


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
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4
]

{ #category : 'tests' }
TileTest >> test4WhenAHyperGravityPositionIsOutOfTheBoardMaximumSizeThenTheGameCreationFails [

	| aGameSetUp aDice |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.


	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.

	aGameSetUp withDices: { aDice }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles:
		{ (HyperGravity in: 101 requiringMinimumRoll: 9) }.


	aGameSetUp withMaximumLapsToWin: 100.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Tile position is out of board bounds.'
]

{ #category : 'tests' }
TileTest >> test5WhenASpaceShipFallsToTheAtomicBombThenAllSpaceShipsMoveToTheStart [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 4. 5. 9 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles: { (AtomicBomb in: 7) }.

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
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7
]

{ #category : 'tests' }
TileTest >> test6WhenASpaceShipFallsInToTheBlackHoleThenItMoves4StepsBack [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 4. 5. 9 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles: { (BlackHole in: 7) }.

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
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 7
]

{ #category : 'tests' }
TileTest >> test7WhenASpaceShipFallsInToTheBlackHoleAndDoesntHaveEnoughFuleToBackThenItLoses2Turns [

	| aGameSetUp aDice aDice2 aPlayer1 aBoard |
	aGameSetUp := GameSetup new.


	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 1. 1. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 4. 1. 2. 1 }.


	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withSpecialTiles: { (BlackHole in: 23) }.

	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 21.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 3.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 21
]

{ #category : 'tests' }
TileTest >> test8WhenSpaceshipFallsInBlackHoleOfLaterLapThenItGoesToPreviousLap [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 4 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom: 1 to: 1.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withSpecialTiles: { (BlackHole in: 3) }.
	aGameSetUp createGameInstance.


	aPlayer1 := aGameSetUp spaceShips first.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 11.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 1.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4
]

{ #category : 'tests' }
TileTest >> test9WhenSpaceShipFallsInBlackHoleAtTheBeginingOfTheGameThenItGoesBackToInitialPosition [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 1. 3. 4 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withSpecialTiles: { (BlackHole in: 3) }.
	aGameSetUp createGameInstance.


	aPlayer1 := aGameSetUp spaceShips first.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 10
]

{ #category : 'tests' }
TileTest >> testF1WhenAHyperGravityHasAGreaterRequiringRollThanTheMaximumRolledNumberThenTheGameCreationFails [

	| aGameSetUp aDice |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles:
		{ (HyperGravity in: 2 requiringMinimumRoll: 11) }.


	aGameSetUp withMaximumLapsToWin: 100.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText:
		'The Requiring Minimum Roll Must Be Less Than Maximum Rolled Number'
]

{ #category : 'tests' }
TileTest >> testF2WhenASpecialTilePositionIsOutOfTheBoardMaximumSizeThenTheGameCreationFails [

	| aGameSetUp aDice |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 5. 4. 9 }.

	aGameSetUp withDices: { aDice }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.

	aGameSetUp withSpecialTiles: { (AtomicBomb in: 101) }.


	aGameSetUp withMaximumLapsToWin: 100.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Tile position is out of board bounds.'
]
