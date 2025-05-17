"
Class: SpaceShip
                                                                                                    
Class SpaceShip
"
Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'currentPosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShip class >> inInitialPosition: aPosition [

	^ self new initializePosition: aPosition
]

{ #category : 'accessing' }
SpaceShip >> currentPosition [

	^ currentPosition
]

{ #category : 'initialization' }
SpaceShip >> initializePosition: aPosition [

	currentPosition := aPosition
]

{ #category : 'action' }
SpaceShip >> rolls: dices [

	dices do: [ :aDice |
		currentPosition := currentPosition + aDice rolledNumber ] 
]

{ #category : 'action' }
SpaceShip >> teletransportsTo: aWormHoleSquare [

	currentPosition := aWormHoleSquare
]
