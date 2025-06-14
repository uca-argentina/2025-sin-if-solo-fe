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

{ #category : 'initialization' }
TurnAdministrator >> initializeWithAnIndex: index [

numberOfOrderToPlay:= index.
numberOfLostTurns:=0. 
]

{ #category : 'accessing' }
TurnAdministrator >> numberOfLostTurns [ 

^numberOfLostTurns 
]

{ #category : 'accessing' }
TurnAdministrator >> turnOrder [

^numberOfOrderToPlay 
]
