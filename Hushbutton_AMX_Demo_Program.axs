PROGRAM_NAME='Hushbutton_AMX_Demo_Program'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
//User Interfaces
dvUI1		= 10001:1:0 			//NXT-CV10

//LAN Devices
dvPCI1		= 0:2:0				//Hushbutton PCI #1
dvPCI2		= 0:3:0				//Hushbutton PCI #2
dvPCI3		= 0:4:0				//Hushbutton PCI #3
                                                             
//Virtual LAN Devices
vdvPCI1		= 33001:1:0			//Hushbutton PCI #1
vdvPCI2		= 33001:2:0			//Hushbutton PCI #2
vdvPCI3		= 33001:3:0			//Hushbutton PCI #3
                                                              
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
CHAR cPCI1IPAddress[] = '192.168.1.41'
CHAR cPCI2IPAddress[] = '192.168.1.42'
CHAR cPCI3IPAddress[] = '192.168.1.43'
                                 
#INCLUDE 'Hushbutton_PCI_UI'

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

DEFINE_MODULE 'Hushbutton_PCI' mdlHushbutton_PCI1(dvPCI1,cPCI1IPAddress, vdvPCI1)
DEFINE_MODULE 'Hushbutton_PCI' mdlHushbutton_PCI2(dvPCI2,cPCI2IPAddress, vdvPCI2)
DEFINE_MODULE 'Hushbutton_PCI' mdlHushbutton_PCI3(dvPCI3,cPCI3IPAddress, vdvPCI3)
                                                                              
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

