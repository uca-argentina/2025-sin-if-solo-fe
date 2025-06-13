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
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
DiceTest >> test0WhenADiceGetsInitializedThenItsReadyToBeUsed [

	| aDice |
	aDice := RiggedDice withNumberOfFaces: 6.
	self assert: aDice numberOfFaces equals: 6
]

{ #category : 'tests' }
DiceTest >> test1WhenADiceItsReadyToBeUsedThenItCanBeRolled [

	| aDice |
	aDice := RiggedDice withNumberOfFaces: 6.
	aDice setNumbersProvider: { 1. 2. 3. 4. 5. 6 }.

	self assert: aDice rolledNumber equals: 1
]

{ #category : 'tests' }
DiceTest >> test2WhenADiceHasNegativeNumberOfFacesThenCreationFails [

	self
		should: [ RiggedDice withNumberOfFaces: -1 ]
		raise: Error
		withMessageText: 'A Dice has to have at least 1 face'
]

{ #category : 'tests' }
DiceTest >> test4WhenARealDiceIsRolledThenTheRolledNumberIsAtRandom [

	| aDice |
	aDice := RealDice withNumberOfFaces: 1.

	self assert: aDice rolledNumber equals: 1
]

{ #category : 'tests' }
DiceTest >> test5WhenARealDiceIsRolledWithNumberOfFacesThenTheRolledNumberIsAtRandomInARange [

	| aDice numberOfFaces |
	numberOfFaces := 6.
	aDice := RealDice withNumberOfFaces: numberOfFaces.
	self assert: [ (1 to: numberOfFaces) includes: aDice rolledNumber ]
]

{ #category : 'tests' }
DiceTest >> test6WhenARealDiceIsRolledWithNumberOfFacesNegativeThenCreationFails [

	| numberOfFaces |
	numberOfFaces := -1.
	self
		should: [ RealDice withNumberOfFaces: numberOfFaces ]
		raise: Error
		withMessageText: 'A Dice has to have at least 1 face'
]
