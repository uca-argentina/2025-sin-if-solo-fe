Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormholeTest >> testWormholeHasEndAt [

	| validate |
	validate := Wormhole from: 3 to: 9.
	
	self assert: ((validate hasEndAt: 9) and: (validate hasEndAt: 3)).
]

{ #category : 'tests' }
WormholeTest >> testWormholePointToPoint [
	
	| validate |
	validate := Wormhole from: 2 to: 10.
	
	self assert: (validate instVarNamed: 'pointA') equals: 2.
	self assert: (validate instVarNamed: 'pointB') equals: 10.
	
	
]

{ #category : 'tests' }
WormholeTest >> testWormholeReturnsOtherSide [
	
	| wormhole otherWormhole|
	wormhole := Wormhole from: 2 to: 10.
	otherWormhole := Wormhole from: 10 to: 2.
	
	self assert: (wormhole transportFrom: 2) equals: 10.
	self assert: (otherWormhole transportFrom: 10) equals: 2.
	
]
