Class {
	#name : 'DeckOfCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DeckOfCardsTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
DeckOfCardsTest >> test01WhenItsNotTheSpaceShipTurnThenItCantThrowAPermanentCardAndDosentApplyEffect [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard aRedoCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.
	aGameSetUp equip: aPlayer1 with: anAccelerationCard.
	aRedoCard := CardRedo for: anAccelerationCard.
	aCancellationCard := CancellationCard for: anAccelerationCard.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                aCancellationCard.
		                aRedoCard } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.


	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard with: aPlayer2 throws: aCancellationCard.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	aBoard with: aPlayer2 throws: aRedoCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.

	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5
]

{ #category : 'tests' }
DeckOfCardsTest >> test0WhenASpaceShipGetsCreatedItHasAnInitialAmountOfCards [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.


	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self assert: aPlayer1 cardsInHand size equals: 2.
	self assert: aPlayer2 cardsInHand size equals: 2
]

{ #category : 'tests' }
DeckOfCardsTest >> test10WhenASecondSpaceShipUsesAnAllyCardThenItApplysTheirConcuences [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAllyCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aDice := RiggedDice withNumberOfFaces: 2.
	aDice setNumbersProvider: { 2. 0. 1. 0 }.
	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	anAllyCard := CardAlly teamsUpWith: aPlayer2.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard } asOrderedCollection.

	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	aBoard playNextTurn.
	aBoard with: aPlayer2 throws: anAllyCard.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 3.

	aBoard playNextTurn.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.

	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 2
]

{ #category : 'tests' }
DeckOfCardsTest >> test11WhenTestingADeterministicMethodForCardsIsUsed [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.
	aGameSetUp equip: aPlayer1 with: anAccelerationCard. "Esto es para hacerlo determinisco"

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self assert: (aBoard cardsOf: aPlayer1) size equals: 3
]

{ #category : 'tests' }
DeckOfCardsTest >> test1WhenASpaceShipGetsCreatedThenItGetsAssignedTwoCardsAtRandom [

	| aGameSetUp aDice aBoard aPlayer1 aTurnManager aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.

	aDeckOfCards := {
		                CardAcceleration.
		                CardAcceleration } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self
		assert: (aBoard cardsOf: aPlayer1)
		equals:
		(OrderedCollection with: CardAcceleration with: CardAcceleration)
]

{ #category : 'tests' }
DeckOfCardsTest >> test2WhenASpaceShipFallsIntoASpecialCardTileThenItHasOneMoreCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aDeckOfCards := {
		                CardAcceleration.
		                CardAcceleration.
		                CardAcceleration.
		                CardAcceleration.
		                CardAcceleration } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard cardsOf: aPlayer1) size equals: 3
]

{ #category : 'tests' }
DeckOfCardsTest >> test3WhenAcceleratorCardIsUsedThenItRemainsOnGameUntilRemoved [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	aBoard with: aPlayer2 throws: anAccelerationCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]

{ #category : 'tests' }
DeckOfCardsTest >> test4WhenAAceleratorCardIsUsedThenItAffectsTheFinalRolledNumber [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RealDice withNumberOfFaces: 1.
	aDice2 := RealDice withNumberOfFaces: 1.

	aPlayer1 := SpaceShip named: 'Juan'.


	anAccelerationCard := CardAcceleration withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp withDices: {
			aDice.
			aDice2 }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 3
]

{ #category : 'tests' }
DeckOfCardsTest >> test5WhenAOverLoadCardIsUsedThenTheEffectIsApplyToASpecificSpaceShip [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anOverLoadCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 5. 3. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 10.
	aDice2 setNumbersProvider: { 5. 5. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.

	aGameSetUp withDices: {
			aDice.
			aDice2 }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.
	anOverLoadCard := CardOverLoad for: aPlayer2.

	aDeckOfCards := {
		                anOverLoadCard.
		                anOverLoadCard.
		                anOverLoadCard.
		                anOverLoadCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	aBoard with: aPlayer1 throws: anOverLoadCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8
]

{ #category : 'tests' }
DeckOfCardsTest >> test6WhenAOverLoadCardIsUsedAndTheRolledNumberIsNegativeThenItGoesBack [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anOverLoadCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 1. 1. 1. 0 }.
	aDice2 := RiggedDice withNumberOfFaces: 10.
	aDice2 setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.

	aGameSetUp withDices: {
			aDice.
			aDice2 }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	anOverLoadCard := CardOverLoad for: aPlayer2.

	aDeckOfCards := {
		                anOverLoadCard.
		                anOverLoadCard.
		                anOverLoadCard.
		                anOverLoadCard } asOrderedCollection.

	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.

	aBoard with: aPlayer1 throws: anOverLoadCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer2) equals: 1
]

{ #category : 'tests' }
DeckOfCardsTest >> test7WhenAOverLoadCardIsUsedThenTheSpaceShipCouldGoBackALap [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anOverLoadCard |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 6. 5. 4. 1. 3. 2 }.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 5 andTurnManager: aTurnManager.

	anOverLoadCard := CardOverLoad for: aPlayer2.
	aDeckOfCards := {
		                anOverLoadCard.
		                anOverLoadCard.
		                anOverLoadCard.
		                anOverLoadCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 1.
	aBoard with: aPlayer1 throws: anOverLoadCard.


	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.

	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0
]

{ #category : 'tests' }
DeckOfCardsTest >> test8WhenAnAllyCardIsUsedThenTheSpaceShipsCanShareTheirFule [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAllyCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aDice := RiggedDice withNumberOfFaces: 2.
	aDice setNumbersProvider: { 0. 1. 0. 1 }.
	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	anAllyCard := CardAlly teamsUpWith: aPlayer2.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard } asOrderedCollection.

	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 1.
	aBoard with: aPlayer1 throws: anAllyCard.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 0.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 3
]

{ #category : 'tests' }
DeckOfCardsTest >> test9WhenAnAllyCardIsUsedAndNeitherOfTheSpaceShipsHaveFuleThenBothLosesTwoRounds [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAllyCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aDice := RiggedDice withNumberOfFaces: 2.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.
	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	anAllyCard := CardAlly teamsUpWith: aPlayer2.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard } asOrderedCollection.

	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 1.

	aBoard with: aPlayer1 throws: anAllyCard.
	aBoard playNextTurn.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 1
]

{ #category : 'tests' }
DeckOfCardsTest >> testF1WhenTheBonusCardPositionIsNegativeThenTheCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 aTurnManager aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	aDeckOfCards := {
		                CardAcceleration.
		                CardAcceleration.
		                CardAcceleration.
		                CardAcceleration.
		                CardAcceleration } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: { aPlayer1 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	self
		should: [ aGameSetUp withTiles: { (BonusCard in: -6) } ]
		raise: Error
		withMessageText: 'A BonusCard has to be in a positive position'
]

{ #category : 'tests' }
DeckOfCardsTest >> testF2WhenTheCardAccelerationHasANegativeIncrementThenTheCreationFails [

	| aGameSetUp aDice aPlayer1 aPlayer2 anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.



	self
		should: [ anAccelerationCard := CardAcceleration withIncrement: -1 ]
		raise: Error
		withMessageText:
		'A CardAcceleration has to have a positive increment'
]
