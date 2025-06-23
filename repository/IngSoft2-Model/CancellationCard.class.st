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
CancellationCard >> applyEffectTo: spaceShip  with: dices in:aBoard [

aBoard remove: cardToCancel.


]

{ #category : 'action' }
CancellationCard >> changeTo: anImplementation [

 ^ (self class) for: anImplementation.
]

{ #category : 'accessing' }
CancellationCard >> choosenCard [

^cardToCancel.
]

{ #category : 'verification' }
CancellationCard >> chosenOnIsIn:cardsInGame [
^cardsInGame includes: cardToCancel.
]

{ #category : 'initialization' }
CancellationCard >> initializationFor:aCard [

cardToCancel:=aCard.

]

{ #category : 'testing' }
CancellationCard >> isInstantaneous [
^true.
]

{ #category : 'testing' }
CancellationCard >> isLastBeingPlayedIn:aBoard [

aBoard upDateLastCardPlayed: self.
]

{ #category : 'testing' }
CancellationCard >> isPermanent [
^false.
]
