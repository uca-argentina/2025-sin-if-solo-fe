Class {
	#name : 'DeckOfCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DeckOfCardsTest >> test1WhenASpaceShipGetsCreatedThenItGetsAssignedTwoCardsAtRandom [

	| aGameSetUp aDice aBoard aPlayer1 aTurnManager  aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	
	aDeckOfCards:= { AccelerationCard . AccelerationCard } asOrderedCollection.
	aGameSetUp assigns: aDeckOfCards. 

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager:=TurnManager withOrder:{aPlayer1}.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self assert: (aBoard cardsOf: aPlayer1) equals: (OrderedCollection with: AccelerationCard  with: AccelerationCard).
]

{ #category : 'tests' }
DeckOfCardsTest >> test2WhenASpaceShipFallsIntoASpecialCardTileThenItHasOneMoreCard [

	| aGameSetUp aDice aBoard aPlayer1 aTurnManager  aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	
	aDeckOfCards:= { AccelerationCard . AccelerationCard . AccelerationCard} asOrderedCollection.
	aGameSetUp assigns: aDeckOfCards. 

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager:=TurnManager withOrder:{aPlayer1}.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard cardsOf: aPlayer1) equals: (OrderedCollection with: AccelerationCard  with: AccelerationCard with: AccelerationCard).
]

{ #category : 'tests' }
DeckOfCardsTest >> test2WhenBanana [

	| aGameSetUp aDice aBoard aPlayer1 aTurnManager  aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	
	aDeckOfCards:= { AccelerationCard . AccelerationCard } asOrderedCollection.
	aGameSetUp assigns: aDeckOfCards. 

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager:=TurnManager withOrder:{aPlayer1}.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self assert: (aBoard cardsOf: aPlayer1) equals: (OrderedCollection with: AccelerationCard  with: AccelerationCard).
]

{ #category : 'tests' }
DeckOfCardsTest >> test3WhenAcceleratorCardIsUsedThenItRemainsOnGameUntilRemoved [

	| aGameSetUp aDice aBoard aPlayer1 aTurnManager  aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	
	anAccelerationCard:=AccelerationCard withIncrement: 1.
	
	aDeckOfCards:= { anAccelerationCard . anAccelerationCard } asOrderedCollection.
	aGameSetUp assigns: aDeckOfCards. 

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager:=TurnManager withOrder:{aPlayer1}.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	
	aBoard playerThrows: anAccelerationCard.

	self assert: (aBoard positionOf: aPlayer1) equals: 7.
]
