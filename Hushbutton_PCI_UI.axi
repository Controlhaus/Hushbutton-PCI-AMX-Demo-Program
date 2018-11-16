PROGRAM_NAME='Hushbutton_PCI_UI'

DEFINE_CONSTANT
//Create constant for feedback timeline
INTEGER tlPCIFeedback = 1

DEFINE_VARIABLE
//Create time for feedback timeline
LONG tlPCIFeedbackTime[] = {200}

//Create variable to store selected PCI device array position
INTEGER nSelectedPCI

//Create all purpose variables
INTEGER nIndex
INTEGER nIndex2
INTEGER nEnableRingPresses

//Create device array containing all virtual PCI devices
DEV devPCIs[] =
{
    vdvPCI1,
    vdvPCI2,
    vdvPCI3
}	

//Create device channel array containing PCI device select buttons
DEVCHAN dcPCISelect[] =
{
    {dvUI1,1},
    {dvUI1,2},
    {dvUI1,3}
}         

//Create device level array containing all mute toggle image bargraphs
DEVLEV dlPCIMuteGraphic[] =
{
    {dvUI1,11},
    {dvUI1,12},
    {dvUI1,13},
    {dvUI1,14},
    {dvUI1,15},
    {dvUI1,16},
    {dvUI1,17},
    {dvUI1,18}
}	   	

//Create device channel array containing all mute toggle buttons
DEVCHAN dcPCIToggle[] =
{
    {dvUI1,11},
    {dvUI1,12},
    {dvUI1,13},
    {dvUI1,14},
    {dvUI1,15},
    {dvUI1,16},
    {dvUI1,17},
    {dvUI1,18}
}	   	

//Create device channel array containing all mute on buttons
DEVCHAN dcPCIMuteOn[] =
{
    {dvUI1,21},
    {dvUI1,22},
    {dvUI1,23},
    {dvUI1,24},
    {dvUI1,25},
    {dvUI1,26},
    {dvUI1,27},
    {dvUI1,28},
    {dvUI1,29}
}	   	

//Create device channel array containing all mute off buttons
DEVCHAN dcPCIMuteOff[] =
{
    {dvUI1,31},
    {dvUI1,32},
    {dvUI1,33},
    {dvUI1,34},
    {dvUI1,35},
    {dvUI1,36},
    {dvUI1,37},
    {dvUI1,38},
    {dvUI1,39}
}	   	

//Create device channel array containing all LED off buttons
DEVCHAN dcPCILEDOff[] =
{
    {dvUI1,41},
    {dvUI1,42},
    {dvUI1,43},
    {dvUI1,44},
    {dvUI1,45},
    {dvUI1,46},
    {dvUI1,47},
    {dvUI1,48},
    {dvUI1,49}
}	   	

//Create device channel array containing all poll buttons
DEVCHAN dcPCIPoll[] =
{
    {dvUI1,51},
    {dvUI1,52},
    {dvUI1,53},
    {dvUI1,54},
    {dvUI1,55},
    {dvUI1,56},
    {dvUI1,57},
    {dvUI1,58},
    {dvUI1,59}
}	   	

//Create device channel array containing all ring press feedback buttons
DEVCHAN dcPCIPress[] =
{
    {dvUI1,61},
    {dvUI1,62},
    {dvUI1,63},
    {dvUI1,64},
    {dvUI1,65},
    {dvUI1,66},
    {dvUI1,67},
    {dvUI1,68}
}	   	

//Create an integer array containing all of the virtual channels that indicate when the PCI mute is on
INTEGER chanPCIMuteIsOn[] = 
{
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
}   

//Create an integer array containing all of the virtual channels that indicate when the PCI mute is off
INTEGER chanPCIMuteIsOff[] = 
{
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18
}   

//Create an integer array containing all of the virtual channels that indicate when the PCI ring is pressed
INTEGER chanPCIRingIsPressed[] = 
{
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28
}   

DEFINE_EVENT

/****************************************
	    Manage PCI Connect and Debug
*****************************************/

DATA_EVENT[dvUI1]
{
    ONLINE:
    {
	//Turn debug on
	ON[vdvPCI1,255]
	ON[vdvPCI2,255]
	ON[vdvPCI3,255]
	        
	//Open TCP/IP connection
	ON[vdvPCI1,101]
	ON[vdvPCI2,101]
	ON[vdvPCI3,101]
	
	//Set default PCI
	IF(nSelectedPCI = 0)
	    nSelectedPCI = 1
    }           
}


/****************************************
	    Manage PCI Select
*****************************************/

BUTTON_EVENT[dcPCISelect]
{
    PUSH:
    {
	//Indicate selected PCI device
	nSelectedPCI = GET_LAST(dcPCISelect)
	
	//Create feeedback timeline if not already created
	IF(TIMELINE_ACTIVE(tlPCIFeedback) = 0)
	    TIMELINE_CREATE(tlPCIFeedback,tlPCIFeedbackTime,1,TIMELINE_RELATIVE,TIMELINE_REPEAT)
    }
}

/****************************************
	    Commands to PCIs
*****************************************/

