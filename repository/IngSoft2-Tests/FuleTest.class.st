Class {
	#name : 'FuleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FuleTest >> test010WhenASpaceShipSkipsATurnThenTheNextSpaceShipPlays [

	| aGameSetUp aDice aDice2 aPlayer1 aBoard aPlayer2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 5 }.
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
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14.

	aBoard skipNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 14.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 10
]

{ #category : 'tests' }
FuleTest >> test0WhenASpaceShipDoesntMoveThenItHasInitialFuel [

	| aGameSetUp aDice aPlayer1 aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 3. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 2 to: 5) }.
	aGameSetUp withMaximumLapsToWin: 1.

	aGameSetUp createGameInstance.


	self assert: aPlayer1 currentFule equals: 16
]

{ #category : 'tests' }
FuleTest >> test1WhenASpaceShipDoesntMoveThenItHasTheDoubleOfTheMaximumRolledNumberFuel [

	| aGameSetUp aDice aDice2 aPlayer1 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 3. 3. 3 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 2. 3. 4 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 2 to: 5) }.
	aGameSetUp withMaximumLapsToWin: 1.

	aGameSetUp createGameInstance.

	self assert: aPlayer1 currentFule equals: 24
]

{ #category : 'tests' }
FuleTest >> test2WhenASpaceShipMovesThenFuelDecreasesByTheAmountMoved [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 3. 3. 3 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 2. 3. 4 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 10.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 16
]

{ #category : 'tests' }
FuleTest >> test3WhenASpaceShipDoesntHaveAnyFuleLeftThenItGoesBackToTheInitialPosition [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 6.

	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0
]

{ #category : 'tests' }
FuleTest >> test4WhenSpaceShipDoesntHaveFuleThenLosesTwoTurnsAndThenItCanMoveAgainWithTheirMaximumFule [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 2. 8. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 2. 3. 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 6.

	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 14
]

{ #category : 'tests' }
FuleTest >> test5WhenMoreThanOneSpaceShipDoesntHaveFuleThenBothCantMoveForTwoTurns [

	| aGameSetUp aPlayer1 aPlayer2 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 2. 8. 7. 2. 8. 7. 2. 8. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 2. 3. 2. 2. 3. 2. 2. 3. 2 }.

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
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 16.

	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	aBoard playNextTurn.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 14.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14
]

{ #category : 'tests' }
FuleTest >> test6WhenASpaceShipFallsIntoAEntranceOfWormHoleThenTheFuleDecrecesTheAmountMoved [

	| aGameSetUp aDice aPlayer1 aBoard aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.


	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 80 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 3 to: 5) }.
	aGameSetUp withMaximumLapsToWin: 100.

	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19
]

{ #category : 'tests' }
FuleTest >> test7WhenASpaceShipFallsIntoAExitOfWormHoleThenTheFuleDecrecesTheAmountMoved [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 666
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 3 to: 5) }.
	aGameSetUp withMaximumLapsToWin: 100.

	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 17
]

{ #category : 'tests' }
FuleTest >> test8WhenASpaceShipChoosesToSkipARoundThenDosentMoveAndRechargesTheFule [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.
	aPlayer1 := SpaceShip named: 'Fran'.


	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19.

	aBoard skipNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 15.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 14
]

{ #category : 'tests' }
FuleTest >> test9WhenBothSpaceShipsSkipRoundThenTheyRechargeAllTheirFule [

	| aGameSetUp aPlayer1 aBoard aPlayer2 aDice aDice2 aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 5 }.
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
	aGameSetUp withTiles: { (WormHole from: 1 to: 1) }.
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14.

	aBoard skipNextTurn.
	aBoard skipNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 9.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 20.
	self assert: (aBoard positionOf: aPlayer2) equals: 20.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14
]
