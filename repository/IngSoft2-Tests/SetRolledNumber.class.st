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

{ #category : 'testing' }
SetRolledNumber class >> isBiger: aNumberToRoll than:aNumberOfFaces [
 (aNumberToRoll > aNumberOfFaces )ifTrue: [ 
		Error signal: 'The number to roll should be smaller than the number of faces']
]

{ #category : 'converting' }
SetRolledNumber class >> with: aNumber [
"NO BORRAR : no esta siendo usado pero queremos borrarlo solo el metodo en SetRolledNumber"
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
