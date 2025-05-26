Class {
	#name : 'FuleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FuleTest >> test0Banan [
| aGameSetUp aPlayer1|

	
	aGameSetUp:= GameSetup new.
	

	aGameSetUp withNumberOfPlayers:1.
	aGameSetUp withRiggedDiceNumbers:{7. 3. 3. 4} andNumberOfFaces:8 .
	aGameSetUp withABoardNumberOfSquares: 6 andWithWormHoleFrom:2 to: 5.
	aGameSetUp withMaximumLapsToWin: 1.
	
	aGameSetUp createGameInstance .
	
	
	aPlayer1:=(aGameSetUp spaceShips) first.
	self assert: (aPlayer1 currentFule ) equals: 8.
]
