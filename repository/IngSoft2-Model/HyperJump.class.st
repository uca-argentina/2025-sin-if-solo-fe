"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'HyperJump',
	#superclass : 'TileEffect',
	#instVars : [
		'parsecDestinations'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperJump class >> forBoardWithLength: boardLength [
	^ self new initializeWithBoardLength: boardLength.
	
]

{ #category : 'instance creation' }
HyperJump class >> initializeWithBoardLength: boardLength [
	super initialize.
	self calculateParsecDistribution: boardLength.
	^ self.
]

{ #category : 'action' }
HyperJump >> applyConsequenceTo: aSpaceShip [
]

{ #category : 'abstract' }
HyperJump >> applyTo: aSpaceShip on: aGameBoard [
	| destination |
	
	destination := parsecDestinations at: 0.
	aSpaceShip moveTo: destination.
]

{ #category : 'calculation' }
HyperJump >> calculateParsecDistribution: boardLength [
	| jump numberOfHyperJumps |
	
	numberOfHyperJumps := (boardLength*0.08) rounded .
	
	jump := (boardLength/numberOfHyperJumps) rounded .
	
	parsecDestinations := (1 to: numberOfHyperJumps) collect: [ :i | i * jump ].

	
]

{ #category : 'creation' }
HyperJump >> initializeWithBoardLength: boardLength [
	super initialize.
	self calculateParsecDistribution: boardLength.
	^ self.
]

{ #category : 'accessing' }
HyperJump >> parsecDestinations [
	^ parsecDestinations 
]
