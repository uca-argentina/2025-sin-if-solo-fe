"
RedoCard
"
Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#instVars : [
		'spaceShipToApplyEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RedoCard class >> for: aSpaceShip [

^self new initializationFor:aSpaceShip.
]

{ #category : 'action' }
RedoCard >> applyEffectTo: spaceShip with: dices in: aBoard [

aBoard applyRepeatEffectTo:spaceShipToApplyEffect.

]

{ #category : 'verification' }
RedoCard >> chosenOnIsIn:cardsInGame [
^true.
]

{ #category : 'initialization' }
RedoCard >> initializationFor:aSpaceShip [

spaceShipToApplyEffect:=aSpaceShip.
]

{ #category : 'testing' }
RedoCard >> isInstantaneous [

^false.
]
