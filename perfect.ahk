#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global TTS := False ; enable TTS if you want to
if (TTS)
{
	;ComObjCreate("SAPI.SpVoice").Speak("text")
	;ComObjCreate("SAPI.SpVoice").Speak("to")
	;ComObjCreate("SAPI.SpVoice").Speak("speech")
	;ComObjCreate("SAPI.SpVoice").Speak("is")
	;ComObjCreate("SAPI.SpVoice").Speak("active")
}

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

mult16(distance)
{
	found := False
	Loop, Read, tables/mult16.csv
	{
		Loop, Parse, A_LoopReadLine, CSV
		{
			if (found)
			{
				return (A_LoopField)
			}
			if (A_LoopField = distance and A_Index = 1)
			{
				found := True
			}
		}
		if (found)
			break
	}
}

ClipboardNotCorrect()
{
	OutputDebug, Your clipboard doesn't contain the right numbers. Make sure you pressed f3 c and try again.
	if (TTS)
	{
		ComObjCreate("SAPI.SpVoice").Speak("Your clipboard doesn't contain the right numbers. Make sure you pressed f3 c and try again.")
	}
	MsgBox, Your clipboard doesn't contain the right numbers. Make sure you pressed f3 c and try again after closing this box.
}

OutputCoords(xOffset, zOffset, theIndex, extra := False)
{
	OutputDebug, [Perfect] Go to:
	ovX := OX[theIndex]
	ovZ := OZ[theIndex]
	neX := NX[theIndex]
	neZ := NZ[theIndex]
							
	chunkDist := PythagoreanTheorem(xOffset, zOffset)
	chunkDistArray := StrSplit(chunkDist, ".")
	chunkDist := chunkDistArray[1]
	blockDist := mult16(chunkDist)
	OutputDebug, [Perfect] Overworld chunk coords: %ovX% %ovZ%
	OutputDebug, [Perfect] Nether block coords:    %neX% %neZ%
	OutputDebug, [Perfect] %blockDist% blocks away
	OutputDebug, [Perfect] `n
	Clipboard :=  "OW: " ovX " " ovZ ", N: " neX " " neZ ", dist: " blockDist
	writeString := "OW: " . ovX . " " . ovZ . "`nN: " . neX . " " . neZ . "`ndist: " . blockDist
	if (extra)
	{
		Clipboard :=  "OW: " ovX " " ovZ ", N: " neX " " neZ ", dist: " blockDist ", this was from checking extra offsets, so it may not be perfectly accurate but should be within a couple hundred blocks."
		writeString := "OW: " . ovX . " " . ovZ . "`nN: " . neX . " " . neZ . "`ndist: " . blockDist . "`nfrom extra offsets so may be off"
	}
							
	
	FileAppend, %writeString%, coords.txt
	if (TTS)
	{
		ComObjCreate("SAPI.SpVoice").Speak("Coords ready and in clipboard")
	}
	ShowTimes()
}
global standXChunk
global standZChunk
global standXBlock
global standZBlock

getStand(which, coord)
{
	foundLine := false
	Loop, Read, tables/coordsToChunkAndBlock.csv
	{
		Loop, Parse, A_LoopReadLine, CSV
		{
			if (A_Index = 1)
			{
				if (coord = A_LoopField)
				{
					foundLine := true
					;OutputDebug, angle in four's sheet: %A_LoopField%
				}
			}
			else if (A_Index = 2)
			{
				if (foundLine)
				{
					if (which == "x")
					{
						standXChunk := A_LoopField
					}
					else if (which == "z")
					{
						standZChunk := A_LoopField
					}
					else
					{
						MsgBox, which error
						EXitApp
					}
				}
			}
			else if (A_Index = 3)
			{
				if (foundLine)
				{
					if (which == "x")
					{
						standXBlock := A_LoopField
					}
					else if (which == "z")
					{
						standZBlock := A_LoopField
					}
					else
					{
						MsgBox, which error
						EXitApp
					}
				}
			}
			else 
			{
				MsgBox, column more than 3 in coordsToChunkAndBlock
				ExitApp
			}
		}
		if (foundLine)
		{
			break
		}
	}
}

