Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test0WhenADiceGetsInitializedThenItsReadyToBeUsed [  
    | aDice |
aDice := Dice withNumberOfFaces: 6. 
self assert: aDice numberOfFaces equals: 6.


]

{ #category : 'tests' }
DiceTest >> test1WhenADiceItsReadyToBeUsedThenItCanBeRolled [ 
    | aDice aDiceNumberProvider |
    aDice := Dice withNumberOfFaces: 6.
    aDiceNumberProvider := SetRolledNumber with: 3.  

    aDice rollWith: aDiceNumberProvider.
    self assert: aDice rolledNumber equals: aDiceNumberProvider

]
