Class {
	#name : 'GameWithDiferentMetricsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameWithDiferentMetricsTest >> test1WhenHyperJumpInMetricOfParcesThenTheSpaceShipMovesProportionally [

	| aGameSetUp aPlayer1 aPlayer2 aBoard aDice aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 100.
	aDice setNumbersProvider: { 4. 4. 8. 2. 5. 5. 5. 5 }.

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
	aGameSetUp withBoardsLengthInMetric: (Parsec distance: 100).
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(HyperJump in: 4 toMove: {
					 (Parsec distance: 6).
					 (Parsec distance: 4).
					 (Parsec distance: 2).
					 (Parsec distance: 1) }) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8
]

{ #category : 'tests' }
GameWithDiferentMetricsTest >> test2WhenHyperJumpInMetricOfLightYearsThenTheSpaceShipMovesProportionally [

	| aGameSetUp aPlayer1 aBoard aDice aTurnManager |
	aGameSetUp := GameSetup new.


	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 5. 8. 2. 5. 5. 5. 5 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withBoardsLengthInMetric: (LightYears distance: 300).

	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: { (HyperJump in: 1 toMove: {
				 (LightYears distance: 12).
				 (LightYears distance: 6).
				 (LightYears distance: 1).
				 (LightYears distance: 1) }) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 13
]

{ #category : 'tests' }
GameWithDiferentMetricsTest >> test3WhenABoardHasTheirMetricInLightYearsThenItUnderstandsTheHyperJumpWithMetricsInLightYearsOrPaesecs [

	| aGameSetUp aPlayer1 aBoard aDice aTurnManager |
	aGameSetUp := GameSetup new.
 

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 5. 8. 2. 5. 5. 5. 5 }.

	aPlayer1 := SpaceShip named: 'Fran'.

	aGameSetUp withPlayers: { aPlayer1 }.


	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withBoardsLengthInMetric: (LightYears distance: 300).

	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: { (HyperJump in: 1 toMove: {
				 (LightYears distance: 6).
				 (Parsec distance: 2).
				 (LightYears distance: 3).
				 (Parsec distance: 1) }) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 3
]
