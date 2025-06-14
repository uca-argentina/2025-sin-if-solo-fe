"
Class: Fuel

"
Class {
	#name : 'Fuel',
	#superclass : 'Object',
	#instVars : [
		'currentFuel',
		'initialFuel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Fuel >> current [
^currentFuel 
]

{ #category : 'testing' }
Fuel >> hasFuel [
^currentFuel >0 
]

{ #category : 'initialization' }
Fuel >> initializeWithAnAmount: aFuelAmount [ 
currentFuel:=aFuelAmount .
initialFuel:=aFuelAmount.
]

{ #category : 'validating' }
Fuel >> validateCurrentFuleOf: aSpaceShip [

( currentFuel <= 0) ifFalse: [ ^ self ].
    aSpaceShip moveTo: 0 consuming:0.
    currentFuel := 0.
]
