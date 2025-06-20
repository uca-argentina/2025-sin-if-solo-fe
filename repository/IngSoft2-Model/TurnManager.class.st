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
TurnManager class >> withOrder: spaceShipsInOrderToPlay [
|spaceShips|
spaceShips := OrderedCollection withAll: spaceShipsInOrderToPlay.
	^ self new initializeTurnManager: spaceShips
]

{ #category : 'initialization' }
TurnManager >> initializeTurnManager: aOrderOfSpaceShips [
spaceShipsInOrder:=aOrderOfSpaceShips .
]

{ #category : 'action' }
TurnManager >> spaceShipWhoseTurnItIsFrom:spaceShips [
 | nextSpaceShip |

    nextSpaceShip := spaceShipsInOrder first.
    spaceShipsInOrder add: nextSpaceShip.
    spaceShipsInOrder removeFirst.

    ^ spaceShips detect: [ :spaceShip | spaceShip name= nextSpaceShip name].
]
