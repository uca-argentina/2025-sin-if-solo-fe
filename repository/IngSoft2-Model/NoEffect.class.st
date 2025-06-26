"
Tile with no effect
"
Class {
	#name : 'NoEffect',
	#superclass : 'TileEffect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
NoEffect class >> in:aPosition [
^self new initializeNoEffectTileIn:aPosition .
]

{ #category : 'action' }
NoEffect >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	
]

{ #category : 'action' }
NoEffect >> applyEffectToSpecific: spaceship on: board [

	
]

{ #category : 'initialization' }
NoEffect >> initializeNoEffectTileIn: aPosition [

	tilePosition := aPosition
]
