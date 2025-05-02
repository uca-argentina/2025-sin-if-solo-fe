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

{ #category : 'accessing' }
SpaceShip >> currentPosition [
^currentPosition .
]

{ #category : 'initialization' }
SpaceShip >> initializePosition:aPosition [
currentPosition:=aPosition.
]

{ #category : 'action' }
SpaceShip >> rolls: dices [

dices do:[:aDice|currentPosition :=currentPosition +aDice rolledNumber]


]
