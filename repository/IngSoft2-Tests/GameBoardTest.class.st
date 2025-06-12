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
| aGameSetUp | 
	 
	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:4.
			
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  { 3. 3. 6. 1. 7 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:2 to: 6.
	aGameSetUp withMaximumLapsToWin: 1. 


	self
		should: [
			aGameSetUp createGameInstance.]
		raise: Error
		withMessageText:
		'The worm hole exit must be smaller than the number of squares'
]

{ #category : 'tests' }
GameBoardTest >> test011WhenABoardWithAWormHoleInANegativePositionThenCreationFails [
	|aGameSetUp  |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:3.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 7 } andNumberOfFaces: 8.}.
	
	
	
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:-1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	  
	


	self
		should: [ aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Should be a positive number'
]

{ #category : 'tests' }
GameBoardTest >> test012WhenABoardWithNumberOfSquaresIsNegativeThenCreationFails [

	|aGameSetUp  |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:3.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 7 } andNumberOfFaces: 8.}.
	
	aGameSetUp withABoardNumberOfSquares: -1 andWithWormHoleFrom:-1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	
	self
		should: [
		aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Should be a positive number'
]

{ #category : 'tests' }
GameBoardTest >> test013WhenABoardHasLessThanThreeSquaresThenCreationFails [
	|aGameSetUp  |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:3. 
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 7 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 2 andWithWormHoleFrom:3 to: 6.
	aGameSetUp withMaximumLapsToWin: 2. 
	
	self
		should: [
		aGameSetUp createGameInstance ]
		raise: Error
		withMessageText: 'Should have at least 3 squares'
]

{ #category : 'tests' }
GameBoardTest >> test014WhenSpaceshipTriesToMoveOutsideBoardThenNothingChanges [

	|aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:2.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 1. 1. 6 } andNumberOfFaces: 10.}.
	
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	aGameSetUp createGameInstance. 
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem. 
	
	
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	aPlayer1 moveTo: 4 consuming:1000.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test015WhenTheSpaceShipGetsToTheMaximumOfSquaresThenSpaceShipGoesToInitialPosition [

 
	|aGameSetUp aBoard aPlayer1  |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:1. 
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {7. 3. 3. 4 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	aGameSetUp createGameInstance. 
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aBoard := aGameSetUp board.
	
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 1
]

{ #category : 'tests' }
GameBoardTest >> test016WhenTheExitOfTheWormHoleIsGreaterThanTheNumbersOfSqueareOfTheBoardThenBoardCreationFails [
	|aGameSetUp  |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:3.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 7 } andNumberOfFaces: 8.}.
	
	aGameSetUp withABoardNumberOfSquares: 10 andWithWormHoleFrom:6 to: 12.
	aGameSetUp withMaximumLapsToWin: 2.  
	
	self
		should: [
		aGameSetUp createGameInstance ]
		raise: Error
		withMessageText:
		'The worm hole exit must be smaller than the number of squares'
]

{ #category : 'tests' }
GameBoardTest >> test017WhenSpaceShipDoesMultipleLapsInOneRollThenWins [
|aGameSetUp aBoard aPlayer1 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:1 .
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {12. 3. 3. 4 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	aGameSetUp createGameInstance.
	
	aPlayer1:=(aGameSetUp spaceShips) first.

	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	

	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1
]

{ #category : 'tests' }
GameBoardTest >> test018WhenASpaceShipWinsTheGameThenTheBoardKnowsTheLapsCompleted [

	|aGameSetUp aBoard aPlayer1  aPlayer2 aPlayer3 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:3. 
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 7 } andNumberOfFaces: 8.}.

	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	aGameSetUp createGameInstance.
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	aPlayer3:=(aGameSetUp spaceShips) third.
	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	
	aBoard playOneRound.
	aBoard playOneRound.
	
	
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: (aBoard completedLapsBy: aPlayer1 )equals: 2.
	self assert: (aBoard completedLapsBy: aPlayer2 )equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer3 )equals: 0.
]

{ #category : 'tests' }
GameBoardTest >> test019WhenTheGameEndsThenThereIsARanking [

	
	|aGameSetUp aBoard aPlayer1  aPlayer2 aPlayer3 aPlayer4 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:4. 
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 4. 1 . 7 } andNumberOfFaces: 8.}.
	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 2. 
	aGameSetUp createGameInstance.
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	aPlayer3:=(aGameSetUp spaceShips) third.
	aPlayer4:=(aGameSetUp spaceShips) fourth.
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	
	
	
	
	aBoard playOneRound.
	aBoard playOneRound.
	
	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1 .
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer3 .
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer2 .
	
]

{ #category : 'tests' }
GameBoardTest >> test020WhenASpaceShipFinallyPositionIsLessThanOtherSpaceShipButCompletedTheMaximumLapsThenIsTheWinner [


	 
		|aGameSetUp aBoard aPlayer1  aPlayer2 aPlayer3 aPlayer4 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:4. 
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {1. 3. 8. 1 . 7 } andNumberOfFaces: 8.}.
	
	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 1. 
	aGameSetUp createGameInstance.
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	aPlayer3:=(aGameSetUp spaceShips) third.
	aPlayer4:=(aGameSetUp spaceShips) fourth.
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	

	aBoard playOneRound.
	
	
	
	self assert: (aBoard positionOf: aPlayer3 ) equals: 3.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer3 .
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer2 .
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer1 .

]

