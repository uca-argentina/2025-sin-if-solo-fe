Class {
	#name : 'DistributionOfTilesTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DistributionOfTilesTest >> test1WhenABoardIsCreatedThen2PercentOfSquaresAreAtomicBomb [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 2. 5. 9 }.
	aPlayer1:= SpaceShip named: 'Fran'.
	aPlayer2:= SpaceShip named: 'Agustin'.
		
		aGameSetUp withPlayers: {aPlayer1. aPlayer2 }.

	aGameSetUp withDices: { aDice }.


aTurnManager:=TurnManager withOrder:{aPlayer1 . aPlayer2}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager .
	aGameSetUp withSpecialTiles: { (WormHole from: 1 to: 1) }.

	aGameSetUp withAdistribution.


	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.


	self assert: (aBoard percentageOf: AtomicBomb) equals: 2
]

{ #category : 'tests' }
DistributionOfTilesTest >> test2WhenABoardIsCreatedThen8PercentOfSquaresAreHyperJump [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 2. 5. 9 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.


aTurnManager:=TurnManager withOrder:{aPlayer1 . aPlayer2}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager .
	aGameSetUp withSpecialTiles: { (WormHole from: 1 to: 1) }.

	aGameSetUp withAdistribution.


	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.


	self assert: (aBoard percentageOf: HyperJump) equals: 8
]

{ #category : 'tests' }
DistributionOfTilesTest >> test3WhenABoardIsCreatedThen10PercentOfSquaresAreMoonWalk [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 2. 5. 9 }.
		aPlayer1:= SpaceShip named: 'Fran'.
	aPlayer2:= SpaceShip named: 'Agustin'.
		
		aGameSetUp withPlayers: {aPlayer1. aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager:=TurnManager withOrder:{aPlayer1 . aPlayer2}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager .
	aGameSetUp withSpecialTiles: { (WormHole from: 1 to: 1) }.

	aGameSetUp withAdistribution.


	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.


	self assert: (aBoard percentageOf: MoonWalk) equals: 10
]

{ #category : 'tests' }
DistributionOfTilesTest >> test4WhenABoardIsCreatedThen20PercentOfSquaresAreHyperGravity [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 2. 5. 9 }.
	
	aPlayer1:= SpaceShip named: 'Fran'.
	aPlayer2:= SpaceShip named: 'Agustin'.
		
		aGameSetUp withPlayers: {aPlayer1. aPlayer2 }.

	aGameSetUp withDices: { aDice }.

	aTurnManager:=TurnManager withOrder:{aPlayer1 . aPlayer2}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager .
	aGameSetUp withSpecialTiles: { (WormHole from: 1 to: 1) }.

	aGameSetUp withAdistribution.


	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.


	self assert: (aBoard percentageOf: HyperGravity) equals: 20
]

{ #category : 'tests' }
DistributionOfTilesTest >> test5WhenABoardIsCreatedThen20PercentOfSquaresAreBlackHole [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 2. 5. 9 }.
		aPlayer1:= SpaceShip named: 'Fran'.
	aPlayer2:= SpaceShip named: 'Agustin'.
		
		aGameSetUp withPlayers: {aPlayer1. aPlayer2 }.

	aGameSetUp withDices: { aDice }.

aTurnManager:=TurnManager withOrder:{aPlayer1 . aPlayer2}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager .
	aGameSetUp withSpecialTiles: { (WormHole from: 1 to: 1) }.

	aGameSetUp withAdistribution.


	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.

	self assert: (aBoard percentageOf: BlackHole) equals: 20
]

{ #category : 'tests' }
DistributionOfTilesTest >> testBanana [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem aDice aTurnManager aTileDistribution  |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 2. 5. 9 }.
	aPlayer1:= SpaceShip named: 'Fran'.
	aPlayer2:= SpaceShip named: 'Agustin'.
		
		aGameSetUp withPlayers: {aPlayer1. aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	
	aTurnManager:=TurnManager withOrder:{aPlayer1 . aPlayer2}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager .
	aGameSetUp withSpecialTiles: { (WormHole from: 1 to: 1) }.

	
	aTileDistribution:= TileDistribution withABoardNumberOfSquares: 100.
	aTileDistribution forNoEffect:0.40.
	aTileDistribution forBlackHole: 0.20.
	aTileDistribution forHyperGravity: 0.2. 
	aTileDistribution forMoonWalk: 0.10.
	aTileDistribution forHyperJump:0.08.
	aTileDistribution forAtomicBomb: 0.02.
	
	aGameSetUp withSpecialTiles: (aTileDistribution build).
	
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.

	self assert: (aBoard percentageOf: AtomicBomb) equals: 2
]
