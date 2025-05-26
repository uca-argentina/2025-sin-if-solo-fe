Class {
	#name : 'FuleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FuleTest >> test0WhenASpaceShipDoesntMoveThenItHasInitialFuel [
| aGameSetUp aPlayer1|

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {7. 3. 3. 4 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	self assert: (aPlayer1 currentFule ) equals: 16.
]

{ #category : 'tests' }
FuleTest >> test1WhenASpaceShipDoesntMoveThenItHasTheDoubleOfTheMaximumRolledNumberFuel [
| aGameSetUp aPlayer1|

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {7. 3. 3. 3 } andNumberOfFaces: 8.
			aGameSetUp withRiggedDiceNumbers:  {1. 2. 3. 4 } andNumberOfFaces: 4.}.
			
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	self assert: (aPlayer1 currentFule ) equals: 24.
]

{ #category : 'tests' }
FuleTest >> test2WhenASpaceShipMovesThenFuelDecreasesByTheAmountMoved [
| aGameSetUp aPlayer1 aBoard |

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {7. 3. 3. 3 } andNumberOfFaces: 8.
			aGameSetUp withRiggedDiceNumbers:  {1. 2. 3. 4 } andNumberOfFaces: 4.}.
			
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 10.
	aGameSetUp createGameInstance .
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aBoard:=(aGameSetUp board).
	aBoard playOneRound.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 16.
]

{ #category : 'tests' }
FuleTest >> test3WhenASpaceShipDoesntHaveAnyFuleLeftThenItGoesBackToTheInitialPosition [
| aGameSetUp aPlayer1 aBoard |

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {8. 7. 2} andNumberOfFaces: 8.
			aGameSetUp withRiggedDiceNumbers:  {2. 3. 2} andNumberOfFaces: 4.}.
			
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 6.
	
	aGameSetUp createGameInstance .
	
	
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aBoard:=(aGameSetUp board).
	aBoard playOneRound.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 0.
]

{ #category : 'tests' }
FuleTest >> test4WhenSpaceShipDoesntHaveFuleThenLosesTwoTurnsAndThenItCanMoveAgainWithTheirMaximumFule [

	| aGameSetUp aPlayer1 aBoard |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 1.
	aGameSetUp withRiggedDiceConfigs: {
			(aGameSetUp
				 withRiggedDiceNumbers: { 8. 7. 2. 8. 7. 2 }
				 andNumberOfFaces: 8).
			(aGameSetUp
				 withRiggedDiceNumbers: { 2. 3. 2. 2. 3. 2 }
				 andNumberOfFaces: 4) }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 6.

	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 14
]

{ #category : 'tests' }
FuleTest >> test5WhenMoreThanOneSpaceShipDoesntHaveFuleThenBothCantMoveForTwoTurns [
| aGameSetUp aPlayer1 aPlayer2 aBoard |


    aGameSetUp:= GameSetup new.


    aGameSetUp withNumberOfPlayers:2.
    aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {8. 7. 2. 8. 7. 2. 8. 7. 2. 8. 7. 2} andNumberOfFaces: 8.
        aGameSetUp withRiggedDiceNumbers:  {2. 3. 2. 2. 3. 2. 2. 3. 2. 2. 3. 2} andNumberOfFaces: 4.}.

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom:1 to: 1.
    aGameSetUp withMaximumLapsToWin: 16.

    aGameSetUp createGameInstance .


    aPlayer1:=(aGameSetUp spaceShips) first.
    aPlayer2:=(aGameSetUp spaceShips) second.
    aBoard:=(aGameSetUp board).
    aBoard playOneRound.
    aBoard playOneRound.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 0.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 0.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 0.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 0.
    aBoard playOneRound.
 self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 0.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 0.
  aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1 ) equals: 10.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 14.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 10.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 14.

]

{ #category : 'tests' }
FuleTest >> test6WhenASpaceShipFallsIntoAWormHoleThenTheFuleDecrecesTheAmountMoved [

| aGameSetUp aPlayer1 aBoard |

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {1. 7. 2} andNumberOfFaces: 8.
			aGameSetUp withRiggedDiceNumbers:  {2. 3. 2} andNumberOfFaces: 4.}.
			
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:3 to: 5.
	aGameSetUp withMaximumLapsToWin: 100.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aBoard:=(aGameSetUp board).
	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1 ) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 19.
]
