"
RedoCard
"
Class {
	#name : 'CardRedo',
	#superclass : 'Card',
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

{ #category : 'abstract' }
CardRedo >> applyEffectTo: aSpaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [

	| aCard lastCard |
	lastCard := game lastCardPlayed.
	lastCard
		ifNil: [ Error signal: 'First card played cannot be a redo card!' ]
		ifNotNil: [
			aCard := lastCard changeTo: anInicialization.

			aSpaceShip equipWith: aCard.
			aBoard with: aSpaceShip throws: aCard ]
]

{ #category : 'action' }
CardRedo >> changeTo: anImplementation [
	
	^ self class for: anImplementation.
]

{ #category : 'initialization' }
CardRedo >> initializationFor: aSpaceShip [

	anInicialization := aSpaceShip
]

{ #category : 'abstract' }
CardRedo >> isInstantaneous [

	^ false
]

{ #category : 'testing' }
CardRedo >> isLastBeingPlayedIn: aBoard [
	
	^ true.
]

{ #category : 'abstract' }
CardRedo >> isPermanent [

	^ false
]