BUTTON_EVENT[dcPCIToggle]
{
    PUSH:
    {
	//Indicate Channel to toggle
	nIndex = GET_LAST(dcPCIToggle)
	
	//Send toggle command to selected virtual PCI device
	SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=',ITOA(nIndex),', LED=Toggle'"
    }
}

BUTTON_EVENT[dcPCIMuteOn]
{
    PUSH:
    {
	//Indicate Channel to MuteOn
	nIndex = GET_LAST(dcPCIMuteOn)
	
	//Send Mute On command for all channels to selected virtual PCI device
	IF(nIndex = 9)
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=All, LED=Red'"
	}

	//Send Mute On command for Channel x  to selected virtual PCI device
	ELSE
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=',ITOA(nIndex),', LED=Red'"
	}
    }
}

BUTTON_EVENT[dcPCIMuteOff]
{
    PUSH:
    {
	//Indicate Channel to MuteOff
	nIndex = GET_LAST(dcPCIMuteOff)
	
	//Send Mute Off command for all channels to selected virtual PCI device
	IF(nIndex = 9)
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=All, LED=Green'"
	}

	//Send Mute Off command for Channel x  to selected virtual PCI device
	ELSE
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=',ITOA(nIndex),', LED=Green'"
	}
    }
}

BUTTON_EVENT[dcPCILEDOff]
{
    PUSH:
    {
	//Indicate Channel to turn LEDOff
	nIndex = GET_LAST(dcPCILEDOff)
	
	//Send LED Off command for all channels to selected virtual PCI device
	IF(nIndex = 9)
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=All, LED=Off'"
	}

	//Send LED Off command for Channel x  to selected virtual PCI device
	ELSE
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=',ITOA(nIndex),', LED=Off'"
	}
    }
}

BUTTON_EVENT[dcPCIPoll]
{
    PUSH:
    {
	TO[BUTTON.INPUT.CHANNEL]

	//Indicate Channel to poll
	nIndex = GET_LAST(dcPCIPoll)
	
	//Send poll command for all channels to selected virtual PCI device
	IF(nIndex = 9)
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=All, LED=Poll'"
	}

	//Send poll command for Channel x  to selected virtual PCI device
	ELSE
	{
	    SEND_COMMAND devPCIs[nSelectedPCI],"'Channel=',ITOA(nIndex),', LED=Poll'"
	}
    }
}



/*****************************************
	Manage PCI Ring Presses
*****************************************/

BUTTON_EVENT[dvUI1,6]
{
    PUSH:
    {
	//Allow ring presses to send commands to the PCI
	nEnableRingPresses = 1
	ON [dvUI1,6]
	OFF[dvUI1,7]
    }
}

BUTTON_EVENT[dvUI1,7]
{
    PUSH:
    {
	//Disallow ring presses from sending commands to the PCI
	nEnableRingPresses = 0
	ON [dvUI1,7]
	OFF[dvUI1,6]
    }
}

CHANNEL_EVENT[devPCIs,chanPCIRingIsPressed]
{
    ON:
    {
	//Determine PCI
	nIndex = GET_LAST(devPCIs)

	//Determine channel
	nIndex2 = GET_LAST(chanPCIRingIsPressed)
	    
	//Send toggle command to appropriate PCI/Channel
	IF(nEnableRingPresses)
	    SEND_COMMAND devPCIs[nIndex],"'Channel=',ITOA(nIndex2),', LED=Toggle'"
    }
}

TIMELINE_EVENT[tlPCIFeedback] 
{
    FOR(nIndex = 8;nIndex;nIndex--)
    {
	//Update Mute On Buttons
	IF([devPCIs[nSelectedPCI],nIndex])
	    ON[dcPCIMuteOn[nIndex]]
	ELSE
	    OFF[dcPCIMuteOn[nIndex]]
	
	//Update Mute Off Buttons
	IF([devPCIs[nSelectedPCI],nIndex + 10])
	    ON[dcPCIMuteOff[nIndex]]
	ELSE
	    OFF[dcPCIMuteOff[nIndex]]

	//Update LED Off Buttons
	IF((([devPCIs[nSelectedPCI],nIndex] = 0) && ([devPCIs[nSelectedPCI],nIndex + 10]) = 0))
	    ON[dcPCILEDOff[nIndex]]
	ELSE
	    OFF[dcPCILEDOff[nIndex]]

	//Update Ring Press Buttons
	IF([devPCIs[nSelectedPCI],nIndex + 20])
	    ON[dcPCIPress[nIndex]]
	ELSE
	    OFF[dcPCIPress[nIndex]]

	//Update LED Graphic Bargraph
	SELECT
	{
	    //Turn Bargraph Graphic Red
	    ACTIVE([devPCIs[nSelectedPCI],nIndex]):
		SEND_LEVEL dlPCIMuteGraphic[nIndex],3

	    //Turn Bargraph Graphic Green
	    ACTIVE([devPCIs[nSelectedPCI],nIndex + 10]):
		SEND_LEVEL dlPCIMuteGraphic[nIndex],2

	    //Turn Bargraph Graphic White
	    ACTIVE(1):
		SEND_LEVEL dlPCIMuteGraphic[nIndex],1
	}
    }
}
