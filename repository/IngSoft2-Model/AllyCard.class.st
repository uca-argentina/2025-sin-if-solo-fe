"
AllyCard

"
Class {
	#name : 'AllyCard',
	#superclass : 'Object',
	#instVars : [
		'spaceShipToTeamUp'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AllyCard class >> teamsUpWith: aSpaceShip [
^self new initializeAllyCardTeamsUpWith:aSpaceShip.
]

{ #category : 'action' }
AllyCard >> applyEffectTo: spaceShip  with: dicesInGameBoard in:aBoard [
"spaceShip sharesFuleWith:spaceShipToTeamUp .
spaceShipToTeamUp sharesFuleWith:spaceShip ."
aBoard hasAnAlianceFrom:spaceShip and:spaceShipToTeamUp.

]

{ #category : 'initialization' }
AllyCard >> initializeAllyCardTeamsUpWith:aSpaceShip [
spaceShipToTeamUp:=aSpaceShip .
]

{ #category : 'testing' }
AllyCard >> isInstantaneous [
^false.
]
