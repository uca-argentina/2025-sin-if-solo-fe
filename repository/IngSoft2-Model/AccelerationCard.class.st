"
A
"
Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#instVars : [
		'accelerationIncrement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AccelerationCard class >> withIncrement: aNumber [

^self new initializeAccelerationCard: aNumber.
]

{ #category : 'action' }
AccelerationCard >> applyEffectTo:spaceShips with: dices [

dices do:[:dice|dice adjustRolledNumberBy: accelerationIncrement]. 
]

{ #category : 'initialization' }
AccelerationCard >> initializeAccelerationCard: aNumber [

accelerationIncrement:= aNumber.
]
