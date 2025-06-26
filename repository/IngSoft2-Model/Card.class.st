"
Abstract class for Cards
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#instVars : [
		'permanent',
		'instantaneous'
	],
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

{ #category : 'initialization' }
Card >> initializationFor: aSomething [

	self subclassResponsibility
]

{ #category : 'getState' }
Card >> isInstantaneous [

	^ instantaneous.
]

{ #category : 'testing' }
Card >> isLastBeingPlayedIn: aBoard [
	self subclassResponsibility.
]

{ #category : 'getState' }
Card >> isPermanent [

	^ permanent.
]
