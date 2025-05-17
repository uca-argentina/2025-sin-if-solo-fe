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
| aBoard aPlayer1 aDice  aPlayer2 |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to:6.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aDice := RiggedDice withNumberOfFaces: 10.
  aDice setNumbersProvider: { 2. 3. 3. 4 }.
	aBoard has: { aPlayer1 . aPlayer2 }.
	aBoard withDices: { aDice }.

	aBoard playTurn.

	self assert: (aPlayer1 currentPosition) equals: 6.
	self assert: (aBoard theWinnerIs) equals: aPlayer1.

]

{ #category : 'tests' }
GameBoardTest >> test011WhenABoardWithAWormHoleInANegativePositionThenCreationFails [

	
	self should: [BoardGame withNumberOfSquares: 6 withWormHoleFrom: -1 to:6] raise:Error withMessageText:'Should be a positive number'.
	
]

{ #category : 'tests' }
GameBoardTest >> test012WhenABoardWithNumberOfSquaresIsNegativeThenCreationFails [

	
	self should: [BoardGame withNumberOfSquares: -1 withWormHoleFrom: 3 to:6] raise:Error withMessageText:'Should be a positive number'.
	
]

{ #category : 'tests' }
GameBoardTest >> test013WhenABoardHasLessThanThreeSquaresThenCreationFails [

	
	self should: [BoardGame withNumberOfSquares: 2 withWormHoleFrom: 3 to:6] raise:Error withMessageText:'Should have at least 3 squares'.
	
]

{ #category : 'tests' }
GameBoardTest >> test0WhenTheBoardIsInitializeItHasACertainNumberOfSquaresAndAWormHole [

| aBoard |
aBoard:= BoardGame withNumberOfSquares: 64 withWormHoleFrom: 1 to:2.

self assert: aBoard numberOfSquares equals: 64
]

{ #category : 'tests' }
GameBoardTest >> test1WhenTheGameBeginsTheBoardKnowsTheSpaceShipsInitialPosition [
| aPlayer1 aBoard |

	aPlayer1:=SpaceShip inInitialPosition: 0.
	aBoard:= BoardGame withNumberOfSquares: 60 withWormHoleFrom: 2 to:5.
	
self assert: (aPlayer1 currentPosition) equals: 0.
]

{ #category : 'tests' }
GameBoardTest >> test2WhenADiceIsRolledThenTheSpaceShipsPositionInTheBoardChanges [
| aBoard aPlayer1 aDice  |
	
	aBoard:= BoardGame withNumberOfSquares: 64 withWormHoleFrom: 2 to:5.
   aDice := RiggedDice withNumberOfFaces: 6.
   aDice setNumbersProvider: { 3. 3. 3. 4 }.

	aPlayer1:=SpaceShip inInitialPosition: 0.
	aBoard has:{aPlayer1 }.
	aBoard withDices: {aDice}.

	aBoard playTurn.
self assert: (aPlayer1 currentPosition) equals: 3.
]

{ #category : 'tests' }
GameBoardTest >> test3WhenASpaceShipGetsToTheFinishLineThenItsWinner [
| aBoard aPlayer1 aDice  |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
  	aPlayer1:=SpaceShip inInitialPosition: 0.

   aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	
	aBoard has: { aPlayer1 }.	
	aBoard withDices: { aDice }.
	aBoard playTurn .
	
	 
	self assert: aBoard theWinnerIs equals: aPlayer1.
	self assert: (aPlayer1 currentPosition) equals: 6.

]

{ #category : 'tests' }
GameBoardTest >> test4WhenTheFirstSpaceShipGetsToTheFinishLineThenItsTheWinner [

	| aBoard aPlayer1 aDice aPlayer2 |
	aBoard := BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to: 5.
	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.
				
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 4. 6. 3. 4 }.
	
	aBoard has: {
			aPlayer1.
			aPlayer2 }.
	aBoard withDices: { aDice }.
	aBoard playTurn.

	self assert: aBoard theWinnerIs equals: aPlayer2.
	self assert: (aPlayer2 currentPosition) equals: 6
]

{ #category : 'tests' }
GameBoardTest >> test5WhenSpaceshipRolledNumberExceedsRemainingDistanceToFinishLineThenItWins [
| aBoard aPlayer1 aDice  aPlayer2 |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.
	aDice := RiggedDice withNumberOfFaces: 10.	
	aDice setNumbersProvider: { 4. 8. 3. 4 }.
	
	aBoard has: { aPlayer1 . aPlayer2 }.
	aBoard withDices: { aDice }.

	aBoard playTurn.
	

self assert: (aBoard theWinnerIs) equals: aPlayer2.
self assert: (aPlayer2 currentPosition) equals: 8.

]

{ #category : 'tests' }
GameBoardTest >> test6WhenASpaceShipCrossesFinishLineThenNoMoreTurnsArePlayed [
| aBoard aPlayer1 aDice  aPlayer2 |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aDice := RiggedDice withNumberOfFaces: 10.
  aDice setNumbersProvider: { 4. 8. 3. 4 }.
	
	aBoard has: { aPlayer1 . aPlayer2 }.
	aBoard withDices: { aDice }.

	aBoard playTurn.
	
	self assert: (aPlayer1 currentPosition ) equals: 4.
	self assert: (aPlayer2 currentPosition) equals: 8.
]

{ #category : 'tests' }
GameBoardTest >> test8WhenTheSpaceShipFallsIntoTheWormHoleEntranceThenItMovesToTheWormHoleExit [ 
| aBoard aPlayer1 aDice  aPlayer2 |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aDice := RiggedDice withNumberOfFaces: 10.
  aDice setNumbersProvider: { 2. 3. 3. 4 }.
	aBoard has: { aPlayer1 . aPlayer2 }.
	aBoard withDices: { aDice }.
	
	aBoard playTurn .
	
	self assert: (aPlayer1 currentPosition) equals: 5.
]

{ #category : 'tests' }
GameBoardTest >> test9WhenTheSpaceShipFallsIntoWormHoleExitThenItMovesToTheWormHoleEntrance [
| aBoard aPlayer1 aDice  aPlayer2 |
	
	aBoard:= BoardGame withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aDice := RiggedDice withNumberOfFaces: 10.
   aDice setNumbersProvider: { 5. 3. 3. 4 }.
	aBoard has: { aPlayer1 . aPlayer2 }.
	aBoard withDices: { aDice }.


	aBoard playTurn.
	
	self assert: (aPlayer1 currentPosition) equals: 2.

]
