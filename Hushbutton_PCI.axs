MODULE_NAME = 'Hushbutton_PCI'(DEV dvPCI, CHAR cIPAddress[24], DEV vdvPCI)

DEFINE_VARIABLE
INTEGER nIndex
CHAR sPCIRemove[24]
CHAR sBufferPCI[24]
CHAR sPCI_Message[24]
CHAR sChannel[24]

DEFINE_FUNCTION CHAR[4] StringToBinary(CHAR sString[1])
{    
    SELECT
    {
	ACTIVE(sString = '0'):				RETURN '0000'
	ACTIVE(sString = '1'):				RETURN '0001'
	ACTIVE(sString = '2'):				RETURN '0010'
	ACTIVE(sString = '3'):				RETURN '0011'
	ACTIVE(sString = '4'):				RETURN '0100'
	ACTIVE(sString = '5'):				RETURN '0101'
	ACTIVE(sString = '6'):				RETURN '0110'
	ACTIVE(sString = '7'):				RETURN '0111'
	ACTIVE(sString = '8'):				RETURN '1000'
	ACTIVE(sString = '9'):				RETURN '1001'
	ACTIVE(sString = 'A' || sString = 'a'):		RETURN '1010'
	ACTIVE(sString = 'B' || sString = 'b'):		RETURN '1011'
	ACTIVE(sString = 'C' || sString = 'c'):		RETURN '1100'
	ACTIVE(sString = 'D' || sString = 'd'):		RETURN '1101'
	ACTIVE(sString = 'E' || sString = 'e'):		RETURN '1110'
	ACTIVE(sString = 'F' || sString = 'f'):		RETURN '1111'
    }
}

DEFINE_CAll 'Parse_Message'
{
    STACK_VAR INTEGER nIndexParseMsg    
    STACK_VAR CHAR sTemp[8]
    
    //Parse message containing info for All mics
    IF(FIND_STRING(sPCI_Message,'{=a',1))
    {
	// Parse Red state for All    	
	sTemp = "StringToBinary(MID_STRING(sPCI_Message,4,1)), StringToBinary(MID_STRING(sPCI_Message,5,1))"
	FOR(nIndexParseMsg = 8; nIndexParseMsg; nIndexParseMsg--)
	{
	    SWITCH(nIndexParseMsg)
	    {
	        CASE 1:	[vdvPCI,8] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 2:	[vdvPCI,7] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 3:	[vdvPCI,6] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 4:	[vdvPCI,5] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 5:	[vdvPCI,4] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 6:	[vdvPCI,3] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 7:	[vdvPCI,2] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 8:	[vdvPCI,1] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	    }        
	}

	// Parse Green state for All    
	sTemp = "StringToBinary(MID_STRING(sPCI_Message,6,1)), StringToBinary(MID_STRING(sPCI_Message,7,1))"
	FOR(nIndexParseMsg = 8; nIndexParseMsg; nIndexParseMsg--)
	{
	    SWITCH(nIndexParseMsg)
	    {
	        CASE 1:	[vdvPCI,18] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 2:	[vdvPCI,17] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 3:	[vdvPCI,16] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 4:	[vdvPCI,15] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 5:	[vdvPCI,14] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 6:	[vdvPCI,13] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 7:	[vdvPCI,12] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 8:	[vdvPCI,11] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	    }
	}

	// Parse Relay state for All    
	sTemp = "StringToBinary(MID_STRING(sPCI_Message,8,1)), StringToBinary(MID_STRING(sPCI_Message,9,1))"
	FOR(nIndexParseMsg = 8; nIndexParseMsg; nIndexParseMsg--)
	{
	    SWITCH(nIndexParseMsg)
	    {
	        CASE 1:	[vdvPCI,38] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 2:	[vdvPCI,37] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 3:	[vdvPCI,36] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 4:	[vdvPCI,35] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 5:	[vdvPCI,34] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 6:	[vdvPCI,33] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 7:	[vdvPCI,32] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	        CASE 8:	[vdvPCI,31] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 1
	    }
	}

    }

    //Parse Hushbutton presses
    ELSE IF(FIND_STRING(sPCI_Message,'{=s',1))
    {
	// Indicate press state for All    
	sTemp = "StringToBinary(MID_STRING(sPCI_Message,4,1)), StringToBinary(MID_STRING(sPCI_Message,5,1))"
	FOR(nIndexParseMsg = 8; nIndexParseMsg; nIndexParseMsg--)
	{
	    SWITCH(nIndexParseMsg)
	    {
	        CASE 1:	[vdvPCI,28] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 2:	[vdvPCI,27] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 3:	[vdvPCI,26] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 4:	[vdvPCI,25] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 5:	[vdvPCI,24] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 6:	[vdvPCI,23] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 7:	[vdvPCI,22] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	        CASE 8:	[vdvPCI,21] = ATOI(MID_STRING(sTemp,nIndexParseMsg,1)) = 0
	    }
	}
    }

    //Parse message containing info for single mics
    ELSE	
    {
	//Determine which mic the message is for
	nIndexParseMsg 		     = ATOI(MID_STRING(sPCI_Message,3,1))							
	
	//Indicate Red LED status
	[vdvPCI,nIndexParseMsg]      = ATOI(MID_STRING(sPCI_Message,4,1))
	
	//Indicate Green LED status
	[vdvPCI,nIndexParseMsg + 10] = ATOI(MID_STRING(sPCI_Message,5,1))
	
	//Indicate Relay status
	[vdvPCI,nIndexParseMsg + 30] = ATOI(MID_STRING(sPCI_Message,6,1))			
    }
}

