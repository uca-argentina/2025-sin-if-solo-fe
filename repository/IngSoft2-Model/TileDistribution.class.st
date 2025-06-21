"
Class Tile Distribution
"
Class {
	#name : 'TileDistribution',
	#superclass : 'Object',
	#instVars : [
		'noEffectProbability',
		'blackHoleProbability',
		'hyperGravityProbability',
		'moonWalkProbabilty',
		'hyperJumpProbability',
		'atomicBombProability',
		'numberOfTiles',
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
TileDistribution class >> withABoardNumberOfSquares: aNumberOfTiles [

^self new initializeWithABoardSize: aNumberOfTiles.
]

{ #category : 'building' }
TileDistribution >> build [
	self theSumIsOne.
 tiles := (1 to: numberOfTiles) collect: [ :i |
        self tileFor: Random new next ].
    ^tiles

]

{ #category : 'initialization' }
TileDistribution >> forAtomicBomb: aProbability [

atomicBombProability:= aProbability.
]

{ #category : 'initialization' }
TileDistribution >> forBlackHole: aProbability [

blackHoleProbability := aProbability.
]

{ #category : 'initialization' }
TileDistribution >> forHyperGravity: aProbability [

hyperGravityProbability:= aProbability.
]

{ #category : 'initialization' }
TileDistribution >> forHyperJump: aProbability [

hyperJumpProbability:= aProbability.
]

{ #category : 'initialization' }
TileDistribution >> forMoonWalk: aProbability [

moonWalkProbabilty:= aProbability.
]

{ #category : 'initialization' }
TileDistribution >> forNoEffect: aProbability [

noEffectProbability:= aProbability.
]

{ #category : 'initialization' }
TileDistribution >> initializeWithABoardSize: aNumberOfTiles [

numberOfTiles:= aNumberOfTiles.
]

{ #category : 'accessing' }
TileDistribution >> percentageOf: tile [
    ^(tiles count: [ :atile | atile class = tile  ])/tiles size asFloat.

]

{ #category : 'verification' }
TileDistribution >> theSumIsOne [

	noEffectProbability + blackHoleProbability + hyperGravityProbability
	+ moonWalkProbabilty + hyperJumpProbability + atomicBombProability
	= 1 ifFalse: [
		Error signal: 'The Sum Of All Probabilities should be 1' ]
]

{ #category : 'creation' }
TileDistribution >> tileFor: randomProvavility [

	|  accumulated |
	 accumulated := atomicBombProability.
	randomProvavility <  accumulated ifTrue: [ ^ AtomicBomb new ].
	 accumulated :=  accumulated + hyperJumpProbability.
	randomProvavility <  accumulated ifTrue: [ ^ HyperJump new ].
	 accumulated :=  accumulated + moonWalkProbabilty.
	randomProvavility <  accumulated ifTrue: [ ^ MoonWalk new ].
	 accumulated :=  accumulated + hyperGravityProbability.
	randomProvavility <  accumulated ifTrue: [ ^ HyperGravity new ].
	 accumulated :=  accumulated + blackHoleProbability.
	randomProvavility <  accumulated ifTrue: [ ^ BlackHole new ].
	^ NoEffect new
]
