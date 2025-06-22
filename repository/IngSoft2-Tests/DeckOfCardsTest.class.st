Class {
	#name : 'DeckOfCardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DeckOfCardsTest >> test10WhenASecondSpaceShipUsesAnAllyCardThenItApplysTheirConcuences [

	| aGameSetUp aDice  aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards  anAllyCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aDice := RiggedDice withNumberOfFaces: 2.
		aDice setNumbersProvider: { 2. 0. 1. 0 }.
	aGameSetUp withDices: {
			aDice.
			}.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.
	
	anAllyCard := AllyCard teamsUpWith: aPlayer2.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard .anAllyCard.anAllyCard } asOrderedCollection.
	
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.  
	aBoard playNextTurn.aBoard playerThrows: anAllyCard. "aBoard playNextTurn. " 
	aBoard playNextTurn.aBoard playNextTurn.
	aBoard playNextTurn.aBoard playNextTurn. 
	
	
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 3.
	
	aBoard playNextTurn.aBoard playNextTurn. 

	
	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 2.
	
	
	
	
	
	



]

{ #category : 'tests' }
DeckOfCardsTest >> test11WhenTestingADeterministicMethodForCardsIsUsed [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := AccelerationCard withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.anAccelerationCard.anAccelerationCard } asOrderedCollection.
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
	aGameSetUp  equip: aPlayer1 with: anAccelerationCard. "Esto es para hacerlo determinisco"

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self assert: (aBoard cardsOf: aPlayer1)size equals: 3.



]

