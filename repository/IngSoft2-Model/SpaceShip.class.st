"
Class: SpaceShip
                                                                                                    
Class SpaceShip
"
Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'currentPosition',
		'originalSpaceShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShip class >> inInitialPosition: aPosition [

	^ self new initializePosition: aPosition
]

{ #category : 'accessing' }
SpaceShip >> asOriginalSpaceShip [
^originalSpaceShip.
]

{ #category : 'accessing' }
SpaceShip >> currentPosition [

	^ currentPosition
]

{ #category : 'initialization' }
SpaceShip >> initializePosition: aPosition [

	currentPosition := aPosition
]

{ #category : 'testing' }
SpaceShip >> isCopyOf: aPlayer [
    ^ originalSpaceShip == aPlayer.
]

{ #category : 'action' }
SpaceShip >> moves: rolledNumber [

	currentPosition := currentPosition
	                   +
	                   rolledNumber.
]

{ #category : 'accessing' }
SpaceShip >> originalSpaceShip: aPlayer [
    originalSpaceShip := aPlayer.
]

{ #category : 'action' }
SpaceShip >> teletransportsTo: aWormHoleSquare [

	currentPosition := aWormHoleSquare
]
