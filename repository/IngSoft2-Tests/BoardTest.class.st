Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test1WhenTheBoardIsInitializeItHasACertainNumberOfSquares [

| aBoard |
aBoard:= Board withNumberOfSquares: 64.

self assert: aBoard numberOfSquares equals: 64.


]