{ #category : 'tests' }
GameBoardTest >> test021WhenThereIsADrawForSecondPlaceThenTheSilverIsTheFirstPlayerToMove [
 
	
		|aGameSetUp aBoard aPlayer1  aPlayer2 aPlayer3 aWinnerSystem |

	aGameSetUp:= GameSetup new.
	aGameSetUp withNumberOfPlayers:3. 
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {3. 3. 6. 1. 7 } andNumberOfFaces: 8.}.

	aGameSetUp withABoardNumberOfSquares: 5 andWithWormHoleFrom:1 to: 1.
	aGameSetUp withMaximumLapsToWin: 1. 
	aGameSetUp createGameInstance.
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aPlayer2:=(aGameSetUp spaceShips) second.
	aPlayer3:=(aGameSetUp spaceShips) third.
	
	aBoard:= (aGameSetUp board).
	aWinnerSystem:= aGameSetUp winnerSystem.
	
	
	
	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer3) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 3.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	
	self assert: (aBoard completedLapsBy: aPlayer3) equals: 1.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer1) equals: 0.
	
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer3.
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer1. 	
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer2.
	
]

{ #category : 'tests' }
GameBoardTest >> test0WhenTheBoardIsInitializeItHasACertainNumberOfSquaresAndAWormHole [
 
| aBoard aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 64 withSizeInParsec:10 withWormHoleFrom: 1 to: 2.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1. 
	aBoard follows: aWinnerSystem .
	self assert: aBoard numberOfSquares equals: 64
]

{ #category : 'tests' }
GameBoardTest >> test1WhenTheGameBeginsTheBoardKnowsTheSpaceShipsInitialPosition [

	| aPlayer1 aBoard|
	aPlayer1 := SpaceShip inInitialPosition: 0.
	aBoard := BoardGame withNumberOfSquares: 60 withSizeInParsec:10 withWormHoleFrom: 2 to: 5.


	self assert: aPlayer1 currentPosition equals: 0
]

{ #category : 'tests' }
GameBoardTest >> test2WhenADiceIsRolledThenTheSpaceShipsPositionInTheBoardChanges [

	| aGameSetUp aBoard aPlayer1 |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1. 
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {3. 1.} andNumberOfFaces: 6.}.
	aGameSetUp withABoardNumberOfSquares: 64 andWithWormHoleFrom: 1 to: 1.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.


	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
		aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
		aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
			aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 8.
		aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 11.
	
]

{ #category : 'tests' }
GameBoardTest >> test3WhenASpaceShipCompletesTheLapThenItsTheWinner [

	| aGameSetUp aBoard aPlayer1 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 1.
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {6. 3. 3. 4 } andNumberOfFaces: 6.}.
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first. 
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playOneRound.


	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: (aBoard positionOf: aPlayer1) equals: 6
]

{ #category : 'tests' }
GameBoardTest >> test4WhenTheFirstSpaceShipCompletesTheLapThenItsTheWinner [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	
		
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 3. 3. 4 } andNumberOfFaces: 6.
			 aGameSetUp withRiggedDiceNumbers:  {2. 3. 3. 4 } andNumberOfFaces: 6.
    }.

	
	aGameSetUp withNumberOfPlayers: 2.
	
	
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.



	aBoard playOneRound.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2.
	self assert: (aBoard positionOf: aPlayer2) equals: 6
]

{ #category : 'tests' }
GameBoardTest >> test5WhenSpaceshipRolledNumberExceedsRemainingDistanceToFinishLineAndCompletesTheLapThenItWins [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {4. 8. 3. 4 } andNumberOfFaces: 6.}.
	
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 3 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	aBoard playOneRound.


	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2.
	self assert: (aBoard positionOf: aPlayer2) equals: 2
]

{ #category : 'tests' }
GameBoardTest >> test6WhenThereIsAWinnerThenNoMoreRoundsArePlayed [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {4. 8. 3. 4 } andNumberOfFaces: 6.}.

	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 3 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playOneRound.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test8WhenTheSpaceShipFallsIntoTheWormHoleEntranceThenItMovesToTheWormHoleExit [

	| aGameSetUp aBoard aPlayer1 aPlayer2 aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.
	
	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {2. 3. 3. 4 } andNumberOfFaces: 10.}.

	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 5
]

{ #category : 'tests' }
GameBoardTest >> test9WhenTheSpaceShipFallsIntoWormHoleExitThenItMovesToTheWormHoleEntrance [

| aGameSetUp aBoard aPlayer1  aWinnerSystem |
	aGameSetUp := GameSetup new.
	aGameSetUp withNumberOfPlayers: 2.

	aGameSetUp withRiggedDiceConfigs: {
        aGameSetUp withRiggedDiceNumbers:  {5. 3. 3. 4 } andNumberOfFaces: 10.}.
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	aGameSetUp createGameInstance.

	aPlayer1:= aGameSetUp spaceShips first.

	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	

	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 2
]
