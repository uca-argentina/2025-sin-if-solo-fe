"
AllyCard

"
Class {
	#name : 'CardAlly',
	#superclass : 'Object',
	#instVars : [
		'spaceShipToTeamUp'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardAlly class >> teamsUpWith: aSpaceShip [

	^ self new initializeAllyCardTeamsUpWith: aSpaceShip
]

{ #category : 'action' }
CardAlly >> applyEffectTo: spaceShip with: dicesInGameBoard inGame: game onABoard: aBoard [

	game hasAnAlianceFrom: spaceShip and: spaceShipToTeamUp
]

{ #category : 'action' }
CardAlly >> changeTo: anImplementation [

	^ self class teamsUpWith: anImplementation
]

{ #category : 'initialization' }
CardAlly >> initializeAllyCardTeamsUpWith: aSpaceShip [

	spaceShipToTeamUp := aSpaceShip
]

{ #category : 'testing' }
CardAlly >> isLastBeingPlayedIn: aBoard [

	aBoard upDateLastCardPlayed: self
]

{ #category : 'testing' }
CardAlly >> isPermanent [

	^ true
]
