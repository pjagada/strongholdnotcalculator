# StrongholdNotCalculator
Minecraft random seed speedrunning legal stronghold finder using perfect travel

## Before you use this, learn how perfect travel works
Read the [Perfect Travel document] and/or watch the [Perfect Travel video] to understand how perfect travel works.

This script will replace the need for you to do any math, so the important thing is to learn how to get the angle, which is found in pages 5 and 6 of the [Perfect Travel document].


## Setup instructions:
Download the [latest release]

Extract the zip folder's contents anywhere (make sure they're all in the same folder).

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

Once you get your angle and f3 c, pause and press Ctrl P if you plan on throwing 2 eyes, and Ctrl Shift P if you plan on throwing 1 eye (edit these hotkeys at the bottom of the script).

Follow the instructions in the GUI.

If you're doing 1 eye, then after a couple seconds, your clipboard will contain the coords you need to go to, the text file will generate, and DebugView will also show the coords.

If you're doing 2 eye, then throw another eye from a neighboring chunk. Try to go in a direction perpendicular to the eye.

For example, if your initial angle was 10 degrees, that means the eye is pointing roughly south, so go in the chunk either east or west of you. If your eye is pointing pretty diagonal, then it doesn't matter which way you go.

After it's done "computing" the numbers for the second eye (it'll take a couple seconds), your clipboard will contain the coords you need to go to, the text file will generate, and DebugView will also show the coords.

When doing 2 eye, it uses offsets from neighboring rows from Four's sheet to account for an error of +/- 0.01 degrees. If it can't find an intersection with those, it'll expand its search to take the 2 neighboring rows on either side, accounting for an error of +/- 0.02 degrees on each throw. This will likely result in a value that can be up to a couple hundred blocks off, so it may be worth it to remeasure, but you can use what it gives you and be pretty close.

### Ctrl B:
If you f3 c in the nether and press Ctrl B (you can change this hotkey at the bottom of the script), a number will be shown on screen that is the distance from 0 0. This works as long as each coordinate's absolute value is less than 300 blocks. This can be useful for blinding at optimal coordinates or potentially portal divine.


## Possible questions
### Legality?
It doesn't break any rules since it's not calculating anything, just searching through lookup tables the same way the Twitch bot does.
### Should I use 1 eye or 2 eyes?
According to Four, the odds of hitting the chunk on 1 eye perfect travel when done properly are around 65%. That error partially comes from side-to-side error (the angle may be off by 0.01 degrees), and because of the way perfect travel works, you'll get completely different offsets. The error mostly comes from the fact that most angles have multiple possible offsets, and with throwing 1 eye, we don't know which one to use.

Throwing a second eye from an adjacent chunk accounts for both of those errors, giving basically a 100% success rate when done right. However, it is obviously slower to throw eyes.

Basically, one eye is faster and riskier, two eye is slower and safer.


   [latest release]: <https://github.com/pjagada/strongholdnotcalculator/releases/latest>
   [Download and install AutoHotkey]: <https://www.autohotkey.com/>
   [Download and install debugview]: <https://docs.microsoft.com/en-us/sysinternals/downloads/debugview>
   [Perfect Travel document]: <https://docs.google.com/document/d/1JTMOIiS-Hl6_giEB0IQ5ki7UV-gvUXnNmoxhYoSgEAA/edit>
   [Perfect Travel video]: <https://youtu.be/YpV7I9X-Jso>
