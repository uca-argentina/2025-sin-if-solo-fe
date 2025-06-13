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

{ #category : 'testing' }
TileEffect >> isType: aTile [
^self class = aTile
]

{ #category : 'accessing' }
TileEffect >> position [
	^ tilePosition .
]

{ #category : 'validating' }
TileEffect >> validateCreationIn: boardSize and: maximumRolledNumber [ 
	 tilePosition > boardSize ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].
]
