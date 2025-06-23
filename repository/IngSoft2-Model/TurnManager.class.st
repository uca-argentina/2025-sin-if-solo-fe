"
A Turn Manager
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'spaceShipsInOrder',
		'nextSpaceShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
TurnManager class >> withOrder: arg1 [

	| tmp1 |
	tmp1 := OrderedCollection withAll: arg1.
	^ self new initializeTurnManager: tmp1
]

{ #category : 'initialization' }
TurnManager >> initializeTurnManager: aOrderOfSpaceShips [
spaceShipsInOrder:=aOrderOfSpaceShips. 
nextSpaceShip := spaceShipsInOrder at:1.
]

{ #category : 'accessing' }
TurnManager >> spaceShipWhoseTurnItIsFrom: spaceShips [

"| spaceShipToPlay |
spaceShipToPlay := spaceShips first."

^ spaceShips detect: [ :spaceShip | spaceShip name= nextSpaceShip name].

]

{ #category : 'action' }
TurnManager >> updateTurn:someSpaceShips [

    nextSpaceShip := spaceShipsInOrder first.
    spaceShipsInOrder add: nextSpaceShip.
    spaceShipsInOrder removeFirst.

  
]
