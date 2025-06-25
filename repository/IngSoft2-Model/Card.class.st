"
CARD
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validating' }
Card >> isInstantaneous [
	^ self subclassResponsibility
]

{ #category : 'validating' }
Card >> isPermanent [
	^ self subclassResponsibility
]
