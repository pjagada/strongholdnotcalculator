#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global TTS := False ; enable TTS if you want to

CheckBlindCoords()
{
	array1 := StrSplit(Clipboard, " ")
	fullx := array1[7]
	fullz := array1[9]
	arrayx := StrSplit(fullx, ".")
	arrayz := StrSplit(fullz, ".")
	x := arrayx[1]
	z := arrayz[1]
	;OutputDebug, %x%, %z%
	distance := PythagoreanTheorem(x, z)
	MsgBox, %distance%
	
}

PythagoreanTheorem(a, b)
{
	x := a
	z := b
	if (InStr(x, "-"))
		x := SubStr(x, 2)
	if (InStr(z, "-"))
		z := SubStr(z, 2)
	
	checkForZ := False
	distance := 0
	Loop, Read, tables/pythagorean.csv
	{
		if (A_Index = 1)
		{
			Loop, Parse, A_LoopReadLine, CSV
			{
				if (A_LoopField = z)
				{
					zIndex := A_Index
					;OutputDebug, z index: %zIndex%, z: %z%
				}
			}
		}
		Loop, Parse, A_LoopReadLine, CSV
		{
			if (A_Index = 1)
			{
				if (A_LoopField = x)
				{
					;OutputDebug, %x% %A_LoopField%
					checkForZ := True
				}
			}
			if (checkForZ and A_Index = zIndex)
			{
				checkForZ := False
				distance := A_LoopField
			}
		}
	}
	return (distance)
}

/*
GetActualAngle(angle)
{
	foundLine := False
	Loop, Read, normalAngle.csv
	{
		;OutputDebug, %A_LoopReadLine%
		Loop, Parse, A_LoopReadLine, CSV
		{
			if ((angle = A_LoopField) and (A_Index = 1))
			{
				foundLine := True
				;OutputDebug, Original angle: %A_LoopField%
			}
			if (foundLine)
			{
				if (A_Index = 2 and slit = "L")
				{
					realAngle := A_LoopField
				}
				if (A_Index = 3 and slit = "M")
				{
					realAngle := A_LoopField
				}
				if (A_Index = 4 and slit = "R")
				{
					realAngle := A_LoopField
				}
			}
		}
		if (foundLine)
		{
			OutputDebug, Actual angle:   %realAngle%
			break
		}
	}
	return (realAngle) 
}
*/

GetActualAngle(angle)
{
	;OutputDebug, raw angle is %angle%
	angleArray := StrSplit(angle, ".")
	decimals := angleArray[2]
	;OutputDebug, decimals are %decimals%
	intAngle := angleArray[1]
	;OutputDebug, integer angle is %intAngle%
	sign := SubStr(intAngle, 1, 1)
	;OutputDebug, first character is %sign%
	if (sign = "-")
	{
		intAngle := SubStr(intAngle, 2)
		;OutputDebug, integer angle is %intAngle%
	}
	intLength := StrLen(intAngle)
	onesDigit := SubStr(intAngle, 0)
	;OutputDebug, length of that integer angle is %intLength%
	if (intLength != 2 and intLength != 1 and intLength != 0)
	{
		tensAndAbove := SubStr(intAngle, 1, -1)
		;OutputDebug, just the tens place and above is %tensAndAbove%
		
		foundLine := False
		Loop, Read, tables/bigAngle.csv
		{
			Loop, Parse, A_LoopReadLine, CSV
			{
				if ((A_LoopField = tensAndAbove) and (A_Index = 1))
				{
					foundLine := True
				}
				if (foundLine and A_Index = 2)
				{
					realTensAndAbove := A_LoopField
				}
			}
			if (foundLine)
			{
				break
			}
		}
		;OutputDebug, %realTensAndAbove%
		absAngle := realTensAndAbove . 	onesDigit . "." . decimals
		if (sign = "-")
		{
			angle := "-" . absAngle
		}
		else
		{
			angle := absAngle
		}
	}
	foundLine := False
	Loop, Read, tables/smallAngle.csv
	{
		;OutputDebug, %A_LoopReadLine%
		Loop, Parse, A_LoopReadLine, CSV
		{
			if ((angle = A_LoopField) and (A_Index = 1))
			{
				foundLine := True
				;OutputDebug, Original angle: %A_LoopField%
			}
			if (foundLine)
			{
				if (A_Index = 2 and slit = "L")
				{
					realAngle := A_LoopField
				}
				if (A_Index = 3 and slit = "M")
				{
					realAngle := A_LoopField
				}
				if (A_Index = 4 and slit = "R")
				{
					realAngle := A_LoopField
				}
			}
		}
		if (foundLine)
		{
			OutputDebug, [Perfect] Actual angle:   %realAngle%
			break
		}
	}
	return (realAngle) 
}

