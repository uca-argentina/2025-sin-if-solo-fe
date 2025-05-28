Class {
	#name : 'TileEffectDistributor',
	#superclass : 'Object',
	#instVars : [
		'board',
		'tileEffectsByPosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
TileEffectDistributor >> initalizeWith: aBoard [
	board := aBoard.
	tileEffectsByPosition := Dictionary new.
]
