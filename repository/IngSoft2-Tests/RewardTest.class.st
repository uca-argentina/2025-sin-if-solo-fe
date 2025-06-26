Class {
	#name : 'RewardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RewardTest >> test1FromASampleOfAnAmountOfRolledDicesThereAreAProbabilityOfHavingARewardOrNot [

	| rewardDistribution results probabilitySampling |
	probabilitySampling := 1500.
	rewardDistribution := RewardDistribution new.
	rewardDistribution forRestartFuel: 0.8.
	rewardDistribution forDecreaseFuel: 0.2.



	results := rewardDistribution buidFor: probabilitySampling.
	self assert: ((rewardDistribution percentageOf: RestartFuelReward)
			 between: 0.78
			 and: 0.81).
	self assert: ((rewardDistribution percentageOf: DecreaseFuelReward)
			 between: 0.19
			 and: 0.21)
]

{ #category : 'tests' }
RewardTest >> test2WhenTheProbabilityOfNoRewardIsAtItMaximumThenWhenRolledMaximumNumberNoReward [

	| rewardDistribution aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	rewardDistribution := RewardDistribution new.
	rewardDistribution forRestartFuel: 0.
	rewardDistribution forDecreaseFuel: 0.


	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withARewardDistribution: rewardDistribution.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 6
]

{ #category : 'tests' }
RewardTest >> test3WhenTheProbabilityOfDecreaseFuleIsAtItMaximumThenWhenRolledMaximumNumberTheFuleDecreces [

	| rewardDistribution aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	rewardDistribution := RewardDistribution new.
	rewardDistribution forRestartFuel: 0.
	rewardDistribution forDecreaseFuel: 1.


	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withARewardDistribution: rewardDistribution.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 5
]

{ #category : 'tests' }
RewardTest >> test4WhenTheProbabilityOfDecreaseFuleAffectsTheSpceShipAndLosesAllFuleLosesTwoRounds [

	| rewardDistribution aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	rewardDistribution := RewardDistribution new.
	rewardDistribution forRestartFuel: 0.
	rewardDistribution forDecreaseFuel: 1.


	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 6. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withARewardDistribution: rewardDistribution.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 5.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0
]

{ #category : 'tests' }
RewardTest >> test5WhenTheProbabilityOfRestartFuelIsAtItMaximumThenWhenRolledMaximumNumberTheFuleStaysMaximumAlways [

	| rewardDistribution aGameSetUp aDice aBoard aPlayer1 aWinnerSystem aTurnManager |
	rewardDistribution := RewardDistribution new.
	rewardDistribution forRestartFuel: 1.
	rewardDistribution forDecreaseFuel: 0.


	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 6. 6. 6 }.

	aPlayer1 := SpaceShip named: 'Juan'.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.
	aGameSetUp withARewardDistribution: rewardDistribution.
	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.



	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12.
	aBoard playNextTurn.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 12
]
