Class {
	#name : 'FuleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FuleTest >> test010WhenASpaceShipSkipsATurnThenTheNextSpaceShipPlays [

	| aGameSetUp aDice aDice2 aPlayer1 aBoard aPlayer2 |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 5 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aGameSetUp withNumberOfPlayers: 2.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.

	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14.

	aBoard skipRoundAndRechargeFor: aPlayer1.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	self assert: (aBoard positionOf: aPlayer2) equals: 14.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 10
]

{ #category : 'tests' }
FuleTest >> test0WhenASpaceShipDoesntMoveThenItHasInitialFuel [
| aGameSetUp aDice aPlayer1|

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
		aDice := RiggedDice withNumberOfFaces: 8.
    aDice setNumbersProvider:  {7. 3. 3. 4 }.
	
	aGameSetUp withDices: {
        aDice}.
	
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	self assert: (aPlayer1 currentFule ) equals: 16.
]

{ #category : 'tests' }
FuleTest >> test1WhenASpaceShipDoesntMoveThenItHasTheDoubleOfTheMaximumRolledNumberFuel [
| aGameSetUp aDice aDice2 aPlayer1|

	
	aGameSetUp:= GameSetup new.
		aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: {7. 3. 3. 3 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider:  {1. 2. 3. 4 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

	aGameSetUp withNumberOfPlayers:1.

			
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	self assert: (aPlayer1 currentFule ) equals: 24.
]

{ #category : 'tests' }
FuleTest >> test2WhenASpaceShipMovesThenFuelDecreasesByTheAmountMoved [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 |
	aGameSetUp := GameSetup new.


	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 7. 3. 3. 3 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 1. 2. 3. 4 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 1 to: 1.
	aGameSetUp withMaximumLapsToWin: 10.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 16
]

{ #category : 'tests' }
FuleTest >> test3WhenASpaceShipDoesntHaveAnyFuleLeftThenItGoesBackToTheInitialPosition [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 |
	aGameSetUp := GameSetup new.


	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom: 1 to: 1.
	aGameSetUp withMaximumLapsToWin: 6.

	aGameSetUp createGameInstance.




	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0
]

{ #category : 'tests' }
FuleTest >> test4WhenSpaceShipDoesntHaveFuleThenLosesTwoTurnsAndThenItCanMoveAgainWithTheirMaximumFule [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 8. 7. 2. 8. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 2. 3. 2 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 6.

	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.
	aBoard playOneRound.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 0.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 0.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 14
]

{ #category : 'tests' }
FuleTest >> test5WhenMoreThanOneSpaceShipDoesntHaveFuleThenBothCantMoveForTwoTurns [
| aGameSetUp aPlayer1 aPlayer2 aBoard aDice aDice2 |


    aGameSetUp:= GameSetup new.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: {8. 7. 2. 8. 7. 2. 8. 7. 2. 8. 7. 2} .
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider:{2. 3. 2. 2. 3. 2. 2. 3. 2. 2. 3. 2} .
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

    aGameSetUp withNumberOfPlayers:2.
   

    aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom:1 to: 1.
    aGameSetUp withMaximumLapsToWin: 16.

    aGameSetUp createGameInstance .


    aPlayer1:=(aGameSetUp spaceShips) first.
    aPlayer2:=(aGameSetUp spaceShips) second.
    aBoard:=(aGameSetUp board).
    aBoard playOneRound.
    aBoard playOneRound.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 0.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 0.
    aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 24.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 24.
    aBoard playOneRound.
 self assert: (aBoard positionOf: aPlayer1 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 24.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 0.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 24.
  aBoard playOneRound.
    self assert: (aBoard positionOf: aPlayer1 ) equals: 10.
    self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 14.
    self assert: (aBoard positionOf: aPlayer2 ) equals: 10.
    self assert: (aBoard currentFuleOf: aPlayer2 ) equals: 14.

]

{ #category : 'tests' }
FuleTest >> test6WhenASpaceShipFallsIntoAEntranceOfWormHoleThenTheFuleDecrecesTheAmountMoved [

| aGameSetUp aDice aPlayer1 aBoard aDice2 |

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
		aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider:  {1. 7. 2}.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: {2. 3. 2}.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.

			
	aGameSetUp withABoardNumberOfSquares: 80 andWithWormHoleFrom:3 to: 5.
	aGameSetUp withMaximumLapsToWin: 100.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	aBoard:=(aGameSetUp board).
	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1 ) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1 ) equals: 19.
]

{ #category : 'tests' }
FuleTest >> test7WhenASpaceShipFallsIntoAExitOfWormHoleThenTheFuleDecrecesTheAmountMoved [

	| aGameSetUp aPlayer1 aBoard aDice aDice2 |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 1.
	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.


	aGameSetUp
		withABoardNumberOfSquares: 666
		andWithWormHoleFrom: 3
		to: 5.
	aGameSetUp withMaximumLapsToWin: 100.

	aGameSetUp createGameInstance.


	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 3.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 17
]

{ #category : 'tests' }
FuleTest >> test8WhenASpaceShipChoosesToSkipARoundThenDosentMoveAndRechargesTheFule [
	| aGameSetUp aPlayer1 aBoard aDice aDice2 |
	aGameSetUp := GameSetup new.

	aGameSetUp withNumberOfPlayers: 1.
	
			aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aGameSetUp withABoardNumberOfSquares: 100 andWithWormHoleFrom: 1 to:1.
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aBoard := aGameSetUp board.
	
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19.
	aBoard skipRoundAndRechargeFor: aPlayer1.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 15.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 14.


]

{ #category : 'tests' }
FuleTest >> test9WhenBothSpaceShipsSkipRoundThenTheyRechargeAllTheirFule [

	| aGameSetUp aPlayer1 aBoard aPlayer2 aDice aDice2 |
	aGameSetUp := GameSetup new.

	aDice := RiggedDice withNumberOfFaces: 8.
	aDice setNumbersProvider: { 3. 7. 2. 5 }.
	aDice2 := RiggedDice withNumberOfFaces: 4.
	aDice2 setNumbersProvider: { 2. 3. 2. 5 }.
	aGameSetUp withDices: {
			aDice.
			aDice2 }.



	aGameSetUp withNumberOfPlayers: 2.

	aGameSetUp
		withABoardNumberOfSquares: 100
		andWithWormHoleFrom: 1
		to: 1.
	aGameSetUp withMaximumLapsToWin: 100.
	aGameSetUp createGameInstance.

	aPlayer1 := aGameSetUp spaceShips first.
	aPlayer2 := aGameSetUp spaceShips second.
	aBoard := aGameSetUp board.

	aBoard playOneRound.

	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 19.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14.

	aBoard skipRoundAndRechargeFor: aPlayer1.
	aBoard skipRoundAndRechargeFor: aPlayer2.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 5.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 24.
	self assert: (aBoard positionOf: aPlayer2) equals: 10.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 24.
	aBoard playOneRound.
	self assert: (aBoard positionOf: aPlayer1) equals: 9.
	self assert: (aBoard currentFuleOf: aPlayer1) equals: 20.
	self assert: (aBoard positionOf: aPlayer2) equals: 20.
	self assert: (aBoard currentFuleOf: aPlayer2) equals: 14
]
