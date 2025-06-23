"
RedoCard
"
Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#instVars : [
		'anInicialization'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RedoCard class >> for: aSpaceShip [

^self new initializationFor:aSpaceShip.
]

{ #category : 'adding' }
RedoCard >> addEffectRepetedTo:aBoard by:spaceShip the:lastCardPlay [

|aCard|
 aCard := lastCardPlay changeTo: anInicialization .

spaceShip equipWith: aCard .
aBoard with: spaceShip throws: aCard .
]

{ #category : 'action' }
RedoCard >> changeTo: anImplementation [
   anInicialization := anImplementation.
   ^self
]

{ #category : 'verification' }
RedoCard >> chosenOnIsIn:cardsInGame [
^true.
]

{ #category : 'initialization' }
RedoCard >> initializationFor:aSpaceShip [

anInicialization:=aSpaceShip.

]

{ #category : 'testing' }
RedoCard >> isInstantaneous [

^false.
]

{ #category : 'testing' }
RedoCard >> isLastBeingPlayedIn:aBoard [

aBoard upDateLastCardPlayed: self.
]

{ #category : 'testing' }
RedoCard >> isPermanent [
^false.

]
