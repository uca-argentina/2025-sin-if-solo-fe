"
Reward Distribution 
"
Class {
	#name : 'RewardDistribution',
	#superclass : 'Object',
	#instVars : [
		'maximumFuelProbability',
		'decreaseFuelProbability',
		'rewards',
		'sample'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'building' }
RewardDistribution >> buidFor: probabilitySampling [

	sample := probabilitySampling.

	rewards := (1 to: sample) collect: [ :i |
		           self rewardFor: Random new next ].
	^ rewards
]

{ #category : 'instance creation' }
RewardDistribution >> for: aSpaceShip with: dices [

	| reward nextRolledNumer maxRolledNumber |
	nextRolledNumer := (dices collect: [ :dice | dice numberJustRolled ])
		                   sum.
	maxRolledNumber := (dices collect: [ :dice | dice maximumFace ]) sum.

	nextRolledNumer = maxRolledNumber ifFalse: [ ^ self ].
	reward := self rewardFor: Random new next.
	reward applyTo: aSpaceShip
]

{ #category : 'building' }
RewardDistribution >> forDecreaseFuel: aProbability [

	decreaseFuelProbability := aProbability
]

{ #category : 'building' }
RewardDistribution >> forRestartFuel: aProbability [

	maximumFuelProbability := aProbability
]

{ #category : 'accessing' }
RewardDistribution >> percentageOf: aReward [

	^ (rewards count: [ :element | element isKindOf: aReward ])
	  / rewards size asFloat
]

{ #category : 'action' }
RewardDistribution >> rewardFor: aRandomProbability [

	aRandomProbability < maximumFuelProbability ifTrue: [
		^ RestartFuelReward new ].
	aRandomProbability
	< (maximumFuelProbability + decreaseFuelProbability) ifTrue: [
		^ DecreaseFuelReward new ].

	^ NoReward new
]
