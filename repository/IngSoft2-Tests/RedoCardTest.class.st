Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> test1WhenARedoCardIsUsedAfterAccelerationThenItCopysTheImplementionsOfTheLastUsed [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aRedoCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.
	aRedoCard := CardRedo for: 2.

	aDeckOfCards := {
		                anAccelerationCard.
		                aRedoCard.
		                anAccelerationCard.
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

	"aDice setNumbersProvider: { 1. 1. 1. 1 }."
	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2. "1+1"
	aBoard with: aPlayer2 throws: aRedoCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4. "1+1+2=4"
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6. "2+1+1+3"
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8 "4+1+1+2"
]

{ #category : 'tests' }
RedoCardTest >> test2WhenARedoCardIsUsedAfterCancellationCardThenItUsesTheLastImplementationOfTheInstaniusCard [

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

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.

	aBoard with: aPlayer2 throws: aCancellationCard.
	aBoard with: aPlayer2 throws: aRedoCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.

	aBoard with: aPlayer1 throws: anAccelerationCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6
]

{ #category : 'tests' }
RedoCardTest >> test5WhenARedoCardIsUsedAfterAnAllyCardThenItUsesTheLastImplementationOfTheInstaniusCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAllyCard aPlayer3 aPlayer4 aRedoCard |
	aGameSetUp := GameSetup new.
	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Pedro'.
	aPlayer3 := SpaceShip named: 'Caro'.
	aPlayer4 := SpaceShip named: 'Maru'.
	aDice := RiggedDice withNumberOfFaces: 2.
	aDice setNumbersProvider: { 0. 1. 0. 1 }.
	aGameSetUp withDices: { aDice }.
	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2.
			aPlayer3.
			aPlayer4 }.

	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2.
			                aPlayer3.
			                aPlayer4 }.
	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	anAllyCard := CardAlly teamsUpWith: aPlayer2.
	aRedoCard := CardRedo for: aPlayer4.

	aDeckOfCards := {
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard.
		                anAllyCard } asOrderedCollection.

	aGameSetUp assignsRandomly: aDeckOfCards.
	aGameSetUp equip: aPlayer3 with: aRedoCard.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer1) equals: 0.

	self assert: (aBoard positionOf: aPlayer2) equals: 3.

	self assert: (aBoard positionOf: aPlayer3) equals: 0.

	self assert: (aBoard positionOf: aPlayer4) equals: 3.

	aBoard with: aPlayer1 throws: anAllyCard. "tira la carta el player 1"
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard with: aPlayer3 throws: aRedoCard.
	aBoard playNextTurn.
	aBoard playNextTurn. "juegan todos + el player 3 tira el redo y hace team con el player 4"


	self assert: (aBoard positionOf: aPlayer1) equals: 0.

	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 4.

	self assert: (aBoard positionOf: aPlayer3) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer3) equals: 4.
	self assert: (aBoard positionOf: aPlayer4) equals: 4.
	self assert: (aBoard currentFuleOf: aPlayer4) equals: 0.

	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard playNextTurn. "aca deberia empezar a bajar la fuel de los teammates pq tanto player2 y player 3 se quedron sin fuel"

	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0.

	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 0
]

{ #category : 'tests' }
RedoCardTest >> test6WhenARedoCardIsUsedAfterOverLoadThenItCopysTheImplementionsOfTheLastUsed [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anOverLoadCard aRedoCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 5. 3. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 10.
	aDice2 setNumbersProvider: { 5. 5. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anOverLoadCard := CardOverLoad for: aPlayer2.
	aRedoCard := CardRedo for: aPlayer1.

	aDeckOfCards := {
		                anOverLoadCard.
		                aRedoCard.
		                anOverLoadCard.
		                aRedoCard } asOrderedCollection.

	aGameSetUp assignsInOrder: aDeckOfCards.


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

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.


	aBoard with: aPlayer1 throws: anOverLoadCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8.
	aBoard with: aPlayer2 throws: aRedoCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 14.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 14
]

{ #category : 'tests' }
RedoCardTest >> test7WhenARedoCardIsUsedAfterARedoThenItCopysTheImplementionsOfit [

	| aGameSetUp aDice aDice2 aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anOverLoadCard aRedoCard aRedoCard1 |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 5. 5. 3. 4 }.
	aDice2 := RiggedDice withNumberOfFaces: 10.
	aDice2 setNumbersProvider: { 5. 5. 3. 4 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anOverLoadCard := CardOverLoad for: aPlayer2.
	aRedoCard := CardRedo for: aPlayer1.
	aRedoCard1 := CardRedo for: aPlayer2.

	aDeckOfCards := {
		                anOverLoadCard.
		                aRedoCard.
		                aRedoCard1.
		                aRedoCard } asOrderedCollection.

	aGameSetUp assignsInOrder: aDeckOfCards.


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

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard with: aPlayer1 throws: anOverLoadCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 8.
	aBoard with: aPlayer2 throws: aRedoCard.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 14.
	aBoard with: aPlayer1 throws: aRedoCard1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 12
]
