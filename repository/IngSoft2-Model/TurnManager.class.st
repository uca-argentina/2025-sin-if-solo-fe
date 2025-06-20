"
A Turn Manager
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'spaceShipsInOrder'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
TurnManager >> initializeTurnManager: aOrderOfSpaceShips [
spaceShipsInOrder:=aOrderOfSpaceShips .
]