PerfectTravel(n)
{
	timeToGetAngle := 0
	timeToGetOffsets := 0
	timeToGetDestinationChunks := 0
	timeToGetDistanceFrom00 := 0
	timeToCheckRing := 0
	timeAddingToArray := 0
	timeComparingDests := 0
	FileDelete, coords.txt
	OutputDebug, [Perfect] `n
	array1 := StrSplit(Clipboard, " ")
	fullx := array1[7]
	fullz := array1[9]
	angle := array1[10]
	if fullx is not number
	{
		ClipboardNotCorrect()
		return
	}
	if fullz is not number
	{
		ClipboardNotCorrect()
		return
	}
	if angle is not number
	{
		ClipboardNotCorrect()
		return
	}
	arrayx := StrSplit(fullx, ".")
	arrayz := StrSplit(fullz, ".")
	x := arrayx[1]
	z := arrayz[1]
	xDec := arrayx[2]
	zDec := arrayz[2]
	xD := SubStr(xDec, 1, 1)
	zD := SubStr(zDEc, 1, 1)
	decX := x . "." . xD
	decZ := z . "." . zD
	slit := 0
	GUIthing()
	while(slit = 0)
	{
	}
	if (throwNum = 0)
		throwNum := 1
	else if (throwNum = 1)
		throwNum := 2
	if (throwNum = 1)
	{
		OX := []
		OZ := []
		NX := []
		NZ := []
	}
	startTime := A_TickCount
	realAngle := GetActualAngle(angle)
	timeToGetAngle += (A_TickCount - startTime) / 1000
	OutputDebug, [Perfect] `n
	foundLine := false
	offsetStringArray := []
	previousLine := []
	extraPreviousLine := []
	extraNextLine := []
	readExtraLine := False
	doneWithLine := False
	startTime := A_TickCount
	if (n == 1)
	{
		getStand("x", decX)
		getStand("z", decZ)
		readFile := "tables/offsets/x" . standXBlock . "z" . standZBlock . ".csv"
		;OutputDebug, [Perfect] %standXChunk% %standZChunk% %standXBlock% %standZBlock%
		;ExitApp
	}
	if (n == 2)
	{
		readFile := "tables/angleOffsets.csv"
	}
	OutputDebug, [Perfect] %readFile%
	Loop, Read, %readFile%
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
				else if (!foundLine)
				{
					extraPreviousLine := previousLine
					previousLine := []
				}
			}
			else
			{
				if (readExtraLine)
				{
					extraNextLine.Push(A_LoopField)
				}
				else if (foundLine or doneWithLine)
				{
					if (InStr(A_LoopField, " "))
						offsetStringArray.Push(A_LoopField)
				}
				else
				{
					if (InStr(A_LoopField, " "))
						previousLine.Push(A_LoopField)
				}
			}
		}
		if (readExtraLine)
		{
			break
		}
		if (doneWithLine)
		{
			readExtraLine := True
		}
		if (foundLine)
		{
			doneWithLine := True
			if (n = 1)
				break
		}
	}
	
	if (n = 2)
	{
		for q, offset in previousLine
		{
			offsetStringArray.Push(offset)
		}
		if (throwNum = 1)
		{
			for r, offset in extraPreviousLine
			{
				extraOffsets1.Push(offset)
			}
			for r, offset in extraNextLine
			{
				extraOffsets1.Push(offset)
			}
		}
		else
		{
			for r, offset in extraPreviousLine
			{
				extraOffsets2.Push(offset)
			}
			for r, offset in extraNextLine
			{
				extraOffsets2.Push(offset)
			}
		}
	}
	timeToGetOffsets += (A_TickCount - startTime) / 1000
	startTime := A_TickCount
	/*
	numOffsets := offsetStringArray.MaxIndex()
	numprev := previousLine.MaxIndex()
	OutputDebug, [Perfect] main offsets:
	
	for i, offsetString in offsetStringArray
	{
		OutputDebug, [Perfect] %offsetString%
	}
	
	OutputDebug, [Perfect] extra offsets 1:
	for i, offsetString in extraOffsets1
	{
		OutputDebug, [Perfect] %offsetString%
	}
	OutputDebug, [Perfect] extra offsets 2:
	for i, offsetString in extraOffsets2
	{
		OutputDebug, [Perfect] %offsetString%
	}
	*/
	
	
	if (n = 1)
		throwNum := 1
	xStand[throwNum] := x
	zStand[throwNum] := z
	if (throwNum = 2)
		fullOffsets2 := offsetStringArray
	foundMatch := False
	for i, offsetString in offsetStringArray
	{
		OutputDebug, [Perfect] %offsetString%
		array2 := StrSplit(offsetString, " ")
		xOffset := array2[1]
		zOffset := array2[2]
	
		xDestination := offsetCalculation(x, xOffset, n, "x")
		zDestination := offsetCalculation(z, zOffset, n, "z")
	
		xChunkDest := xDestination[1]
		zChunkDest := zDestination[1]
		xNetherDest := xDestination[2]
		zNetherDest := zDestination[2]
		if (n = 1)
		{
			;OutputDebug, [timing] checking quality
			startTime := A_TickCount
			distanceString := PythagoreanTheorem(xChunkDest, zChunkDest)
			timeToGetDistanceFrom00 += (A_TickCount - startTime) / 1000
			distanceArray := StrSplit(distanceString, ".")
			distance := distanceArray[1]
			originDistance := False
			startTime := A_TickCount
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
			timeToCheckRing += (A_TickCount - startTime) / 1000
			;OutputDebug, [timing] %checkRing% seconds to check if that distance was in the ring
			;OutputDebug, [timing] quality is %quality%
		}
		if (n = 2 or quality = "inRing")
		{
			;OutputDebug, this is/would be %quality%
			;OutputDebug, X Z Chunk offset: %xOffset% %zOffset%
			;OutputDebug, Overworld chunk coords: %xChunkDest% %zChunkDest%
			;OutputDebug, Nether block coords:    %xNetherDest% %zNetherDest%
			if (throwNum = 1)
			{
				;OutputDebug, first throw so adding to array
				if (n = 1)
				{
					ovX := xChunkDest
					ovZ := zChunkDest
					neX := xNetherDest
					neZ := zNetherDest
					;OutputDebug, [Perfect] xOffset: %xOffset%, zOffset: %zOffset%
					chunkDist := PythagoreanTheorem(xOffset, zOffset)
					;OutputDebug, [Perfect] chunkDist: %chunkDist%
					chunkDistArray := StrSplit(chunkDist, ".")
					chunkDist := chunkDistArray[1]
					;OutputDebug, [Perfect] chunkDist: %chunkDist%
					blockDist := mult16(chunkDist)
					OutputDebug, [Perfect] Overworld chunk coords: %ovX% %ovZ%
					OutputDebug, [Perfect] Nether block coords:    %neX% %neZ%
					OutputDebug, [Perfect] %blockDist% blocks away
					OutputDebug, [Perfect] `n
					Clipboard :=  "OW: " ovX " " ovZ ", N: " neX " " neZ ", dist: " blockDist
							
					writeString := "OW: " . ovX . " " . ovZ . "`nN: " . neX . " " . neZ . "`ndist: " . blockDist
					FileAppend, %writeString%, coords.txt
					if (TTS)
					{
						ComObjCreate("SAPI.SpVoice").Speak("Coords ready and in clipboard")
					}
					ShowTimes()
					Reload
				}
				startTime := A_TickCount
				OX.Push(xChunkDest)
				OZ.Push(zChunkDest)
				NX.Push(xNetherDest)
				NZ.Push(zNetherDest)
				timeAddingToArray += (A_TickCount - startTime) / 1000
			}
			else if (throwNum = 2)
			{
				startTime := A_TickCount
				;OutputDebug, second throw so checking
				for i, xchunk in OX
				{
					if (xchunk = xChunkDest)
					{
						;OutputDebug, x chunk matches
						zchunk := OZ[i]
						if (zchunk = zChunkDest)
						{
							;OutputDebug, z chunk matches
							foundMatch = True
							OutputCoords(xOffset, zOffset, i)
							Reload
						}
					}
				}
				timeComparingDests += (A_TickCount - startTime) / 1000
				OX2.Push(xChunkDest)
				OZ2.Push(zChunkDest)
				NX2.Push(xNetherDest)
				NZ2.Push(zNetherDest)
			}
			else
			{
				OutputDebug, throwNum is not 1 or 2
				ExitApp
			}
			;OutputDebug, `n
		}
	}
	destinations := (A_TickCount - startTime) / 1000
	;OutputDebug, %destinations% seconds to get the destinations
	;OutputDebug, `n
	if (foundMatch = False and throwNum = 2)
	{
		if (CheckExtras() = False)
			NoIntersection()
		ShowTimes()
		Reload
	}
	if (throwNum = 1)
	{
		OutputDebug, [Perfect] all stuff for first throw done, go ahead and press the hotkey again for your second throw when you have it ready
		if (TTS)
		{
			ComObjCreate("SAPI.SpVoice").Speak("First throw work done, press hotkey again for second throw when ready.")
		}
		ShowTimes()
	}
	OutputDebug, [Perfect] `n
	
}

CheckExtras()
{
	OutputDebug, [Perfect] No initial intersection, so checking extra offsets. As a result, the outcome may be off, but should be within a couple hundred blocks, so consider redoing and measuring correctly.
	OutputDebug, [Perfect]
	/*
	OutputDebug, [Perfect] possible destinations from throw 1:
	for i, destX in OX
	{
		destZ := OZ[i]
		OutputDebug, [Perfect] %destX% %destZ%
	}
	
	OutputDebug, [Perfect] possible destinations from throw 2:
	for i, destX in OX2
	{
		destZ := OZ2[i]
		OutputDebug, [Perfect] %destX% %destZ%
	}
	*/
	
	
	
	Loop, 2
	{
		throwNum := A_Index
		x := xStand[A_Index]
		z := zStand[A_Index]
		if (throwNum = 1)
		{
			offsetStringArray := extraOffsets1
		}
		else {
			offsetStringArray := extraOffsets2
		}
		for i, offsetString in offsetStringArray
		{
			array2 := StrSplit(offsetString, " ")
			xOffset := array2[1]
			zOffset := array2[2]
			
			;OutputDebug, [Perfect] x: %x%, xOffset: %xOffset%
			xDestination := offsetCalculation(x, xOffset)
			zDestination := offsetCalculation(z, zOffset)
	
			xChunkDest := xDestination[1]
			zChunkDest := zDestination[1]
			xNetherDest := xDestination[2]
			zNetherDest := zDestination[2]
			if (throwNum = 1)
			{
				OX.Push(xChunkDest)
				OZ.Push(zChunkDest)
				NX.Push(xNetherDest)
				NZ.Push(zNetherDest)
			}
			else
			{
				OX2.Push(xChunkDest)
				OZ2.Push(zChunkDest)
				NX2.Push(xNetherDest)
				NZ2.Push(zNetherDest)
				fullOffsets2.Push(offsetString)
			}
		}
	}
	for i, xchunk1 in OX
	{
		for j, xchunk2 in OX2
		{
			if (xchunk1 = xChunk2)
			{
				;OutputDebug, x chunk matches
				zchunk1 := OZ[i]
				zchunk2 := OZ2[j]
				if (zchunk1 = zchunk2)
				{
					;OutputDebug, z chunk matches
					offsetString := fullOffsets2[j]
					array2 := StrSplit(offsetString, " ")
					xOffset := array2[1]
					zOffset := array2[2]
					OutputCoords(xOffset, zOffset, i, True)
					;OutputDebug, [Perfect] reaching here
					return True
				}
			}
		}
	}
	return False
}

NoIntersection()
{
	OutputDebug, [Perfect] No intersection found, you probably measured something wrong. Do it again.
	OutputDebug, [Perfect] `n
	Clipboard := "No intersection found, you probably measured something wrong. Do it again."
	writeString := "No intersection found, you probably measured something wrong. Do it again."
	FileAppend, %writeString%, coords.txt
	if (TTS)
	{
		ComObjCreate("SAPI.SpVoice").Speak("Measured wrong, do everything again.")
	}
}

offsetCalculation(location, offset, n := 2, axis := "y")
{
	;OutputDebug, location: %location%, offset: %offset%
	checkForEntry := false
	destString := false
	startTime := A_TickCount
	if (n == 1)
	{
		if (axis == "x")
			currentChunk := standXChunk
		else if (axis == "z")
			currentChunk := standZChunk
		else
		{
			MsgBox, y axis monkaOMEGA
			ExitApp
		}
	}
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
			if (n == 2)
			{
				if (A_Index = 1)
				{
					if (A_LoopField = location)
					{
						;OutputDebug, current location from clipboard: %location%, current location from sheet: %A_LoopField%
						checkForEntry := True
					}
				}
			}
			else
			{
				if (A_Index = 2)
				{
					if (A_LoopField = currentChunk)
					{
						checkForEntry := True
					}
				}
			}
			if (checkForEntry and A_Index = 2 and n == 2)
			{
				currentChunk := A_LoopField
			}
			if (checkForEntry and A_Index = offsetIndex)
			{
				checkForEntry := False
				destString := A_LoopField
			}
			if (destString)
			{
				break
			}
		}
		if (destString)
		{
			break
		}
	}
	;OutputDebug, [Perfect] destString: %destString%
	if (destString = false)
	{
		OutputDebug, [Perfect] You were either standing on the wrong spot in the chunk or were too far out. The script will automatically reload, so do everything again.
		OutputDebug, [Perfect] `n
		Clipboard := "You were either standing on the wrong spot in the chunk or were too far out. The script will automatically reload, so do everything again."
		writeString := "You were either standing on the wrong spot in the chunk or were too far out. The script will automatically reload, so do everything again."
		FileAppend, %writeString%, coords.txt
		if (TTS)
		{
			ComObjCreate("SAPI.SpVoice").Speak("You were either standing on the wrong spot in the chunk or were too far out. The script will automatically reload, so do everything again.")
		}
		Reload
	}
	;OutputDebug, %destString%
	arr := StrSplit(destString, ";")
	timeToGetDestinationChunks += (A_TickCount - startTime) / 1000
	;OutputDebug, [timing] %getChunk% seconds to get the chunk
	;startTime := A_TickCount
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

global OX2 := []
global OZ2 := []
global NX2 := []
global NZ2 := []

global extraOffsets1 := []
global extraOffsets2 := []
global fullOffsets2 := []

global xStand := [0, 0]
global zStand := [0, 0]

global timeToGetAngle := 0
global timeToGetOffsets := 0
global timeToGetDestinationChunks := 0
global timeToGetDistanceFrom00 := 0
global timeToCheckRing := 0
global timeAddingToArray := 0
global timeComparingDests := 0

ShowTimes()
{
	OutputDebug, [timing] %timeToGetAngle% seconds to get angle
	OutputDebug, [timing] %timeToGetOffsets% seconds to get offsets
	OutputDebug, [timing] %timeToGetDestinationChunks% seconds to add offsets
	OutputDebug, [timing] %timeToGetDistanceFrom00% seconds to get distance from 0 0
	OutputDebug, [timing] %timeToCheckRing% seconds to check if those distances are in ring
	OutputDebug, [timing] %timeAddingToArray% seconds to push destinations to arrays
	OutputDebug, [timing] %timeComparingDests% seconds to compare destinations
	OutputDebug, [timing]
}


#IfWinActive, Minecraft
{
	^F5::
		Reload
	return
	
	^B::
		CheckBlindCoords()
	return
	
	^P::
		;if (CheckRes())
			PerfectTravel(2)
		;else
			;OutputDebug, wrong resolution
	return
	
	^+P::
		PerfectTravel(1)
	return
}