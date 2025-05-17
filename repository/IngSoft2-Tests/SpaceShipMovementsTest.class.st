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

 | aPlayer1 aDice  |
   aDice := RiggedDice withNumberOfFaces: 6.
  	aDice setNumbersProvider:{1. 2. 3. 4}.
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aPlayer1 rolls: {aDice}.
	
	self assert:aPlayer1 currentPosition equals: 1.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test2WhenMultipleDicesAreRolledThenSpaceShipMovesTheSumRolled [

 | aPlayer1 aDice aDice2|
   aDice := RiggedDice withNumberOfFaces: 6.

	aDice setNumbersProvider:{3. 2. 3. 4}.
	aDice2 := RiggedDice withNumberOfFaces: 3.
	aDice2 setNumbersProvider:{1. 2. 3. 4}.

	aPlayer1:=SpaceShip inInitialPosition: 0.
	
	aPlayer1 rolls: {aDice.aDice2}.
	
	self assert:aPlayer1 currentPosition equals: 4.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test3WhenThereAreMultipleDicesthenAllSpaceshipsUseAllOfThemToAdvance [

	| aPlayer1 aPlayer2 aDice aDice2 |
	aDice := RiggedDice withNumberOfFaces: 6.

	aDice setNumbersProvider: { 3. 3. 3. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 3.
	aDice2 setNumbersProvider: { 1. 2. 3. 4 }.

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.

	aPlayer1 rolls: {
			aDice.
			aDice2 }.
	aPlayer2 rolls: {
			aDice.
			aDice2 }.


	self assert: aPlayer1 currentPosition equals: 4.
	self assert: aPlayer2 currentPosition equals: 5.
]
