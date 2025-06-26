"
Repeta Card

"
Class {
	#name : 'CardRepeat',
	#superclass : 'Card',
	#instVars : [
		'spaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardRepeat class >> for: aSpaceShip [

	^ self new initializationFor: aSpaceShip
]

{ #category : 'action' }
CardRepeat >> applyEffectTo: aSpaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [

	game applyRepeatEffectWith: spaceship


	
]

{ #category : 'action' }
CardRepeat >> changeTo: anImplementation [

	^ self class for: anImplementation.
]

{ #category : 'verification' }
CardRepeat >> chosenOnIsIn: cardsInGame [

	^ true
]

{ #category : 'initialization' }
CardRepeat >> initializationFor: aSpaceship [

	spaceship := aSpaceship
]

{ #category : 'testing' }
CardRepeat >> isInstantaneous [

	^ true
]

{ #category : 'testing' }
CardRepeat >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self
]

{ #category : 'testing' }
CardRepeat >> isPermanent [

	^ false
]
