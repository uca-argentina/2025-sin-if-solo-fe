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
    | availablePositions effectsPool totalAssigned remaining |
    availablePositions := (1 to: numberOfTiles) asOrderedCollection shuffle.
    tiles := OrderedCollection new.
    effectsPool := OrderedCollection new.

    (numberOfTiles * atomicBombProability) floor timesRepeat: [
        effectsPool add: AtomicBomb new ].
    (numberOfTiles * hyperJumpProbability) floor timesRepeat: [
        effectsPool add: HyperJump new ].
    (numberOfTiles * moonWalkProbabilty) floor timesRepeat: [
        effectsPool add: MoonWalk new].
    (numberOfTiles * hyperGravityProbability) floor timesRepeat: [
        effectsPool add: HyperGravity new].
    (numberOfTiles * blackHoleProbability) floor timesRepeat: [
        effectsPool add: BlackHole new ].
    (numberOfTiles * noEffectProbability) floor timesRepeat: [
        effectsPool add: NoEffect new].
    

    totalAssigned := effectsPool size.
    remaining := numberOfTiles - totalAssigned.
    remaining timesRepeat: [
        effectsPool add: NoEffect new].
    
    effectsPool := effectsPool shuffle.
    availablePositions do: [ :pos |
        | effect |
        effect := effectsPool removeFirst.
        tiles add: effect.
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

{ #category : 'accessing' }
TileDistribution >> percentageOf: tile [
    ^(tiles count: [ :atile | atile isType: tile ])/tiles size asFloat.

]
