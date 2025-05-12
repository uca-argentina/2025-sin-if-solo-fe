"
La clase Wormhole nos permite crear y transportar la nave en el caso de que este en la posicion del Wormhole
"
Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'pointA',
		'pointB'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Wormhole class >> from: aPosition to: anotherPosition [
	^ self new
		initializeFrom: aPosition to: anotherPosition.
]

{ #category : 'initialize' }
Wormhole >> initializeFrom: aPosition to: anotherPosition [
	pointA := aPosition.
	pointB := anotherPosition.
]

{ #category : 'transportation' }
Wormhole >> transportFrom: aPosition [
	
	aPosition = pointA ifTrue: [ ^ pointB ].
	aPosition = pointB ifTrue: [ ^ pointA ].
	
	^ aPosition
]
