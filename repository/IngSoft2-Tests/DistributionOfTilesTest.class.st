Class {
	#name : 'DistributionOfTilesTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DistributionOfTilesTest >> should:anErrorBlock raise:anErrorClass withMessegeText:errorMessage [

self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
DistributionOfTilesTest >> test1WhenATileDistributionIsSetThenBoardIsCreatedWithTheFollowingDistribution [

	| boardSize aTileDistribution tiles |
	boardSize := 1500.
	aTileDistribution := TileDistribution withABoardNumberOfSquares:
		                     boardSize.

	aTileDistribution forNoEffect: 0.40.
	aTileDistribution forBlackHole: 0.20.
	aTileDistribution forHyperGravity: 0.20.
	aTileDistribution forMoonWalk: 0.10.
	aTileDistribution forHyperJump: 0.08.
	aTileDistribution forAtomicBomb: 0.02.

	tiles := aTileDistribution build.

	self assert:
		((aTileDistribution percentageOf: NoEffect) between: 0.37 and: 0.43).
	self assert:
		((aTileDistribution percentageOf: BlackHole) between: 0.18 and: 0.22).
	self assert: ((aTileDistribution percentageOf: HyperGravity)
			 between: 0.18
			 and: 0.22).
	self assert:
		((aTileDistribution percentageOf: MoonWalk) between: 0.08 and: 0.12).
	self assert:
		((aTileDistribution percentageOf: HyperJump) between: 0.06 and: 0.10).
	self assert:
		((aTileDistribution percentageOf: AtomicBomb)
			 between: 0.01
			 and: 0.04)
]

{ #category : 'tests' }
DistributionOfTilesTest >> test2WhenATileDistributionIsSetThenTheBoardCanHaveOneSpecialTile [

	| boardSize aTileDistribution tiles |
	boardSize := 1500.
	aTileDistribution := TileDistribution withABoardNumberOfSquares:
		                     boardSize.
 
	aTileDistribution forNoEffect: 0.
	aTileDistribution forBlackHole: 1.
	aTileDistribution forHyperGravity: 0.
	aTileDistribution forMoonWalk: 0.
	aTileDistribution forHyperJump: 0.
	aTileDistribution forAtomicBomb: 0.

	tiles := aTileDistribution build.

	self assert:
		((aTileDistribution percentageOf: NoEffect) between: 0 and: 0).
	self assert:
		((aTileDistribution percentageOf: BlackHole) between: 0.98 and: 1).
	self assert:
		((aTileDistribution percentageOf: HyperGravity) between: 0 and: 0).
	self assert:
		((aTileDistribution percentageOf: MoonWalk) between: 0 and: 0).
	self assert:
		((aTileDistribution percentageOf: HyperJump) between: 0 and: 0).
	self assert:
		((aTileDistribution percentageOf: AtomicBomb) between: 0 and: 0)
]

{ #category : 'tests' }
DistributionOfTilesTest >> test3WhenTheSumOfProbabilitiesIsntOneThenTheCreationFails [

	| boardSize aTileDistribution |
	boardSize := 1500.
	aTileDistribution := TileDistribution withABoardNumberOfSquares:
		                     boardSize.

	aTileDistribution forNoEffect: 0.
	aTileDistribution forBlackHole: 0.
	aTileDistribution forHyperGravity: 0.
	aTileDistribution forMoonWalk: 0.
	aTileDistribution forHyperJump: 0.
	aTileDistribution forAtomicBomb: 0.


	self
		should: [ aTileDistribution build ]
		raise: Error
		withMessegeText: 'The Sum Of All Probabilities should be 1'
]

{ #category : 'tests' }
DistributionOfTilesTest >> test4WhenATileDistributionIsSetThenTheBoardIsCreatedWithABonusCardProbability [

	| boardSize aTileDistribution tiles |
	boardSize := 1500.
	aTileDistribution := TileDistribution withABoardNumberOfSquares:
		                     boardSize.
	aTileDistribution forBonusCard: 0.10.

	aTileDistribution forNoEffect: 0.30.
	aTileDistribution forBlackHole: 0.20.
	aTileDistribution forHyperGravity: 0.20.
	aTileDistribution forMoonWalk: 0.10.
	aTileDistribution forHyperJump: 0.08.
	aTileDistribution forAtomicBomb: 0.02.

	tiles := aTileDistribution build.

	self assert:
		((aTileDistribution percentageOf: NoEffect) between: 0.27 and: 0.33).
	self assert:
		((aTileDistribution percentageOf: BlackHole) between: 0.18 and: 0.22).
	self assert: ((aTileDistribution percentageOf: HyperGravity)
			 between: 0.18
			 and: 0.22).
	self assert:
		((aTileDistribution percentageOf: MoonWalk) between: 0.08 and: 0.12).
	self assert:
		((aTileDistribution percentageOf: HyperJump) between: 0.06 and: 0.10).
	self assert:
		((aTileDistribution percentageOf: AtomicBomb)
			 between: 0.01
			 and: 0.04).
	self assert:
		((aTileDistribution percentageOf: BonusCard) between: 0.08 and: 0.12)
]
