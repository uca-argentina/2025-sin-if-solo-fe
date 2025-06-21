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

| avaliblePosition atomicCount hyperJumpCount moonWalkCount hyperGravityCount blackHoleCount noEffectCount |

avaliblePosition := OrderedCollection new.
1 to: numberOfTiles do: [:aNumber | avaliblePosition add: aNumber ].

avaliblePosition := avaliblePosition shuffle .
atomicCount := (numberOfTiles * atomicBombProability ) floor.
hyperJumpCount := (numberOfTiles * hyperJumpProbability ) floor.
moonWalkCount := (numberOfTiles * moonWalkProbabilty ) floor.
hyperGravityCount := (numberOfTiles * hyperGravityProbability ) floor.
blackHoleCount := (numberOfTiles * blackHoleProbability ) floor.
noEffectCount:=(numberOfTiles * noEffectProbability ) floor.

tiles := OrderedCollection new.

1 to: atomicCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    tiles add: (AtomicBomb in: pos).
].

1 to: hyperJumpCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    tiles add: (HyperJump in: pos parsecToMove: {1. 9 .7}).
].

1 to: moonWalkCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    tiles add: (MoonWalk in: pos moveBack:aCount).
].

1 to: hyperGravityCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    tiles add: (HyperGravity in: pos requiringMinimumRoll:1 ).
].
1 to: blackHoleCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    tiles add: (BlackHole in: pos).
].

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