PerfectTravel()
{
	FileDelete, coords.txt
	OutputDebug, [Perfect] `n
	array1 := StrSplit(Clipboard, " ")
	fullx := array1[7]
	fullz := array1[9]
	angle := array1[10]
	arrayx := StrSplit(fullx, ".")
	arrayz := StrSplit(fullz, ".")
	x := arrayx[1]
	z := arrayz[1]
	slit := 0
	GUIthing()
	while(slit = 0)
	{
	}
	startTime := A_TickCount
	realAngle := GetActualAngle(angle)
	angleConvert := (A_TickCount - startTime) / 1000
	startTime := A_TickCount
	OutputDebug, [Perfect] `n
	;OutputDebug, %angleConvert% seconds to convert the angle
	;OutputDebug, `n
	foundLine := false
	offsetStringArray := []
	previousLine := []
	Loop, Read, tables/angleOffsets.csv
	{
		Loop, Parse, A_LoopReadLine, CSV
		{
			if (A_Index = 1)
			{
				if (realAngle = A_LoopField)
				{
					foundLine := true
					;OutputDebug, angle in four's sheet: %A_LoopField%
				}
			}
			else
			{
				if (foundLine)
				{
					if (InStr(A_LoopField, " "))
						offsetStringArray.Push(A_LoopField)
				}
			}
		}
		if (foundLine)
		{
			break
		}
	}
	
	
	angleToOffset := (A_TickCount - startTime) / 1000
	startTime := A_TickCount
	;OutputDebug, %angleToOffset% seconds to get the offsets
	;OutputDebug, `n
	/*
	numOffsets := offsetStringArray.MaxIndex()
	numprev := previousLine.MaxIndex()
	OutputDebug, %numOffsets% %numprev%
	
	for i, offsetString in offsetStringArray
	{
		OutputDebug, %offsetString%
	}
	OutputDebug, `n
	*/
	
	for i, offsetString in offsetStringArray
	{
		array2 := StrSplit(offsetString, " ")
		xOffset := array2[1]
		zOffset := array2[2]
	
		xDestination := offsetCalculation(x, xOffset)
		zDestination := offsetCalculation(z, zOffset)
	
		xChunkDest := xDestination[1]
		zChunkDest := zDestination[1]
		xNetherDest := xDestination[2]
		zNetherDest := zDestination[2]
		distanceString := PythagoreanTheorem(xChunkDest, zChunkDest)
		distanceArray := StrSplit(distanceString, ".")
		distance := distanceArray[1]
		originDistance := False
		Loop, Read, tables/chunkRing.csv
		{
			Loop, Parse, A_LoopReadLine, CSV
			{
				if (originDistance)
				{
					quality := A_LoopField
				}
				if (A_LoopField = distance)
				{
					originDistance := True
				}
			}
			if (originDistance)
				break
		}
		if (quality = "inRing")
		{
			;OutputDebug, this is/would be %quality%
			;OutputDebug, X Z Chunk offset: %xOffset% %zOffset%
			OutputDebug, [Perfect] Go to: 
			OutputDebug, [Perfect] Overworld chunk coords: %xChunkDest% %zChunkDest%
			OutputDebug, [Perfect] Nether block coords:    %xNetherDest% %zNetherDest%
			OutputDebug, [Perfect] `n
			Clipboard :=  "OW: " xChunkDest " " zChunkDest " N: " xNetherDest " " zNetherDest
			
			writeString := "OW: " . xChunkDest . " " . zChunkDest . " N: " . xNetherDest . " " . zNetherDest
			FileAppend, %writeString%, coords.txt
			if (TTS)
			{
				ComObjCreate("SAPI.SpVoice").Speak("Coords ready and in clipboard")
			}
			Reload
			/*
			if (throwNum = 1)
			{
				OutputDebug, first throw so adding to array
				OX.Push(xChunkDest)
				OZ.Push(zChunkDest)
				NX.Push(xNetherDest)
				NZ.Push(zNetherDest)
			}
			else if (throwNum = 2)
			{
				OutputDebug, second throw so checking
				for i, xchunk in OX
				{
					if (xchunk = xChunkDest)
					{
						OutputDebug, x chunk matches
						zchunk := OZ[i]
						if (zchunk = zChunkDest)
						{
							OutputDebug, z chunk matches
							theIndex := i
						}
					}
				}
			}
			else
			{
				OutputDebug, throwNum is not 1 or 2
				ExitApp
			}
			OutputDebug, `n
			*/
		}
	}
	destinations := (A_TickCount - startTime) / 1000
	;OutputDebug, %destinations% seconds to get the destinations
	;OutputDebug, `n
	if (throwNum = 2)
	{
		OutputDebug, `n
		OutputDebug, Final go to:
		ovX := OX[theIndex]
		ovZ := OZ[theIndex]
		neX := NX[theIndex]
		neZ := NZ[theIndex]
		OutputDebug, Overworld chunk coords: %ovX% %ovZ%
		OutputDebug, Nether block coords:    %neX% %neZ%
	}
	OutputDebug, `n
	OutputDebug, all offsets done
	OutputDebug, `n
	OutputDebug, `n
	
}

offsetCalculation(location, offset)
{
	;OutputDebug, location: %location%, offset: %offset%
	checkForEntry := false
	Loop, Read, tables/coordsToChunk.csv
	{
		if (A_Index = 1)
		{
			Loop, Parse, A_LoopReadLine, CSV
			{
				if (A_LoopField = offset)
				{
					offsetIndex := A_Index
					;OutputDebug, offset from four's sheet: %offset%, offset confirmed here: %offsetIndex%
				}
			}
		}
		Loop, Parse, A_LoopReadLine, CSV
		{
			if (A_Index = 1)
			{
				if (A_LoopField = location)
				{
					;OutputDebug, current location from clipboard: %location%, current location from sheet: %A_LoopField%
					checkForEntry := True
				}
			}
			if (checkForEntry and A_Index = 2)
			{
				currentChunk := A_LoopField
			}
			if (checkForEntry and A_Index = offsetIndex)
			{
				checkForEntry := False
				destString := A_LoopField
			}
		}
	}
	
	;OutputDebug, %destString%
	arr := StrSplit(destString, ";")
	
	return (arr)
}

global slit := 0
GUIthing()
{
	Gui, Add, Button, x10 y68 w70 h20, Left
	Gui, Add, Button, x90 y68 w70 h20, Middle
	Gui, Add, Button, x170 y68 w70 h20, Right
	Gui, Show, w250 h98, 5 pixel slit
	return
	
	ButtonLeft:
	slit := "L"
	WinClose, 5 pixel slit
	return

	ButtonMiddle:
	slit := "M"
	WinClose, 5 pixel slit
	return

	ButtonRight:
	slit := "R"
	WinClose, 5 pixel slit
	return

}

global throwNum := 0
GUIthrow()
{
	Gui, New
	Gui, Add, Button, x10 y68 w70 h20, First
	Gui, Add, Button, x170 y68 w70 h20, Second
	Gui, Show, w250 h98, which throw
	return
	
	ButtonFirst:
	throwNum := 1
	WinClose, which throw
	return

	ButtonSecond:
	throwNum := 2
	WinClose, which throw
	return

}

CheckRes()
{
	WinGetPos, X, Y, W, H, Minecraft
	if (H > 1070)
		return False
	else
		return True
}

global OX := []
global OZ := []
global NX := []
global NZ := []

#IfWinActive, Minecraft
{
	^B::
		CheckBlindCoords()
	return
	
	^P::
		;if (CheckRes())
			PerfectTravel()
		;else
			;OutputDebug, wrong resolution
	return
}