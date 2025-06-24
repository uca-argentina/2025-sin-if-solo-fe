"
A
"
Class {
	#name : 'CardAcceleration',
	#superclass : 'Object',
	#instVars : [
		'accelerationIncrement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
CardAcceleration class >> isPositive: aNumber [

(aNumber<0) ifTrue: [ Error signal: 'A CardAcceleration has to have a positive increment'] 
]

{ #category : 'initialization' }
CardAcceleration class >> withIncrement: aNumber [

self isPositive: aNumber.

^self new initializeAccelerationCard: aNumber.
]

{ #category : 'action' }
CardAcceleration >> applyEffectTo: spaceShip  with: dices in:aBoard [

aBoard move: spaceShip forwardBy: accelerationIncrement.


]

{ #category : 'action' }
CardAcceleration >> changeTo: anImplementation [
   ^ (self class) withIncrement: anImplementation.
]

{ #category : 'initialization' }
CardAcceleration >> initializeAccelerationCard: aNumber [

accelerationIncrement:= aNumber.

]

{ #category : 'testing' }
CardAcceleration >> isInstantaneous [
^false.
]

{ #category : 'testing' }
CardAcceleration >> isLastBeingPlayedIn:aBoard [

aBoard upDateLastCardPlayed: self.
]

{ #category : 'testing' }
CardAcceleration >> isPermanent [
^true.
]
