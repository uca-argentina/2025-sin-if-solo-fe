Class {
	#name : 'DistributionOfTilesTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DistributionOfTilesTest >> test1WhenABoardIsCreatedThen2PercentOfSquaresAreAtomicBomb [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 2. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.


	 aGameSetUp withAdistribution.


    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
	

	self assert: (aBoard percentageOf: AtomicBomb)equals:2.
	
	



   
]

{ #category : 'tests' }
DistributionOfTilesTest >> test2WhenABoardIsCreatedThen8PercentOfSquaresAreHyperJump [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 2. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

	 aGameSetUp withAdistribution.


    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
	

	self assert: (aBoard percentageOf: HyperJump )equals:8.
	
	



   
]

{ #category : 'tests' }
DistributionOfTilesTest >> test3WhenABoardIsCreatedThen10PercentOfSquaresAreMoonWalk [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 2. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

	 aGameSetUp withAdistribution.


    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
	

	self assert: (aBoard percentageOf: MoonWalk )equals:10.
	
	



   
]

{ #category : 'tests' }
DistributionOfTilesTest >> test4WhenABoardIsCreatedThen20PercentOfSquaresAreHyperGravity [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 2. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

	 aGameSetUp withAdistribution.


    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
	

	self assert: (aBoard percentageOf: HyperGravity )equals:20.
	
	



   
]

{ #category : 'tests' }
DistributionOfTilesTest >> test5WhenABoardIsCreatedThen20PercentOfSquaresAreBlackHole [


    | aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
    aGameSetUp := GameSetup new.
    aGameSetUp withNumberOfPlayers: 2.

    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 2. 5. 9 } andNumberOfFaces: 10.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to: 1.

	 aGameSetUp withAdistribution.


    aGameSetUp withMaximumLapsToWin: 100.
    aGameSetUp createGameInstance.

    aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.

    aBoard := aGameSetUp board.
    aWinnerSystem := aGameSetUp winnerSystem.
    aBoard playOneRound.
	
	self assert: (aBoard percentageOf: BlackHole )equals:20.
	
	



   
]
