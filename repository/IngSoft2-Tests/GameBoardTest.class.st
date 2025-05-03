Class {
	#name : 'GameBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameBoardTest >> test0WhenTheBoardIsInitializeItHasACertainNumberOfSquares [

| aBoard |
aBoard:= Board withNumberOfSquares: 64.

self assert: aBoard numberOfSquares equals: 64
]

{ #category : 'tests' }
GameBoardTest >> test1WhenTheGameBeginsTheBoardKnowsThePlayersInitialPosition [
| aPlayer1 aBoard |

	aPlayer1:=SpaceShip inInitialPosition: 0.
	aBoard:= Board withNumberOfSquares: 60.
	
self assert: (aBoard positionOf: aPlayer1) equals: 0.
]

{ #category : 'tests' }
GameBoardTest >> test2WhenADiceIsRolledThenThePlayersPositionInTheBoardChanges [
| aBoard aPlayer1 aDice aDiceNumberProvider |
	
	aBoard:= Board withNumberOfSquares: 64.
   aDice := Dice withNumberOfFaces: 6.
   aDiceNumberProvider := SetRolledNumber of: aDice as:3.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aPlayer1 rolls: {aDice}.

self assert: (aBoard positionOf: aPlayer1) equals: 3.
]

{ #category : 'tests' }
GameBoardTest >> test3WhenASpaceShipGetsToTheFinishLineThenItsWinner [
| aBoard aPlayer1 aDice aDiceNumberProvider |
	
	aBoard:= Board withNumberOfSquares: 6.
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
  aDice := Dice withNumberOfFaces: 6.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:6.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer1 rolls: {aDice}.
	
	aBoard has: { aPlayer1 }.


self assert: aBoard theWinnerIs equals: aPlayer1.


]

{ #category : 'tests' }
GameBoardTest >> test4WhenTheFirstSpaceShipGetsToTheFinishLineThenItsWinner [
| aBoard aPlayer1 aDice aDiceNumberProvider aPlayer2 |
	
	aBoard:= Board withNumberOfSquares: 6.
  	aPlayer1:=SpaceShip inInitialPosition: 0.	
	aPlayer2:=SpaceShip inInitialPosition: 0.	
  aDice := Dice withNumberOfFaces: 6.
	
   aDiceNumberProvider := SetRolledNumber of: aDice as:4.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer1 rolls: {aDice}.
	
	aDiceNumberProvider := SetRolledNumber of: aDice as:6.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer2 rolls: {aDice}.
	
	aBoard has: { aPlayer1 . aPlayer2 }.


self assert: aBoard theWinnerIs equals: aPlayer2.


]
