Class {
	#name : 'TileTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'TileDistributorTest' }
TileTest >> testReturnsADictionary [

	| aDistributor aBoard |
	aDistributor := TileEffectDistributor new.
	aBoard := BoardGame new.

	aDistributor initalizeWith: aBoard.

	self assert: (aDistributor instVarNamed: 'tileEffectsByPosition') class equals: Dictionary .
]

{ #category : 'tests' }
TileTest >> testTileEffectPolymorphism [

	| effects aBoard aSpaceShip results|
	
	effects := { 
	BlackHole new.
	MoonWalk new.
	HyperGravity new.
	HyperJump new.
	AtomicBomb new.
	}.
	
	aBoard := BoardGame new.
	aSpaceShip := SpaceShip new.
	results := effects collect: [:effect | 
		(effect applyTo: aSpaceShip on: aBoard) asString 
	].

	self assert: (results asSet size > 1).
]