{ #category : 'tests' }
DeckOfCardsTest >> test12WhenACancellationCardIsUsedThenItCancelsTheEffectOfAPreviousCard [

    | aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard |
    aGameSetUp := GameSetup new.

    aDice := RiggedDice withNumberOfFaces: 6.
    aDice setNumbersProvider: { 1. 1. 1. 1 }.

    aPlayer1 := SpaceShip named: 'Juan'.
    aPlayer2 := SpaceShip named: 'Martin'.

    anAccelerationCard := AccelerationCard withIncrement: 1.
    aCancellationCard:=CancellationCard for: anAccelerationCard.

    aDeckOfCards := {
                        anAccelerationCard .
                        anAccelerationCard .
                            anAccelerationCard .
                        anAccelerationCard } asOrderedCollection.
    aGameSetUp assignsRandomly: aDeckOfCards.
    aGameSetUp  equip: aPlayer2 with: aCancellationCard.

    aGameSetUp withDices: { aDice }.
    aGameSetUp withPlayers: {
            aPlayer1.
            aPlayer2 }.

    aTurnManager := TurnManager withOrder: {
                            aPlayer1.
                                aPlayer2 }.


    aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.

    aGameSetUp createGameInstance.
    aBoard := aGameSetUp board.
    aBoard playerThrows: anAccelerationCard .aBoard playNextTurn.
    self assert: (aBoard positionOf: aPlayer1) equals: 2.


    aBoard playerThrows: aCancellationCard . aBoard playNextTurn.


    self assert: (aBoard positionOf: aPlayer2) equals: 1.

]

{ #category : 'tests' }
DeckOfCardsTest >> test13WhenThePermanentCardIWhichWantsToGetCancelledIsntBeingPlayedThenCancellationCardHasNoEffect [

    | aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard |
    aGameSetUp := GameSetup new.

    aDice := RiggedDice withNumberOfFaces: 6.
    aDice setNumbersProvider: { 1. 1. 1. 1 }.

    aPlayer1 := SpaceShip named: 'Juan'.
    aPlayer2 := SpaceShip named: 'Martin'.

    anAccelerationCard := AccelerationCard withIncrement: 1.
    aCancellationCard:=CancellationCard for: anAccelerationCard.

    aDeckOfCards := {
                        anAccelerationCard .
                        anAccelerationCard .
                            anAccelerationCard .
                        anAccelerationCard } asOrderedCollection.
    aGameSetUp assignsRandomly: aDeckOfCards.
    aGameSetUp  equip: aPlayer2 with: aCancellationCard.

    aGameSetUp withDices: { aDice }.
    aGameSetUp withPlayers: {
            aPlayer1.
            aPlayer2 }.

    aTurnManager := TurnManager withOrder: {
                            aPlayer1.
                                aPlayer2 }.


    aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.

    aGameSetUp createGameInstance.
    aBoard := aGameSetUp board.
    aBoard playNextTurn.
    self assert: (aBoard positionOf: aPlayer1) equals: 1.


    aBoard playerThrows: aCancellationCard .aBoard playNextTurn.

    self assert: (aBoard positionOf: aPlayer2) equals: 1.
]

{ #category : 'tests' }
DeckOfCardsTest >> test14WhenARedoCardIsUsedThenItCopysTheImplementionsOfTheLastUsed [


	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aRepeatCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := AccelerationCard withIncrement: 1.
	aRepeatCard:=RedoCard for: 1.

	aDeckOfCards := {
		                anAccelerationCard .
		                aRepeatCard  .
							anAccelerationCard .
		                aRepeatCard  } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.
	aGameSetUp  equip: aPlayer2 with: aRepeatCard.

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
				                aPlayer2 }.
				
				
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	
	"aDice setNumbersProvider: { 1. 1. 1. 1 }."
	aBoard playerThrows: anAccelerationCard . aBoard playNextTurn. 
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	
	aBoard playerThrows: aRepeatCard . aBoard playNextTurn.
	
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	
	aBoard playNextTurn .
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	aBoard playNextTurn .
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	
	



]

{ #category : 'tests' }
DeckOfCardsTest >> test1WhenASpaceShipGetsCreatedThenItGetsAssignedTwoCardsAtRandom [

	| aGameSetUp aDice aBoard aPlayer1 aTurnManager  aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	
	aDeckOfCards:= { AccelerationCard . AccelerationCard  } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards. 

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

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager  aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
		aPlayer2 := SpaceShip named: 'Martin'.
	
	aDeckOfCards:= { AccelerationCard . AccelerationCard . AccelerationCard. AccelerationCard.AccelerationCard} asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards. 

	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: { aPlayer1 .aPlayer2}.

	aTurnManager:=TurnManager withOrder:{aPlayer1}.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.

	self assert: (aBoard cardsOf: aPlayer1)size equals: 3.
]

{ #category : 'tests' }
DeckOfCardsTest >> test3WhenAcceleratorCardIsUsedThenItRemainsOnGameUntilRemoved [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 6. 3. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := AccelerationCard withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard .
		anAccelerationCard.
		anAccelerationCard} asOrderedCollection.
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

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard playerThrows: anAccelerationCard.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
]

{ #category : 'tests' }
DeckOfCardsTest >> test4WhenAAceleratorCardIsUsedThenItAffectsTheFinalRolledNumber [


	| aGameSetUp aDice aDice2  aBoard aPlayer1  aTurnManager aDeckOfCards anAccelerationCard |
	aGameSetUp := GameSetup new.

	aDice := RealDice withNumberOfFaces: 1.
	aDice2 := RealDice withNumberOfFaces: 1.
	
	aPlayer1 := SpaceShip named: 'Juan'.


	anAccelerationCard := AccelerationCard withIncrement: 1.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.anAccelerationCard.anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp withDices: { aDice.aDice2 }.
	aGameSetUp withPlayers: {
			aPlayer1.
			 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                 }.
	aGameSetUp withABoardNumberOfSquares: 10 andTurnManager: aTurnManager.
	aGameSetUp withTiles: { (BonusCard in: 6) }.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard playerThrows: anAccelerationCard.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 3.

]

{ #category : 'tests' }
DeckOfCardsTest >> test5WhenAOverLoadCardIsUsedThenTheEffectIsApplyToASpecificSpaceShip [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards  anOverLoadCard |
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
	anOverLoadCard := OverLoadCard for: aPlayer2.

	aDeckOfCards := {
		                anOverLoadCard.
		                anOverLoadCard.anOverLoadCard.anOverLoadCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	aBoard playerThrows: anOverLoadCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8.
]

{ #category : 'tests' }
DeckOfCardsTest >> test6WhenAOverLoadCardIsUsedAndTheRolledNumberIsNegativeThenItGoesBack [


	| aGameSetUp aDice aDice2 aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards  anOverLoadCard |
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
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.
	
	anOverLoadCard := OverLoadCard for: aPlayer2.

	aDeckOfCards := {
		                anOverLoadCard.
		                anOverLoadCard.anOverLoadCard.anOverLoadCard } asOrderedCollection.
	
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	
	self assert: (aBoard positionOf: aPlayer1) equals: 2.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.

	aBoard playerThrows: anOverLoadCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer2) equals: 1.

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
	
	anOverLoadCard := OverLoadCard for: aPlayer2.
	aDeckOfCards := {
		anOverLoadCard.
		anOverLoadCard .anOverLoadCard.anOverLoadCard} asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.
	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	
	
	aBoard playNextTurn. 
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	aBoard playNextTurn. 
	self assert: (aBoard positionOf: aPlayer2) equals: 5. 
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 1.
	aBoard playerThrows: anOverLoadCard.
	
	
	aBoard playNextTurn. 
	self assert: (aBoard positionOf: aPlayer1) equals: 5. 
	
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer2) equals: 4. 
	self assert: (aBoard completedLapsBy: aPlayer2) equals: 0. 

]

{ #category : 'tests' }
DeckOfCardsTest >> test8WhenAnAllyCardIsUsedThenTheSpaceShipsCanShareTheirFule [
	| aGameSetUp aDice  aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards  anAllyCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aDice := RiggedDice withNumberOfFaces: 2.
		aDice setNumbersProvider: { 0. 1. 0. 1 }.
	aGameSetUp withDices: {
			aDice.
			}.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.
	
	anAllyCard := AllyCard teamsUpWith: aPlayer2.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard .anAllyCard.
		                anAllyCard } asOrderedCollection.
	
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.aBoard playNextTurn.
	aBoard playNextTurn.aBoard playNextTurn.
	aBoard playNextTurn.aBoard playNextTurn.
	
	
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 1.
	aBoard playerThrows: anAllyCard.
	aBoard playNextTurn.
	
	
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	
	aBoard playNextTurn. aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 3.
	
	
	
	
	
	
	
	



]

{ #category : 'tests' }
DeckOfCardsTest >> test9WhenAnAllyCardIsUsedAndNeitherOfTheSpaceShipsHaveFuleThenBothLosesTwoRounds [
	| aGameSetUp aDice  aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards  anAllyCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aDice := RiggedDice withNumberOfFaces: 2.
		aDice setNumbersProvider: { 1. 1. 1. 1 }.
	aGameSetUp withDices: {
			aDice.
			}.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.
	aGameSetUp withABoardNumberOfSquares: 100 andTurnManager: aTurnManager.
	
	anAllyCard := AllyCard teamsUpWith: aPlayer2.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard .anAllyCard.
		                anAllyCard } asOrderedCollection.
	
	aGameSetUp assignsRandomly: aDeckOfCards.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.aBoard playNextTurn.
	aBoard playNextTurn.aBoard playNextTurn.
	aBoard playNextTurn.aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 1.
	
	aBoard playerThrows: anAllyCard.
	aBoard playNextTurn.aBoard playNextTurn.
	
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	aBoard playNextTurn.aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	aBoard playNextTurn.aBoard playNextTurn.
	aBoard playNextTurn.aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	
	
	
	
	
	
	



]

{ #category : 'tests' }
DeckOfCardsTest >> testWhenBanana [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aTurnManager  aDeckOfCards |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 1.
	
	aDice2 := RiggedDice withNumberOfFaces: 1.

	aPlayer1 := SpaceShip named: 'Juan'.
	
	aDeckOfCards:= { AccelerationCard . AccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards. 

	aGameSetUp withDices: { aDice.aDice2 }.
	aGameSetUp withPlayers: { aPlayer1 }.

	aTurnManager:=TurnManager withOrder:{aPlayer1}.
	aGameSetUp withABoardNumberOfSquares: 6 andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.

	self assert: (aBoard cardsOf: aPlayer1) equals: (OrderedCollection with: AccelerationCard  with: AccelerationCard).
]
