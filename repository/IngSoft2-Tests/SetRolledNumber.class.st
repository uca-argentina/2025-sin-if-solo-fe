"
""Esta clase se utiliza para configurar que numero saldra en el dado, con el fin de que los tests funcionen correctamente; de este modo aseguramos que el comportamiento del código sea determinista""

"
Class {
	#name : 'SetRolledNumber',
	#superclass : 'Object',
	#instVars : [
		'aRolledNumber'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'converting' }
SetRolledNumber class >> with: aNumber [
^self new initializeWith: aNumber
]

{ #category : 'initialization' }
SetRolledNumber >> initializeWith: aNumber [
	aRolledNumber:=aNumber.
	^self
]

{ #category : 'accessing' }
SetRolledNumber >> rolledNumber [ 
^aRolledNumber
]
