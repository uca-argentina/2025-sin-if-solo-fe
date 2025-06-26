"
Abstract class for Cards
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'abstract' }
Card >> applyEffectTo: spaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [
	self subclassResponsibility.
]

{ #category : 'action' }
Card >> changeTo: anImplementation [
	self subclassResponsibility.
]

{ #category : 'abstract' }
Card >> isInstantaneous [
	self subclassResponsibility.
]

{ #category : 'testing' }
Card >> isLastBeingPlayedIn: aBoard [
	self subclassResponsibility.
]

{ #category : 'abstract' }
Card >> isPermanent [
	self subclassResponsibility.
]
