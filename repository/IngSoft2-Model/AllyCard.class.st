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

aBoard hasAnAlianceFrom:spaceShip and:spaceShipToTeamUp.


]

{ #category : 'action' }
AllyCard >> changeTo: anImplementation [

spaceShipToTeamUp:= anImplementation .
]

{ #category : 'initialization' }
AllyCard >> initializeAllyCardTeamsUpWith:aSpaceShip [
spaceShipToTeamUp:=aSpaceShip .

]

{ #category : 'testing' }
AllyCard >> isInstantaneous [
^false.
]

{ #category : 'testing' }
AllyCard >> isLastBeingPlayedIn:aBoard [

aBoard upDateLastCardPlayed: self.
]

{ #category : 'testing' }
AllyCard >> isPermanent [
^true.
]
