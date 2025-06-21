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
TileDistribution >> initializeWithABoardSize: aNumberOfTiles [

numberOfTiles:= aNumberOfTiles.
]
