"
ccccancellationnn
"
Class {
	#name : 'CancellationCard',
	#superclass : 'Object',
	#instVars : [
		'cardToCancel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CancellationCard class >> for: aCard [

^self new initializationFor:aCard.
]

{ #category : 'action' }
CancellationCard >> applyEffectTo: spaceShipMoving with: dicesInGameBoard inGame: game onABoard: aBoard [

	game remove: cardToCancel
]

{ #category : 'action' }
CancellationCard >> changeTo: anImplementation [

	^ self class for: anImplementation
]

{ #category : 'verification' }
CancellationCard >> chosenOnIsIn: cardsInGame [

	^ cardsInGame includes: cardToCancel
]

{ #category : 'initialization' }
CancellationCard >> initializationFor: aCard [

	cardToCancel := aCard
]

{ #category : 'testing' }
CancellationCard >> isInstantaneous [

	^ true
]

{ #category : 'testing' }
CancellationCard >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self
]

{ #category : 'testing' }
CancellationCard >> isPermanent [

	^ false
]
