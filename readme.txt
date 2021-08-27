Setup instructions:

First step is to extract the folder's contents anywhere (make sure they're all in the same folder).

Then run the python file using the following steps:
Open up command prompt.
Navigate to the folder that you extracted everything into by typing "cd <the path name>" into command prompt
For example if I'm currently in C:\Users\peej\OneDrive, I would type the following:
cd Documents
and I would now be in C:\Users\peej\OneDrive\Documents.
Once you get to the folder, type the following into command prompt to run the python file:
normalAngle.py
It'll take a couple minutes since it's generating a large table.

Download and install debugview: https://docs.microsoft.com/en-us/sysinternals/downloads/debugview

Now that all your tables are generated, run the ahk script that you need (either 1 eye or 2 eye).




Use instructions (assuming you already know how to get the perfect travel angle):

Open up DebugView on a second monitor (the program that you installed).
Once you get your angle and f3 c, pause and press Ctrl P.
Follow the instructions in the GUI and wait for DebugView to show what you need.
If you're doing 1 eye, then the first location that shows up is the closest.
If you're doing 2 eye, then after it's done "computing" the numbers for second eye, it'll give you a final destination chunk to go to.