DEFINE_START
CREATE_BUFFER dvPCI, sBufferPCI

DEFINE_EVENT

CHANNEL_EVENT[vdvPCI,101]
{
    //Open TCP/IP connection
    ON:
    {
	//Print message if debug is on
	IF([vdvPCI,255])
	    SEND_STRING 0,"'vdvPCI attempting to connect to address ', cIPAddress" 
	IP_CLIENT_OPEN (dvPCI.PORT,cIPAddress,23,1)
    }


    //Close TCP/IP connection
    OFF:
    {
	//Print message if debug is on
	IF([vdvPCI,255])
	    SEND_STRING 0,"'vdvPCI attempting to disconnect from address ', cIPAddress" 
	IP_CLIENT_CLOSE (dvPCI.PORT)
    }
}

DATA_EVENT[vdvPCI]
{
    COMMAND:
    {
	//Print message if debug is on
	IF([vdvPCI,255])
	    SEND_STRING 0,"'vdvPCI COMMAND received = ',DATA.TEXT" 

	//Indicate if 'Channel=' is present and remove it from send_command
	IF(LENGTH_STRING(sPCIRemove = REMOVE_STRING(DATA.TEXT,'Channel=',1)))	
	{
	    nIndex = FIND_STRING(DATA.TEXT,',',1)
	    //Indicate channel
	    sChannel = LEFT_STRING(DATA.TEXT, nIndex - 1)			
	    //Indicate command and send to device
	    SELECT								
	    {
		//Turn Red LED On, Green LED Off and Open PCM Relay 
		ACTIVE(FIND_STRING(DATA.TEXT,'LED=Red',1)):
		{
		    IF(sChannel = 'All')
			SEND_STRING dvPCI,"'{=aFF0000FF}',$0D";
		    ELSE
			SEND_STRING dvPCI,"'{=',sChannel,'1001}',$0D";
		}
		
		//Turn Red LED Off, Green LED On and Close PCM Relay 
		ACTIVE(FIND_STRING(DATA.TEXT,'LED=Green',1)):
		{
		    IF(sChannel = 'All')
			SEND_STRING dvPCI,"'{=a00FFFFFF}',$0D";
		    ELSE
			SEND_STRING dvPCI,"'{=',sChannel,'0111}',$0D";
		}
		
		//Turn Red LED Off, Green LED Off and Open PCM Relay 
		ACTIVE(FIND_STRING(DATA.TEXT,'LED=Off',1)):
		{
		    IF(sChannel = 'All')
			SEND_STRING dvPCI,"'{=a000000FF}',$0D";
		    ELSE
			SEND_STRING dvPCI,"'{=',sChannel,'0001}',$0D";
		}
		
		//Toggle Red LED, Green LED and PCM Relay 
		ACTIVE(FIND_STRING(DATA.TEXT,'LED=Toggle',1)):
		{
		    IF([vdvPCI,ATOI(sChannel)])
			SEND_STRING dvPCI,"'{=',sChannel,'0111}',$0D";
		    ELSE
			SEND_STRING dvPCI,"'{=',sChannel,'1001}',$0D";
		}
		
		//Poll State of indicated channel
		ACTIVE(FIND_STRING(DATA.TEXT,'LED=Poll',1)):
		{
		    IF(sChannel = 'All')
			SEND_STRING dvPCI,"'{?a}',$0D";
		    ELSE
			SEND_STRING dvPCI,"'{?',sChannel,'}',$0D";
		}
	    }
	}
	
	ELSE IF(LENGTH_STRING(sPCIRemove = REMOVE_STRING(DATA.TEXT,'PASSTHRU=',1)))
	    SEND_STRING dvPCI,"DATA.TEXT";
    }
}

DATA_EVENT[dvPCI]
{
    ONLINE:
    {
	//Print message if debug is on
	IF([vdvPCI,255])
	    SEND_STRING 0,"'PCI ',Data.SourceIP,' is online'"     
    }

    OFFLINE:
    {
	//Print message if debug is on
	IF([vdvPCI,255])
	    SEND_STRING 0,"'PCI ',Data.SourceIP,' is offline'"     
    }

    STRING:
    {
	//Print message if debug is on
	IF([vdvPCI,255])
	    SEND_STRING 0,"'PCI ',Data.SourceIP,' Rx=',DATA.TEXT" 

	//Copy complete message to buffer and call parse routine
	WHILE(FIND_STRING(sBufferPCI,'}',1))
	{
	    sPCI_Message = REMOVE_STRING(sBufferPCI,'}',1)
	    CAll 'Parse_Message'
	}
    }
}