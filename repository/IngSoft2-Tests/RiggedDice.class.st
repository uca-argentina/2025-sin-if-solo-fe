"
""La clase Dado permite crear un dado de N caras y lanzarlo para obtener un numero dentro del rango""
"
Class {
	#name : 'RiggedDice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces',
		'numbersToBeRolles'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
RiggedDice class >> hasAtLeastOneFace:aNumber [
 (aNumber negative or: aNumber =0 )ifTrue: [ 
        Error signal: 'A Dice has to have at least 1 face']
]

{ #category : 'initialization' }
RiggedDice class >> withNumberOfFaces:aNumber [
self hasAtLeastOneFace:aNumber.
^self new initializeNumberOfFaces: aNumber .
]

{ #category : 'initialization' }
RiggedDice >> initializeNumberOfFaces: aNumber [

	numberOfFaces := aNumber
]

{ #category : 'accessing' }
RiggedDice >> maximumFace [
^numberOfFaces.

]

{ #category : 'accessing' }
RiggedDice >> numberJustRolled [
^numbersToBeRolles last.
]

{ #category : 'accessing' }
RiggedDice >> numberOfFaces [

	^ numberOfFaces
]

{ #category : 'accessing' }
RiggedDice >> rolledNumber [
    | nextNumber |

    nextNumber := numbersToBeRolles first.
    numbersToBeRolles add: nextNumber.
    numbersToBeRolles removeFirst.
    ^ nextNumber
]

{ #category : 'initialization' }
RiggedDice >> setNumbersProvider: numbersToRoll [
numbersToBeRolles := OrderedCollection new.
numbersToBeRolles addAll: numbersToRoll.



]
