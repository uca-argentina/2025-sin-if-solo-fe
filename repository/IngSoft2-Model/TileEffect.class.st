"
Abstract Class for several tile effects
"
Class {
	#name : 'TileEffect',
	#superclass : 'Object',
	#instVars : [
		'tilePosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
TileEffect >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [ 
	^ self subclassResponsibility
]

{ #category : 'action' }
TileEffect >> applyEffectToSpecific: spaceship on: board [

^ self subclassResponsibility
]

{ #category : 'testing' }
TileEffect >> includesA:position [
^tilePosition =position.
]

{ #category : 'accessing' }
TileEffect >> position [
^tilePosition .
]

{ #category : 'validating' }
TileEffect >> validateCreationIn: boardSize and: maximumRolledNumber [ 
	 tilePosition > boardSize ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].
]
