# StrongholdNotCalculator
Minecraft random seed speedrunning legal stronghold finder using perfect travel

## Before you use this, learn how perfect travel works
Read the [Perfect Travel document] and/or watch the [Perfect Travel video] to understand how perfect travel works.
This script will replace the need for you to do any math, so the important thing is to learn how to get the angle, which is found in pages 5 and 6 of the [Perfect Travel document].


## Setup instructions:
Download the [latest release]
Extract the zip folder's contents anywhere (make sure they're all in the same folder).
[Download and install debugview]
[Download and install AutoHotkey]

## Use instructions:
Run the ahk script that you need (either 1 eye or 2 eye) by right clicking on the script file and clicking Run Script.
Open up DebugView (the program that you installed).
Once you get your angle and f3 c, pause and press Ctrl P.
Follow the instructions in the GUI and wait for DebugView to show what you need.
If you're doing 1 eye, then the first location that shows up is the closest.
If you're doing 2 eye, then throw another eye from a neighboring chunk. Try to go in a direction perpendicular to the eye. For example, if your initial angle was 1 degree, that means the eye is pointing south, so go in the chunk either east or west of you.
After it's done "computing" the numbers for second eye, it'll give you a final destination chunk to go to.

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
