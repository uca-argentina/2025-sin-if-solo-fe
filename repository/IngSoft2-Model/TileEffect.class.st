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
TileEffect >> isAtomicBomb [
^ false.
]

{ #category : 'testing' }
TileEffect >> isBlackHole [
^false.
]

{ #category : 'testing' }
TileEffect >> isHyperGravity [
^false.
]

{ #category : 'testing' }
TileEffect >> isHyperJump [

^false.
]

{ #category : 'testing' }
TileEffect >> isMoonWalk [
^false.
]

{ #category : 'accessing' }
TileEffect >> position [
	^ self subclassResponsibility
]

{ #category : 'validating' }
TileEffect >> validateCreationIn: boardSize and: maximumRolledNumber [ 
	^ self subclassResponsibility
]
