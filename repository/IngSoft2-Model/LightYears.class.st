"
Light year
"
Class {
	#name : 'LightYears',
	#superclass : 'Object',
	#instVars : [
		'distance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
LightYears class >> distance: aDistance [

	^ self new initializeLightYears: aDistance
]

{ #category : 'action' }
LightYears >> asParsecs [

	^ (distance / 3) floor
]

{ #category : 'accessing' }
LightYears >> distance [

	^ distance
]

{ #category : 'initialization' }
LightYears >> initializeLightYears: aDistance [

	distance := aDistance
]
