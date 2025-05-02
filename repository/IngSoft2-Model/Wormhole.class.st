Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'positionX',
		'positionY'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Wormhole class >> withPositionX: anX withPositionY: anY [
	^self new initializePositionX: anX initializePositionY: anY.
]

{ #category : 'initialization' }
Wormhole >> initializePositionX: anX initializePositionY: anY [
	positionX:=anX .
	positionY:=anY .
]

{ #category : 'accessing' }
Wormhole >> position [
	^'X: ', positionX asString ,' Y: ', positionY asString .
]
