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
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:6.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.

   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:2.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move:aPlayer1 with:{aDice}.

	self assert: (aBoard positionOf: aPlayer1 ) equals: 6.
	self assert: (aBoard theWinnerIs) equals: aPlayer1.

]

{ #category : 'tests' }
GameBoardTest >> test011WhenABoardWithAWormHoleInANegativePositionThenCreationFails [

	
	self should: [Board withNumberOfSquares: 6 withWormHoleFrom: -1 to:6] raise:Error withMessageText:'Should be a positive number'.
	
]

{ #category : 'tests' }
GameBoardTest >> test012WhenABoardWithNumberOfSquaresIsNegativeThenCreationFails [

	
	self should: [Board withNumberOfSquares: -1 withWormHoleFrom: 3 to:6] raise:Error withMessageText:'Should be a positive number'.
	
]

{ #category : 'tests' }
GameBoardTest >> test013WhenABoardHasLessThanThreeSquaresThenCreationFails [

	
	self should: [Board withNumberOfSquares: 2 withWormHoleFrom: 3 to:6] raise:Error withMessageText:'Should have at least 3 squares'.
	
]

{ #category : 'tests' }
GameBoardTest >> test0WhenTheBoardIsInitializeItHasACertainNumberOfSquaresAndAWormHole [

| aBoard |
aBoard:= Board withNumberOfSquares: 64 withWormHoleFrom: 1 to:2.

self assert: aBoard numberOfSquares equals: 64
]

{ #category : 'tests' }
GameBoardTest >> test1WhenTheGameBeginsTheBoardKnowsTheSpaceShipsInitialPosition [
| aPlayer1 aBoard |

	aPlayer1:=SpaceShip inInitialPosition: 0.
	aBoard:= Board withNumberOfSquares: 60 withWormHoleFrom: 2 to:5.
	
self assert: (aBoard positionOf: aPlayer1) equals: 0.
]

{ #category : 'tests' }
GameBoardTest >> test2WhenADiceIsRolledThenTheSpaceShipsPositionInTheBoardChanges [
| aBoard aPlayer1 aDice aDiceNumberProvider |
	
	aBoard:= Board withNumberOfSquares: 64 withWormHoleFrom: 2 to:5.
   aDice := RiggedDice withNumberOfFaces: 6.
   aDiceNumberProvider := SetRolledNumber of: aDice as:3.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aBoard has:{aPlayer1 }.
	aBoard withDices: {aDice}.

	aBoard playTurn.
self assert: (aBoard positionOf: aPlayer1) equals: 3.
]

{ #category : 'tests' }
GameBoardTest >> test3WhenASpaceShipGetsToTheFinishLineThenItsWinner [
| aBoard aPlayer1 aDice aDiceNumberProvider |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
  	aPlayer1:=SpaceShip inInitialPosition: 0.

   aDice := RiggedDice withNumberOfFaces: 6.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:6.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	
	aBoard has: { aPlayer1 }.	
	aBoard withDices: { aDice }.
	aBoard playTurn .
	
	 
	self assert: aBoard theWinnerIs equals: aPlayer1.
	self assert: (aBoard positionOf: aPlayer1 ) equals: 6.

]

{ #category : 'tests' }
GameBoardTest >> test4WhenTheFirstSpaceShipGetsToTheFinishLineThenItsTheWinner [
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.
   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:4.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move: aPlayer1 with: {aDice}.
	
	aDiceNumberProvider := SetRolledNumber of: aDice as:6.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move: aPlayer2 with: {aDice}.
	

self assert: (aBoard theWinnerIs) equals: aPlayer2.
self assert: (aBoard positionOf: aPlayer2 ) equals: 6.

]

{ #category : 'tests' }
GameBoardTest >> test5WhenSpaceshipRolledNumberExceedsRemainingDistanceToFinishLineThenItWins [
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.

   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:4.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move:aPlayer1 with:{aDice}.
	
	aDiceNumberProvider := SetRolledNumber of: aDice as:8.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	
	aBoard move:aPlayer2 with:{aDice}.
	

self assert: (aBoard theWinnerIs) equals: aPlayer2.
self assert: (aBoard positionOf: aPlayer2 ) equals: 8.

]

{ #category : 'tests' }
GameBoardTest >> test6WhenASpaceShipCrossesFinishLineThenItCantMoveAgain [
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.

   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:4.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move:aPlayer1 with:{aDice}.
	
	aDiceNumberProvider := SetRolledNumber of: aDice as:8.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	
	aBoard move:aPlayer2 with:{aDice}.
	
	self assert: (aBoard positionOf: aPlayer2 ) equals: 8.
	self
    should: [aBoard move:aPlayer2 with:{aDice}.]
		raise: Error
		withMessageText: 'Game is Over'.

	self assert: (aBoard positionOf: aPlayer2 ) equals: 8.
]

{ #category : 'tests' }
GameBoardTest >> test7WhenTheSpaceShipCrossesTheFinishLineThenTheOtherSpaceShipCantMove [
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.

   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:4.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move:aPlayer1 with:{aDice}.
	
	aDiceNumberProvider := SetRolledNumber of: aDice as:8.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	
	aBoard move:aPlayer2 with:{aDice}.
	
	self assert: (aBoard positionOf: aPlayer2 ) equals: 8.
	self
    should: [aBoard move:aPlayer1 with:{aDice}.]
		raise: Error
		withMessageText: 'Game is Over'.

	self assert: (aBoard positionOf: aPlayer1 ) equals: 4.
]

{ #category : 'tests' }
GameBoardTest >> test8WhenTheSpaceShipFallsIntoTheWormHoleEntranceThenItMovesToTheWormHoleExit [ 
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.

   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:2.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move:aPlayer1 with:{aDice}.
	
	self assert: (aBoard positionOf: aPlayer1 ) equals: 5.
]

{ #category : 'tests' }
GameBoardTest >> test9WhenTheSpaceShipFallsIntoWormHoleExitThenItMovesToTheWormHoleEntrance [
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6 withWormHoleFrom: 2 to:5.
	
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
	aBoard has: { aPlayer1 . aPlayer2 }.

   aDice := RiggedDice withNumberOfFaces: 10.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:5.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aBoard move:aPlayer1 with:{aDice}.
	
	self assert: (aBoard positionOf: aPlayer1 ) equals: 2.

]
