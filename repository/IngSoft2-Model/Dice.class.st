"
""La clase Dado permite crear un dado de N caras y lanzarlo para obtener un numero dentro del rango""
"
Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces',
		'rolledNumber'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dice class >> withNumberOfFaces: aNumber [
	^self new initializeNumberOfFaces: aNumber.
]

{ #category : 'initialization' }
Dice >> initializeNumberOfFaces: aNumber [
	numberOfFaces := aNumber
]

{ #category : 'accessing' }
Dice >> numberOfFaces [
	^numberOfFaces 
]

{ #category : 'instance creation' }
Dice >> rollWith: aDiceNumberProvider [
	rolledNumber:=aDiceNumberProvider
]

{ #category : 'accessing' }
Dice >> rolledNumber [
	^rolledNumber
]
