"
Abstract Class for several tile effects
"
Class {
	#name : 'TileEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'abstract' }
TileEffect >> applyTo: aSpaceShip on: aGameBoard [
	self subclassResponsibility.
]
