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

{ #category : 'testing' }
Dice class >> hasAtLeastOneFace:aNumber [
 (aNumber negative or: aNumber =0 )ifTrue: [ 
		Error signal: 'A Dice has to have at least 1 face']
]

{ #category : 'instance creation' }
Dice class >> withNumberOfFaces: aNumber [
	self hasAtLeastOneFace:aNumber .
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
	rolledNumber:=aDiceNumberProvider.
]

{ #category : 'accessing' }
Dice >> rolledNumber [
	^rolledNumber
]
