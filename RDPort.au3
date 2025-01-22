#include <GuiConstantsEx.au3>
#include <ComboConstants.au3>
_Main()

Func _Main()
	Local $idLabel_1, $idCombo_2, $idButton1, $iMsg, $sData, $cPort

	; Create the GUI window and controls
	$Form1 = GUICreate("RDPort", 195, 55, (@DesktopWidth - 190) / 2, (@DesktopHeight - 160) / 2)
	$cPort = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp", "PortNumber")
	$idLabel_1 = GUICtrlCreateLabel("Current:" & $cPort, 5, 5, 131, 20, 0x10000)
	$idCombo_2 = GUICtrlCreateCombo("", 5, 30, 130, 20, 0x0003)
	GUICtrlSetData($idCombo_2, "3389|3390") ; ports list
	$idButton1 = GUICtrlCreateButton("Set port", 140, 30, 50, 20)

	; Run the GUI until it is closed
	GUISetState()
	While 1
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				ExitLoop
				;When button is pressed, label text is changed
				;to combobox value
			Case $iMsg = $idButton1
				$sData = GUICtrlRead($idCombo_2)
				GUICtrlSetData($idLabel_1, "Current:" &  $sData)
				RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp", "PortNumber", "REG_DWORD", $sData)
				RunWait(@ComSpec & ' /C Net Stop TermService /y')
                RunWait(@ComSpec & ' /C Net Start TermService')
		EndSelect
	WEnd
	Exit
EndFunc   ;==>_Main
