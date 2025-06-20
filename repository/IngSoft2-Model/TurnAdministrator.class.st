"
Class: TurnAdministrator
"
Class {
	#name : 'TurnAdministrator',
	#superclass : 'Object',
	#instVars : [
		'numberOfOrderToPlay',
		'numberOfLostTurns'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
TurnAdministrator class >> withAnIndex: index [

^self new initializeWithAnIndex: index.
]

{ #category : 'validating' }
TurnAdministrator >> comesFirstThanThe:oponentSpaceship [
^numberOfOrderToPlay < oponentSpaceship turnOrder.
]

{ #category : 'initialization' }
TurnAdministrator >> initializeWithAnIndex: index [

numberOfOrderToPlay:= index.
numberOfLostTurns:=0. 
]

{ #category : 'validating' }
TurnAdministrator >> isAvailableToPlay [
^numberOfLostTurns=0.
]

{ #category : 'action' }
TurnAdministrator >> lostTurnsVerifier [
	numberOfLostTurns = 2 ifFalse: [ ^ self ].
	numberOfLostTurns := 0.
]

{ #category : 'action' }
TurnAdministrator >> roundLosed [

numberOfLostTurns := numberOfLostTurns + 1.
]

{ #category : 'accessing' }
TurnAdministrator >> turnOrder [

^numberOfOrderToPlay 
]
