Class {
	#name : 'GameBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameBoardTest >> test1WhenTheBoardIsInitializeItHasACertainNumberOfSquares [

| aBoard |
aBoard:= Board withNumberOfSquares: 64.

self assert: aBoard numberOfSquares equals: 64
]

{ #category : 'tests' }
GameBoardTest >> test2WhenTheGameBeginsTheBoardAnnouncesThePlayerInitialPosition [
| aPlayer1 aBoard |

	aPlayer1:=SpaceShip inInitialPosition: 0.
	aBoard:= Board withNumberOfSquares: 60.
	
self assert: (aBoard positionOf: aPlayer1) equals: 0.
]

{ #category : 'tests' }
GameBoardTest >> test3WhenADiceIsRolledThenThePlayersPositionInTheBoardChanges [
| aBoard aPlayer1 aDice aDiceNumberProvider |
	
	aBoard:= Board withNumberOfSquares: 64.
   aDice := Dice withNumberOfFaces: 6.
   aDiceNumberProvider := SetRolledNumber of: aDice as:3.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aPlayer1 rolls: {aDice}.

self assert: (aBoard positionOf: aPlayer1) equals: 3.
]
