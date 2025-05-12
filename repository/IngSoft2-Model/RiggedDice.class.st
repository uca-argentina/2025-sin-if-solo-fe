"
""La clase Dado permite crear un dado de N caras y lanzarlo para obtener un numero dentro del rango""
"
Class {
	#name : 'RiggedDice',
	#superclass : 'Dice',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
RiggedDice >> numberOfFaces [

	^ numberOfFaces
]

{ #category : 'instance creation' }
RiggedDice >> rollWith: aDiceNumberProvider [

	rolledNumber := aDiceNumberProvider
]

{ #category : 'accessing' }
RiggedDice >> rolledNumber [

	^ rolledNumber
]
