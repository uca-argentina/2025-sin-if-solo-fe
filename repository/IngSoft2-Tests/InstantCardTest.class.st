Class {
	#name : 'InstantCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
InstantCardTest >> test0WhenItsNotTheSpaceShipTurnitCanStillThrowAInatantaniousCard [

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
InstantCardTest >> test12WhenACancellationCardIsUsedThenItCancelsTheEffectOfAPreviousCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.
	aCancellationCard := CancellationCard for: anAccelerationCard.

	aDeckOfCards := {
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsRandomly: aDeckOfCards.
	aGameSetUp equip: aPlayer2 with: aCancellationCard.

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
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 2.

	aBoard with: aPlayer2 throws: aCancellationCard.
	aBoard playNextTurn.


	self assert: (aBoard positionOf: aPlayer2) equals: 1
]

{ #category : 'tests' }
InstantCardTest >> test13WhenThePermanentCardIWhichWantsToGetCancelledIsntBeingPlayedThenCancellationCardHasNoEffect [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.
	aCancellationCard := CancellationCard for: anAccelerationCard.

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


	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.

	aGameSetUp createGameInstance.
	aBoard := aGameSetUp board.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.

	aBoard with: aPlayer2 throws: aCancellationCard.
	aBoard playNextTurn.

	self assert: (aBoard positionOf: aPlayer2) equals: 1
]

{ #category : 'tests' }
InstantCardTest >> test1ARepeatCardIsUsedAfterFallinginABonusTileThenTheAssignedSpaceshipGetsAnotherCard [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 2. 1. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.


	anAccelerationCard := CardAcceleration withIncrement: 1.

	aRepeat := CardRepeat for: aPlayer2.
	aCancellationCard := CancellationCard for: anAccelerationCard.

	aDeckOfCards := {
		                aRepeat.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withTiles: { (BonusCard in: 1) }.


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


	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	self assert: aPlayer1 cardsInHand equals: (OrderedCollection
			 with: aRepeat
			 with: anAccelerationCard
			 with: anAccelerationCard).
	aBoard with: aPlayer1 throws: aRepeat.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 2.
	self assert: aPlayer2 cardsInHand equals: (OrderedCollection
			 with: anAccelerationCard
			 with: anAccelerationCard
			 with: anAccelerationCard)
]

{ #category : 'tests' }
InstantCardTest >> test2ARepeatCardIsUsedAfterFallinginAAtomicBombTheTheSpaeShipTargetedGetsMoveToInitialPosition [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards anAccelerationCard aCancellationCard aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 1. 1. 2 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.

	anAccelerationCard := CardAcceleration withIncrement: 1.

	aRepeat := CardRepeat for: aPlayer2.
	aCancellationCard := CancellationCard for: anAccelerationCard.

	aDeckOfCards := {
		                aRepeat.
		                anAccelerationCard.
		                anAccelerationCard.
		                anAccelerationCard } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withTiles: { (AtomicBomb in: 2) }.


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
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 1.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 0
]

{ #category : 'tests' }
InstantCardTest >> test3ARepeatCardIsUsedAfterFallinginABlackHole [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 1. 4. 4. 6 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.
	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withTiles: { (BlackHole in: 5) }.


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

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 1.
	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 6
]

{ #category : 'tests' }
InstantCardTest >> test4ARepeatCardIsUsedAfterFallinginAHyperGravity [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 3. 1. 4. 4. 3. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.
	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.
	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withTiles:
		{ (HyperGravity in: 3 requiringMinimumRoll: 3) }.


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

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 0.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 4
]

{ #category : 'tests' }
InstantCardTest >> test5ARepeatCardIsUsedAfterFallinginAHyperJump [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 10.
	aDice setNumbersProvider: { 4. 1. 4. 4. 3. 1 }.

	aPlayer1 := SpaceShip named: 'Juan'.
	aPlayer2 := SpaceShip named: 'Martin'.
	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

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
	aGameSetUp withBoardsLengthInMetric: (Parsec distance: 100).
	aGameSetUp withMaximumLapsToWin: 6.
	aGameSetUp withTiles: { (HyperJump in: 4 toMove: {
				 (Parsec distance: 8).
				 (Parsec distance: 4).
				 (Parsec distance: 2).
				 (Parsec distance: 1) }) }.
	aGameSetUp createGameInstance.

	aBoard := aGameSetUp board.
	
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 12.
	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]

{ #category : 'tests' }
InstantCardTest >> test6ARepeatCardIsUsedAfterFallinginMoonWalk [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: {
			(WormHole from: 1 to: 1).
			(MoonWalk in: 10 moveBack: 2) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 7.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.

	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]

{ #category : 'tests' }
InstantCardTest >> test7ARepeatCardIsUsedAfterFallinginWormHole [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: { (WormHole from: 1 to: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard playNextTurn.
	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 8
]

{ #category : 'tests' }
InstantCardTest >> test8ARepeatCardIsUsedAfterFallinginNormalTile [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 1. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: { (WormHole from: 1 to: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.
	
	aBoard playNextTurn.
	aBoard playNextTurn.
	aBoard with: aPlayer1 throws: aRepeat.
	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard positionOf: aPlayer2) equals: 5.

	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 6.
	self assert: (aBoard positionOf: aPlayer2) equals: 9
]

{ #category : 'tests' }
InstantCardTest >> test9ARepeatCardIsUsedButNoDiceWasRolledThenItDosentHaveAEfect [

	| aGameSetUp aDice aBoard aPlayer1 aPlayer2 aWinnerSystem aTurnManager aDeckOfCards aRepeat |
	aGameSetUp := GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 4. 5. 3. 4 }.
	aPlayer1 := SpaceShip named: 'Fran'.
	aPlayer2 := SpaceShip named: 'Agustin'.

	aRepeat := CardRepeat for: aPlayer2.

	aDeckOfCards := {
		                aRepeat.
		                aRepeat.
		                aRepeat.
		                aRepeat } asOrderedCollection.

	aGameSetUp assignsInOrder: aDeckOfCards.

	aGameSetUp withPlayers: {
			aPlayer1.
			aPlayer2 }.

	aGameSetUp withDices: { aDice }.
	aTurnManager := TurnManager withOrder: {
			                aPlayer1.
			                aPlayer2 }.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andTurnManager: aTurnManager.
	aGameSetUp withMaximumLapsToWin: 3.
	aGameSetUp withTiles: { (WormHole from: 1 to: 3) }.
	aGameSetUp createGameInstance.


	aBoard := aGameSetUp board.
	aWinnerSystem := aGameSetUp winnerSystem.

	aBoard with: aPlayer1 throws: aRepeat.
	aBoard playNextTurn.
	aBoard playNextTurn.
	self assert: (aBoard positionOf: aPlayer1) equals: 4.
	self assert: (aBoard positionOf: aPlayer2) equals: 5
]
