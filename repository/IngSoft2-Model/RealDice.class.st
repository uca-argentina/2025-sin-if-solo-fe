"
A Real Dice  that rolls a random number
"
Class {
	#name : 'RealDice',
	#superclass : 'Dice',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
RealDice >> rolledNumber [
rolledNumber :=(1 to: numberOfFaces) atRandom.
^rolledNumber .

]
