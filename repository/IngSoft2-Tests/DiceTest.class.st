Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DiceTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals:
				errorMessage ]
]

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
    aDiceNumberProvider := SetRolledNumber of: aDice as:3.

    aDice rollWith: (aDiceNumberProvider rolledNumber ).
    self assert: aDice rolledNumber equals: 3.

]

{ #category : 'tests' }
DiceTest >> test2WhenADiceHasNegativeNumberOfFacesThenCreationFails [ 
   
   self
    should: [Dice withNumberOfFaces: -1 ]
		raise: Error
		withMessageText: 'A Dice has to have at least 1 face'

	
]

{ #category : 'tests' }
DiceTest >> test3WhenRolledNumberIsBigerThanNumberOfFacesThenCreationFails [
    | aDice  |
   
    aDice := Dice withNumberOfFaces: 6.
   self
    should: [SetRolledNumber of: aDice as:10. ]
		raise: Error
		withMessageText: 'The number to roll should be smaller than the number of faces'

	
]
