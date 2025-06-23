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


]

{ #category : 'action' }
AccelerationCard >> changeTo: anImplementation [
   ^ (self class) withIncrement: anImplementation.
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
AccelerationCard >> isLastBeingPlayedIn:aBoard [

aBoard upDateLastCardPlayed: self.
]

{ #category : 'testing' }
AccelerationCard >> isPermanent [
^true.
]
