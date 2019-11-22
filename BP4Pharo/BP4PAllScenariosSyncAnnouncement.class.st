Class {
	#name : #BP4PAllScenariosSyncAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'scenariosStates'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PAllScenariosSyncAnnouncement class >> scenariosStates: allScenariosStates [
	"create a new announcement of allScenariosSync with allScenariosStates"

	^ self new scenariosStates: allScenariosStates
]

{ #category : #accessing }
BP4PAllScenariosSyncAnnouncement >> scenariosStates [
	^ scenariosStates
]

{ #category : #creation }
BP4PAllScenariosSyncAnnouncement >> scenariosStates: allScenariosStates [
	scenariosStates := allScenariosStates 
]
