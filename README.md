# StrongholdNotCalculator
Minecraft random seed speedrunning legal stronghold finder using perfect travel

## Before you use this, learn how perfect travel works
Read the [Perfect Travel document] and/or watch the [Perfect Travel video] to understand how perfect travel works.

This script will replace the need for you to do any math, so the important thing is to learn how to get the angle, which is found in pages 5 and 6 of the [Perfect Travel document].

In addition, as of release 2.0, you no longer need to stand at 0,0 in the chunk.


## Setup instructions:
Download the [latest release]. Try downloading the exe version, and if you can't figure out how to get around the anti-virus, then download the py version; it'll do the same thing.

If you downloaded the py version, you will need to [install Python].

Extract the zip folder's contents anywhere (make sure they're all in the same folder).

Run either everyCorner.exe or everyCorner.py. It'll probably take around 10-20 minutes to generate the needed tables. You'll know it's done when if you right click on your tables folder, then click Properties, it'll say "Contains: 1,032 Files"

[Download and install AutoHotkey]

### Different options for getting final coords:
[Download and install debugview]. This will be a log window that the script will output your coords and angle to. When you run DebugView, click Edit in the toolbar at the top, click on "Filter/Highlight," then replace the asterisk with "Perfect" (without the quotes) to make sure that you don't get a bunch of other stuff clouding your DebugView.

and/or

Set up a text source in OBS that reads from a text file called coords.txt located in the folder that you extracted everything into (it may be easier to do this after you run the script once to generate the text file).

and/or

The script will replace your clipboard with the coords you need to go to once they are ready, so if this works for you, you don't need to do any other setup.

and/or

Enable TTS by right clicking on the script file that you need, clicking edit script, and changing where it says False at the top to True

## Use instructions:
Run the ahk script that you need by right clicking on the script file and clicking Run Script.

Open up DebugView if you want to use it.

Wedge yourself in any block corner (as of release 2.0, it doesn't need to be a chunk corner and it doesn't need to be on the northwest corner of a block; any corner works), and get your angle.

Once you get your angle and f3 c, pause and press Ctrl P if you plan on throwing 2 eyes, and Ctrl Shift P if you plan on throwing 1 eye (edit these hotkeys at the bottom of the script).

Follow the instructions in the GUI.

If you're doing 1 eye, then after a couple seconds, your clipboard will contain the coords you need to go to, the text file will generate, and DebugView will also show the coords.

If you're doing 2 eye, then go several blocks away (not in line with your eye throw), wedge yourself in a block corner, throw another eye, get your angle, f3 c, and press Ctrl P again. I have no idea how far apart the two throws should be. Just to be safe, maybe go like 5-10 blocks ish, but I have no idea if that's way too much or not enough. You may have to play around with it.

After it's done "computing" the numbers for the second eye (it'll take a couple seconds), your clipboard will contain the coords you need to go to, the text file will generate, and DebugView will also show the coords.

### Ctrl B:
If you f3 c in the nether and press Ctrl B (you can change this hotkey at the bottom of the script), a number will be shown on screen that is the distance from 0 0. This works as long as each coordinate's absolute value is less than 300 blocks. This can be useful for blinding at optimal coordinates or potentially portal divine.


## Possible questions
### Legality?
It doesn't break any rules since it's not calculating anything, just searching through lookup tables the same way the Twitch bot does.
### Should I use 1 eye or 2 eyes?
According to Four, the odds of hitting the chunk on 1 eye perfect travel when done properly are around 65%. That error partially comes from side-to-side error (the angle may be off by 0.01 degrees), and because of the way perfect travel works, you'll get completely different offsets. The error mostly comes from the fact that most angles have multiple possible offsets, and with throwing 1 eye, we don't know which one to use.

Throwing a second eye from an adjacent chunk accounts for both of those errors, giving basically a 100% success rate when done right. However, it is obviously slower to throw eyes.

Basically, one eye is faster and riskier, two eye is slower and safer.

## Notable runs using notcalculator
[Cube1337x 11:05 IGT] - fastest run that uses perfect

[Horsey 8:49 IGT stronghold enter] - one of the first runs to do it from anywhere in the chunk

[MoleyG 11:50 IGT] - fastest run that uses 2 eye perfect

[epnok 11:03 IGT] - second fastest run that uses perfect

[Horsey 12:04 IGT] - first major run to use notcalculator, former fastest run to use perfect, 2 eye perfect


## Credits
jojoe77777: created this concept and the original implementation and helped with basically everything

Four, Sharpieman20, others: created Perfect Travel and answered lots of questions

Bluesmoke, Gregor, pncakespoon: helped with data generation for anywhere in the chunk

Specnr: had miscellaneous ideas to improve the tool

   [latest release]: <https://github.com/pjagada/strongholdnotcalculator/releases/latest>
   [Download and install AutoHotkey]: <https://www.autohotkey.com/>
   [Download and install debugview]: <https://docs.microsoft.com/en-us/sysinternals/downloads/debugview>
   [Perfect Travel document]: <https://docs.google.com/document/d/1JTMOIiS-Hl6_giEB0IQ5ki7UV-gvUXnNmoxhYoSgEAA/edit>
   [Perfect Travel video]: <https://youtu.be/YpV7I9X-Jso>
   [install Python]: <https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe>
   [Horsey 8:49 IGT stronghold enter]: <https://youtu.be/JMHJDbBPhps>
   [Cube1337x 11:05 IGT]: <https://youtu.be/ZT0JU-i_Gmo>
   [epnok 11:03 IGT]: <https://youtu.be/Xn-YKCd3VqM>
   [MoleyG 11:50 IGT]: <https://youtu.be/EGInzoA0gtA>
   [Horsey 12:04 IGT]: <https://youtu.be/KSEEg617WRA>
