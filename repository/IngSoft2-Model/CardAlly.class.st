"
AllyCard

"
Class {
	#name : 'CardAlly',
	#superclass : 'Card',
	#instVars : [
		'spaceShipToTeamUp'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardAlly class >> teamsUpWith: aSpaceShip [

	^ self new initializationFor: aSpaceShip
]

{ #category : 'abstract' }
CardAlly >> applyEffectTo: spaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [

	game hasAnAlianceFrom: spaceShip and: spaceShipToTeamUp
]

{ #category : 'action' }
CardAlly >> changeTo: anImplementation [

	^ self class teamsUpWith: anImplementation.
]

{ #category : 'initialization' }
CardAlly >> initializationFor: aSpaceShip [

	permanent := true.
	instantaneous := false.

	spaceShipToTeamUp := aSpaceShip
]

{ #category : 'testing' }
CardAlly >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self
]
