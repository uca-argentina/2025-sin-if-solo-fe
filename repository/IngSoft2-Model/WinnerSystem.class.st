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

{ #category : 'testing' }
WinnerSystem >> hasReachedWinningLapCount:aLapCount [

^(aLapCount =lapsToWin )
]

{ #category : 'initialization' }
WinnerSystem >> intializeWinnerSystemWith: aNumberOfLaps [

lapsToWin := aNumberOfLaps .
]

{ #category : 'sorting' }
WinnerSystem >> ranking [
spaceShips sort: [:spaceShip1 :spaceShip2 | 
  (spaceShip1 currentLap > spaceShip2 currentLap) 
  or: [(spaceShip1 currentLap = spaceShip2 currentLap) and: [spaceShip1 currentPosition > spaceShip2 currentPosition]]].
^spaceShips .
]

{ #category : 'accessing' }
WinnerSystem >> theBronzeWinnerIs [
^( self ranking third)asOriginalSpaceShip.
]

{ #category : 'accessing' }
WinnerSystem >> theGoldWinnerIs [
    ^ ( self ranking first) asOriginalSpaceShip.
]

{ #category : 'accessing' }
WinnerSystem >> theSilverWinnerIs [
^(self ranking second) asOriginalSpaceShip.
]

{ #category : 'validating' }
WinnerSystem >> thereIsAWinner [
 ^ spaceShips anySatisfy: [:spaceShip | self hasReachedWinningLapCount:(spaceShip currentLap )]
]

{ #category : 'assignments' }
WinnerSystem >> withPotentialWinner: aSpaceShips [

spaceShips:= aSpaceShips.


]
