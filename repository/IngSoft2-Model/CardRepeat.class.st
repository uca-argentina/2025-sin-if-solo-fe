"
Repeta Card

"
Class {
	#name : 'CardRepeat',
	#superclass : 'Object',
	#instVars : [
		'spaceShipToAffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardRepeat class >> for: aSpaceShip [
^self new initializeReleatFor:aSpaceShip.
]

{ #category : 'adding' }
CardRepeat >> applyEffectTo: spaceShip with: dices in: aBoard [
"
aBoard applyLastEffectMadeTo:spaceShipToAffect."
]

{ #category : 'verification' }
CardRepeat >> chosenOnIsIn: cardsInGame [
^true.
]

{ #category : 'initialization' }
CardRepeat >> initializeReleatFor:aSpaceShip [

spaceShipToAffect:=aSpaceShip .
]

{ #category : 'testing' }
CardRepeat >> isInstantaneous [
^true.
]

{ #category : 'testing' }
CardRepeat >> isLastBeingPlayedIn:aBoard [

aBoard upDateLastCardPlayed: self.
]

{ #category : 'testing' }
CardRepeat >> isPermanent [
^false.

]
