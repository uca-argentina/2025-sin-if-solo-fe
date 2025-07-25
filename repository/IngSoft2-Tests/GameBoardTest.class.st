Class {
	#name : 'GameBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameBoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals:
				errorMessage ]
]

{ #category : 'tests' }
GameBoardTest >> test010WhenAWormHoleWhichExitIsTheFinishLineThenCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 3. 6. 1. 7 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 6 to: 2) }.

	aGameSetUp withMaximumLapsToWin: 1.


	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText:
		'The worm hole exit must be smaller than the number of squares'
]

{ #category : 'tests' }
GameBoardTest >> test011WhenABoardWithAWormHoleInANegativePositionThenCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 7 }.
	aGameSetUp withDices: { aDice }.

	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: -1 to: 1) }.

	aGameSetUp withMaximumLapsToWin: 2.


	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Should be a positive number'
]

{ #category : 'tests' }
GameBoardTest >> test012WhenABoardWithNumberOfSquaresIsNegativeThenCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 7 }.
	aGameSetUp withDices: { aDice }.

	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: -1 to: -1) }.
	aGameSetUp withMaximumLapsToWin: 2.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Should be a positive number'
]

{ #category : 'tests' }
GameBoardTest >> test013WhenABoardHasLessThanThreeSquaresThenCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 7 }.

	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.
	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 2 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 3 to: 6) }.
	aGameSetUp withMaximumLapsToWin: 2.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Should have at least 3 squares'
]

{ #category : 'tests' }
GameBoardTest >> test014WhenSpaceshipTriesToMoveOutsideBoardThenNothingChanges [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 1. 6 }.
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
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 2.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	aPlayer1 moveTo: 99 consuming: 1.
	self assert: (aBoard positionOf: aPlayer1) equals: 2
]

{ #category : 'tests' }
GameBoardTest >> test015WhenTheSpaceShipGetsToTheMaximumOfSquaresThenSpaceShipGoesToInitialPosition [

	| aGameSetUp aBoard aPlayer1 aDice aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 3. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 2.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.


	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1
]

{ #category : 'tests' }
GameBoardTest >> test016WhenTheExitOfTheWormHoleIsGreaterThanTheNumbersOfSqueareOfTheBoardThenBoardCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 7 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.

	aGameSetUp withTiles: { (WormHole from: 6 to: 12) }.
	aGameSetUp withMaximumLapsToWin: 2.

	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Tile position is out of board bounds.'
]

{ #category : 'tests' }
GameBoardTest >> test017WhenSpaceShipDoesMultipleLapsInOneRollThenWins [

	| aGameSetUp aBoard aPlayer1 aDice aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 12. 3. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 2.
	aGameSetUp createGameInstance.



	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.



	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1
]

{ #category : 'tests' }
GameBoardTest >> test018WhenASpaceShipWinsTheGameThenTheBoardKnowsTheLapsCompleted [

	| aGameSetUp aBoard aPlayer1 aDice aPlayer2 aPlayer3 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 7 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	aPlayer3 := SpaceShip named: 'Jorge'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2.
			aPlayer3 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2.
			                aPlayer3 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 2.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.

	aBoard playNextTurn.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 2.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer3) equals: 0
]

{ #category : 'tests' }
GameBoardTest >> test019WhenTheGameEndsThenThereIsARanking [

	| aGameSetUp aBoard aPlayer1 aDice aPlayer2 aPlayer3 aPlayer4 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 4. 1. 7 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	aPlayer3 := SpaceShip named: 'Jorge'.
	aPlayer4 := SpaceShip named: 'Marinho'.


	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2.
			aPlayer3.
			aPlayer4 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2.
			                aPlayer3.
			                aPlayer4 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 2.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.




	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer3.
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test020WhenASpaceShipFinallyPositionIsLessThanOtherSpaceShipButCompletedTheMaximumLapsThenIsTheWinner [

	| aGameSetUp aBoard aPlayer1 aDice aPlayer2 aPlayer3 aPlayer4 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 3. 8. 1. 7 }.

	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	aPlayer3 := SpaceShip named: 'Jorge'.
	aPlayer4 := SpaceShip named: 'Marinho'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2.
			aPlayer3.
			aPlayer4 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2.
			                aPlayer3.
			                aPlayer4 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.


	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.



	self assert: (aBoard positionOf: aPlayer3) equals: 3.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer3.
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer2.
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer1
]

{ #category : 'tests' }
GameBoardTest >> test021WhenThereIsADrawForSecondPlaceThenTheSilverIsTheFirstPlayerToMove [

	| aGameSetUp aBoard aPlayer1 aDice aPlayer2 aPlayer3 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 3. 6. 1. 7 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.
	aPlayer3 := SpaceShip named: 'Jorge'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2.
			aPlayer3 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2.
			                aPlayer3 }.

	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.



	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer3) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 3.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.

	self assert: (aBoard completedLapsBy: aPlayer3) equals: 1.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer3.
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer1.
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test1WhenTheGameBeginsTheBoardKnowsTheSpaceShipsInitialPosition [

	| aBoard initialPosition fuel aTurnManager aPlayer1 |
	aPlayer1 := SpaceShip named: 'Juan'.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	initialPosition := 0.
	fuel := 100.
	aBoard := Board
		          withNumberOfSquares: 60
		          withSizeInParsec: 10
		          andA: nil.

	self assert: aPlayer1 currentPosition equals: 0
]

{ #category : 'tests' }
GameBoardTest >> test2WhenADiceIsRolledThenTheSpaceShipsPositionInTheBoardChanges [

	| aGameSetUp aBoard aPlayer1 aDice aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 3. 1 }.
	aPlayer1 := SpaceShip named: 'Juan'.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp withABoardNumberOfSquares: 64 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.


	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 8.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 11
]

{ #category : 'tests' }
GameBoardTest >> test3WhenASpaceShipCompletesTheLapThenItsTheWinner [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 2 to: 5) }.


	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.


	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: (aBoard positionOf: aPlayer1) equals: 6
]

{ #category : 'tests' }
GameBoardTest >> test4WhenTheFirstSpaceShipCompletesTheLapThenItsTheWinner [

	| aGameSetUp aDice1 aDice2 aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice1 := RiggedDice withNumberOfFaces: 6.
	aDice1 setNumbersProvider: { 2. 3. 3. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 6.
	aDice2 setNumbersProvider: { 2. 3. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Marina'.
	aPlayer2 := SpaceShip named: 'Caro'.


	aGameSetUp withDices: {
			aDice1.
			aDice2 }.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.


	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.

	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 6.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test5WhenSpaceshipRolledNumberExceedsRemainingDistanceToFinishLineAndCompletesTheLapThenItWins [

	| aGameSetUp aBoard aDice aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 4. 8. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Lucas'.
	aPlayer2 := SpaceShip named: 'Martina'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.


	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 3 to: 5) }.

	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playNextTurn.

	aBoard playNextTurn.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2.
	self assert: (aBoard positionOf: aPlayer2) equals: 2
]

{ #category : 'tests' }
GameBoardTest >> test6WhenThereIsAWinnerThenNoMoreRoundsArePlayed [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 4. 8. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 3 to: 5) }.

	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test8WhenTheSpaceShipFallsIntoTheWormHoleEntranceThenItMovesToTheWormHoleExit [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 3. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Jorge'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 2 to: 5) }.

	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 5
]

{ #category : 'tests' }
GameBoardTest >> test9WhenTheSpaceShipFallsIntoWormHoleExitThenItMovesToTheWormHoleEntrance [

	| aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 3. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 2 to: 5) }.

	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.


	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 2
]
