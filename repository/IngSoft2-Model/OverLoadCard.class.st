"
OverLoad Card

"
Class {
	#name : 'OverLoadCard',
	#superclass : 'Object',
	#instVars : [
		'spaceShipToOverLoad'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
OverLoadCard class >> for: aSpaceShip [
^self new initializeOverLoadFor:aSpaceShip.
]

{ #category : 'action' }
OverLoadCard >> applyEffectTo: spaceShip with: dices in: aBoard [

|rolledNumberAdjust |
rolledNumberAdjust :=0.


(spaceShip  = spaceShipToOverLoad )ifTrue:[spaceShip goBack: 2 onBoardOfSize: (aBoard numberOfSquares ).].




]

{ #category : 'initialization' }
OverLoadCard >> initializeOverLoadFor:aSpaceShip [
spaceShipToOverLoad:=aSpaceShip .
]

{ #category : 'testing' }
OverLoadCard >> isInstantaneous [
^false.
]
