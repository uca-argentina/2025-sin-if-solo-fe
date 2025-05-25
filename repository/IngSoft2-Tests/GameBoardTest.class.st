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
GameBoardTest >> test010WhenASpaceShipFallsInAWormHoleWhichExitIsTheFinishLineThenWins [

	self
		should: [
		BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 6 ]
		raise: Error
		withMessageText:
		'The worm hole exit must be smaller than the number of squares'
]

{ #category : 'tests' }
GameBoardTest >> test011WhenABoardWithAWormHoleInANegativePositionThenCreationFails [

	self
		should: [
		BoardGame withNumberOfSquares: 6 withWormHoleFrom: -1 to: 6 ]
		raise: Error
		withMessageText: 'Should be a positive number'
]

{ #category : 'tests' }
GameBoardTest >> test012WhenABoardWithNumberOfSquaresIsNegativeThenCreationFails [

	self
		should: [
		BoardGame withNumberOfSquares: -1 withWormHoleFrom: 3 to: 6 ]
		raise: Error
		withMessageText: 'Should be a positive number'
]

{ #category : 'tests' }
GameBoardTest >> test013WhenABoardHasLessThanThreeSquaresThenCreationFails [

	self
		should: [
		BoardGame withNumberOfSquares: 2 withWormHoleFrom: 3 to: 6 ]
		raise: Error
		withMessageText: 'Should have at least 3 squares'
]

{ #category : 'tests' }
GameBoardTest >> test014WhenSpaceshipTriesToMoveOutsideBoardThenNothingChanges [

	| aBoard aPlayer1 aDice aPlayer2  aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 1 to: 1.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 1. 1. 6 }.

	aBoard has: {
			aPlayer1.
			aPlayer2 }.
	aBoard withDices: { aDice }.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	aPlayer1 movesTo: 4.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2
]

{ #category : 'tests' }
GameBoardTest >> test0WhenTheBoardIsInitializeItHasACertainNumberOfSquaresAndAWormHole [

	| aBoard aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 64 withWormHoleFrom: 1 to: 2.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard follows: aWinnerSystem .
	self assert: aBoard numberOfSquares equals: 64
]

{ #category : 'tests' }
GameBoardTest >> test15WhenTheSpaceShipGetsToTheMaximumOfSquaresThenSpaceShipGoesToInitialPosition [

	| aBoard aPlayer1 aDice aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 5.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 3. 3. 4 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aBoard has: { aPlayer1 }.
	aBoard withDices: { aDice }.
	aWinnerSystem := WinnerSystem withMaximunLaps: 2.
	aBoard follows: aWinnerSystem.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 1
]

{ #category : 'tests' }
GameBoardTest >> test16WhenTheExitOfTheWormHoleIsGreaterThanTheNumbersOfSqueareOfTheBoardThenBoardCreationFails [

	self
		should: [
		BoardGame withNumberOfSquares: 10 withWormHoleFrom: 6 to: 12 ]
		raise: Error
		withMessageText:
		'The worm hole exit must be smaller than the number of squares'
]

{ #category : 'tests' }
GameBoardTest >> test17WhenSpaceShipDoesMultipleLapsInOneRollThenWins [

	| aBoard aPlayer1 aDice aWinnerSystem |
	aWinnerSystem := WinnerSystem withMaximunLaps: 2.
	aBoard := BoardGame withNumberOfSquares: 5 withWormHoleFrom: 1 to: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 12. 3. 3. 4 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aBoard has: { aPlayer1 }.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1
]

{ #category : 'tests' }
GameBoardTest >> test18WhenASpaceShipWinsTheGameThenTheBoardKnowsTheLapsCompleted [

	| aBoard aPlayer1 aDice aPlayer2 aPlayer3 aWinnerSystem |
	aWinnerSystem := WinnerSystem withMaximunLaps: 2.
	aBoard := BoardGame withNumberOfSquares: 5 withWormHoleFrom: 1 to: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 3. 7 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aPlayer3 := SpaceShip inInitialPosition: 0.
	
	aBoard has: { aPlayer1.aPlayer2.aPlayer3}.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem.
	aBoard playOneRound.
	aBoard playOneRound.
	
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: (aBoard completedLapsBy: aPlayer1 )equals: 2.
	self assert: (aBoard completedLapsBy: aPlayer2 )equals: 0.
	self assert: (aBoard completedLapsBy: aPlayer3 )equals: 0.
]

{ #category : 'tests' }
GameBoardTest >> test19WhenTheGameEndsThenThereIsARanking [

	| aBoard aPlayer1 aDice  aPlayer2 aPlayer3 aPlayer4 aWinnerSystem|
	aWinnerSystem := WinnerSystem withMaximunLaps: 2.
	aBoard := BoardGame withNumberOfSquares: 5 withWormHoleFrom: 1 to: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 5. 3. 4. 1. 7 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aPlayer3 := SpaceShip inInitialPosition: 0.
	aPlayer4 := SpaceShip inInitialPosition: 0.
	
	aBoard has: { aPlayer1.aPlayer2.aPlayer3.aPlayer4}.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.
	aBoard playOneRound.
	
	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1 .
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer3 .
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer2 .
	
]

{ #category : 'tests' }
GameBoardTest >> test1WhenTheGameBeginsTheBoardKnowsTheSpaceShipsInitialPosition [

	| aPlayer1 aBoard|
	aPlayer1 := SpaceShip inInitialPosition: 0.
	aBoard := BoardGame withNumberOfSquares: 60 withWormHoleFrom: 2 to: 5.

	self assert: aPlayer1 currentPosition equals: 0
]

{ #category : 'tests' }
GameBoardTest >> test20WhenASpaceShipFinallyPositionIsLessThanOtherSpaceShipButCompletedTheMaximumLapsThenIsTheWinner [

	| aBoard aPlayer1 aDice  aPlayer2 aPlayer3 aPlayer4 aWinnerSystem|
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard := BoardGame withNumberOfSquares: 5 withWormHoleFrom: 1 to: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 3. 8. 1. 7 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aPlayer3 := SpaceShip inInitialPosition: 0.
	aPlayer4 := SpaceShip inInitialPosition: 0.
	
	aBoard has: { aPlayer1.aPlayer2.aPlayer3.aPlayer4}.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.
	
	self assert: (aBoard positionOf: aPlayer3 ) equals: 3.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer3 .
	self assert: aWinnerSystem theSilverWinnerIs equals: aPlayer2 .
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer1 .

]

{ #category : 'tests' }
GameBoardTest >> test21Banana [

	| aBoard aPlayer1 aDice  aPlayer2 aPlayer3 aPlayer4 aWinnerSystem|
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard := BoardGame withNumberOfSquares: 5 withWormHoleFrom: 1 to: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 3. 6. 1. 7 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aPlayer3 := SpaceShip inInitialPosition: 0.
	aPlayer4 := SpaceShip inInitialPosition: 0.
	
	aBoard has: { aPlayer1.aPlayer2.aPlayer3.aPlayer4}.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.
	
	self assert: (aBoard positionOf: aPlayer3 ) equals: 1.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer3 .
	self deny: aWinnerSystem theSilverWinnerIs equals: aPlayer2 .
	self deny: aWinnerSystem theSilverWinnerIs equals: aPlayer1 .
	"
	self assert: aWinnerSystem theSilverWinnerIs equals:aPlayer1.
	self assert: aWinnerSystem theBronzeWinnerIs equals: aPlayer2 .
	"
]

{ #category : 'tests' }
GameBoardTest >> test2WhenADiceIsRolledThenTheSpaceShipsPositionInTheBoardChanges [

	| aBoard aPlayer1 aDice aWinnerSystem |
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard := BoardGame withNumberOfSquares: 64 withWormHoleFrom: 2 to: 5.
	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 3. 3. 3. 4 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aBoard has: { aPlayer1 }.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 3
]

{ #category : 'tests' }
GameBoardTest >> test3WhenASpaceShipCompletesTheLapThenItsTheWinner [

	| aBoard aPlayer1 aDice aWinnerSystem |
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 5.
	aPlayer1 := SpaceShip inInitialPosition: 0.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.


	aBoard has: { aPlayer1 }.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.


	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer1.
	self assert: (aBoard positionOf: aPlayer1) equals: 6
]

{ #category : 'tests' }
GameBoardTest >> test4WhenTheFirstSpaceShipCompletesTheLapThenItsTheWinner [

	| aBoard aPlayer1 aDice aPlayer2 aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 5.
	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 4. 6. 3. 4 }.

	aBoard has: {
			aPlayer1.
			aPlayer2 }.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .

	aBoard playOneRound.

	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2.
	self assert: (aBoard positionOf: aPlayer2) equals: 6
]

{ #category : 'tests' }
GameBoardTest >> test5WhenSpaceshipRolledNumberExceedsRemainingDistanceToFinishLineAndCompletesTheLapThenItWins [

	| aBoard aPlayer1 aDice aPlayer2 aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 3 to: 5.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 4. 8. 3. 4 }.

	aBoard has: {
			aPlayer1.
			aPlayer2 }.
	aBoard withDices: { aDice }.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.


	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2.
	self assert: (aBoard positionOf: aPlayer2) equals: 2
]

{ #category : 'tests' }
GameBoardTest >> test6WhenThereIsAWinnerThenNoMoreRoundsArePlayed [
| aBoard aPlayer1 aDice  aPlayer2 aWinnerSystem |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 3 to:5.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aDice := RiggedDice withNumberOfFaces: 10.
  	aDice setNumbersProvider: { 4. 8. 3. 4 }.
	 
	aBoard has: { aPlayer1 . aPlayer2 }.
	aBoard withDices: { aDice }.
	
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.
	aBoard playOneRound.
	aBoard playOneRound. 
	self assert: (aBoard positionOf: aPlayer1 ) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: aWinnerSystem theGoldWinnerIs equals: aPlayer2.
]

{ #category : 'tests' }
GameBoardTest >> test8WhenTheSpaceShipFallsIntoTheWormHoleEntranceThenItMovesToTheWormHoleExit [

	| aBoard aPlayer1 aDice aPlayer2 aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 5.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 2. 3. 3. 4 }.
	aBoard has: {
			aPlayer1.
			aPlayer2 }.
	aBoard withDices: { aDice }.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard follows: aWinnerSystem .
	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 5
]

{ #category : 'tests' }
GameBoardTest >> test9WhenTheSpaceShipFallsIntoWormHoleExitThenItMovesToTheWormHoleEntrance [

	| aBoard aPlayer1 aDice aPlayer2 aWinnerSystem |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 5.
 
	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 3. 3. 4 }.
	aBoard has: {
			aPlayer1.
			aPlayer2 }.
	aBoard withDices: { aDice }.
	aWinnerSystem := WinnerSystem withMaximunLaps: 1.
	aBoard follows: aWinnerSystem .


	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 2
]
