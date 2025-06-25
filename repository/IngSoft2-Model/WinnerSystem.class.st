"
Class: WinnerSystem

"
Class {
	#name : 'WinnerSystem',
	#superclass : 'Object',
	#instVars : [
		'lapsToWin',
		'spaceShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
WinnerSystem class >> withMaximunLaps: aNumberOfLaps [

^self new intializeWinnerSystemWith: aNumberOfLaps .

]

{ #category : 'testing' }
WinnerSystem >> hasReachedWinningLapCount: aLapCount [

	^ aLapCount = lapsToWin
]

{ #category : 'initialization' }
WinnerSystem >> intializeWinnerSystemWith: aNumberOfLaps [

	lapsToWin := aNumberOfLaps
]

{ #category : 'sorting' }
WinnerSystem >> ranking [

	^ spaceShips sort: [ :aSpaceShips :oponentSpaceship |
		  aSpaceShips ranksHigherThan: oponentSpaceship ]
]

{ #category : 'accessing' }
WinnerSystem >> theBronzeWinnerIs [

	^ self ranking third
]

{ #category : 'accessing' }
WinnerSystem >> theGoldWinnerIs [

	^ self ranking first
]

{ #category : 'accessing' }
WinnerSystem >> theSilverWinnerIs [

	^ self ranking second
]

{ #category : 'validating' }
WinnerSystem >> thereIsAWinner [

	^ spaceShips anySatisfy: [ :spaceShip |
		  self hasReachedWinningLapCount: spaceShip currentLap ]
]

{ #category : 'assignments' }
WinnerSystem >> withPotentialWinner: aSpaceShips [

	spaceShips := aSpaceShips
]
