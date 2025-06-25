"
RedoCard
"
Class {
	#name : 'CardRedo',
	#superclass : 'Object',
	#instVars : [
		'anInicialization'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardRedo class >> for: aSpaceShip [

	^ self new initializationFor: aSpaceShip
]

{ #category : 'adding' }
CardRedo >> addEffectRepetedTo: aBoard by: spaceShip the: lastCardPlay [

	| aCard |
	aCard := lastCardPlay changeTo: anInicialization.

	spaceShip equipWith: aCard.
	aBoard with: spaceShip throws: aCard
]

{ #category : 'initialization' }
CardRedo >> initializationFor: aSpaceShip [

	anInicialization := aSpaceShip
]

{ #category : 'testing' }
CardRedo >> isInstantaneous [

	^ false
]

{ #category : 'testing' }
CardRedo >> isPermanent [

	^ false
]
