Class {
	#name : 'SpaceShipMovementsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipMovementsTest >> test0WhenTheGamesBeginsThenTheSpaceShipIsInTheInitialPosition [

|aPlayer1|
aPlayer1:=SpaceShip inInitialPosition: 0.

self assert:aPlayer1 currentPosition equals: 0.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test1WhenTheDiceIsRolledThenTheSpaceShipsPositionChangesToTheRolledNumber [

 | aPlayer1 aDice aDiceNumberProvider |
   aDice := Dice withNumberOfFaces: 6.
   aDiceNumberProvider := SetRolledNumber of: aDice as:3.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aPlayer1 rolls: {aDice}.
	
	self assert:aPlayer1 currentPosition equals: 3.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test2WhenMultipleDicesAreRolledThenSpaceShipMovesTheSumRolled [

 | aPlayer1 aDice aDiceNumberProvider aDice2|
   aDice := Dice withNumberOfFaces: 6.
   aDiceNumberProvider := SetRolledNumber of: aDice as:3.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).

	aDice2 := Dice withNumberOfFaces: 3.
   aDiceNumberProvider := SetRolledNumber of: aDice2 as:1.

	aDice2 rollWith: (aDiceNumberProvider rolledNumber ).
	aPlayer1:=SpaceShip inInitialPosition: 0.
	
	aPlayer1 rolls: {aDice.aDice2}.
	
	self assert:aPlayer1 currentPosition equals: 4.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test3WhenThereAreMultipleDicesthenAllSpaceshipsUseAllOfThemToAdvance [

 | aPlayer1 aPlayer2 aDice aDiceNumberProvider aDice2|
   aDice := Dice withNumberOfFaces: 6.
	aDice2 := Dice withNumberOfFaces: 3.
	
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aDiceNumberProvider := SetRolledNumber of: aDice as:3.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
   
	aDiceNumberProvider:= SetRolledNumber of: aDice2 as:1.
	aDice2 rollWith: (aDiceNumberProvider rolledNumber ).
	
	aPlayer1 rolls: {aDice.aDice2}.
	
	aPlayer2:=SpaceShip inInitialPosition: 0.
	aDiceNumberProvider := SetRolledNumber of: aDice as:4.
	aDice rollWith: (aDiceNumberProvider rolledNumber ).
	
	aDiceNumberProvider := SetRolledNumber of: aDice2 as:3.
	aDice2 rollWith: (aDiceNumberProvider rolledNumber ).
	
	aPlayer2 rolls: {aDice.aDice2}.
	
	
	self assert:aPlayer1 currentPosition equals: 4.
	self assert:aPlayer2 currentPosition equals: 7. 	

]
