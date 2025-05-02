Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
WormholeTest >> test1WhenTheWormholeIsInitializeItHasAPosition [
| aWormhole |


aWormhole := Wormhole withPositionX: 10 withPositionY: 20.

self assert: aWormhole position equals: 'X: 10 Y: 20'.




]
