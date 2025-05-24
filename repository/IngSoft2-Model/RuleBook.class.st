"
Class RuleBook
"
Class {
	#name : 'RuleBook',
	#superclass : 'Object',
	#instVars : [
		'lapsNumberToWin'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RuleBook >> hasReachedWinningLapCount:aLapCount [

^(aLapCount =lapsNumberToWin )
]

{ #category : 'initialization' }
RuleBook >> initializeRuleBookwith:aLapsNumberToWin [
lapsNumberToWin:=aLapsNumberToWin .
]
