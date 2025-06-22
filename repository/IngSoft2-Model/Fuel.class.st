"
Class: Fuel

"
Class {
	#name : 'Fuel',
	#superclass : 'Object',
	#instVars : [
		'currentFuel',
		'initialFuel',
		'fuelPartner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
Fuel class >> withAnAmount: aFuelAmount [

^self new initializeWithAnAmount: aFuelAmount 
]

{ #category : 'action' }
Fuel >> consume: aDistance [


		"	currentFuel >= aDistance
				ifTrue: [ currentFuel := currentFuel - aDistance ] 
				ifFalse: [
					((currentFuel + (fuelPartner current)) >= aDistance )ifTrue:[
					| fuelNeeded |
					fuelNeeded := aDistance - currentFuel.
					currentFuel := 0.
					fuelPartner giveFuel: fuelNeeded ]]"
		

	(currentFuel > aDistance )
		ifTrue: [ currentFuel := currentFuel - aDistance ]
		ifFalse: [
		
			currentFuel :=0.

			fuelPartner giveFuel: aDistance ]
]

{ #category : 'accessing' }
Fuel >> current [
^currentFuel 
]

{ #category : 'testing' }
Fuel >> hasFuelToPlay [



  ^ (self isBiggerThanCero or: fuelPartner isBiggerThanCero ).

]

{ #category : 'initialization' }
Fuel >> initializeWithAnAmount: aFuelAmount [ 
currentFuel:=aFuelAmount .
initialFuel:=aFuelAmount.
fuelPartner:=EmptyFule new.

]

{ #category : 'testing' }
Fuel >> isBiggerThanCero [
^currentFuel >0.
]

{ #category : 'action' }
Fuel >> recharge [
currentFuel := initialFuel .
]

{ #category : 'action' }
Fuel >> sharesFuleWith:anotherSystem [ 
fuelPartner:=anotherSystem .


]

{ #category : 'validating' }
Fuel >> validateCurrentFuleOf: aSpaceShip [

( self hasFuelToPlay) ifTrue: [ ^ self ].
    aSpaceShip moveTo: 0 consuming:0.
    currentFuel := 0.
]
