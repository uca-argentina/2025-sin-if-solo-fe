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
AccelerationCard >> applyEffectTo: spaceShip  with: dices in:aBoard [

aBoard move: spaceShip forwardBy: accelerationIncrement.
aBoard upDateLastCardPlayed:self.

]

{ #category : 'initialization' }
AccelerationCard >> initializeAccelerationCard: aNumber [

accelerationIncrement:= aNumber.
]

{ #category : 'testing' }
AccelerationCard >> isInstantaneous [
^false.
]

{ #category : 'testing' }
AccelerationCard >> isPermanent [
^true.
]
