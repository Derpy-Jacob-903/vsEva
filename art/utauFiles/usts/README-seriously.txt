•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

1. What even is this?

It's a batch script to make Friday Night Funkin' charts from USTs

•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

2. Are there requirements?

You'll need:
Windows cmd - to be able to run .bat files
cscript.exe - to be able to run the .vbs scripts
ALSO YOU NEED TO ENABLE cscript (run enablecscript.bat if it is not)
Windows powershell - to be able to run additional commands in the script

•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

3. Ok so how do I use this?

The thing you want to open is "ust_2_fnfchart.bat"
(DO NOT DELETE THE .vbs FILES)

1st input is the file of the player1 ust (player1 us usually BF/the character you're playing)
2nd-5th inputs are the lyrics for each arrow note for player1 (It is usually: "i" for ←, "u" or "o" for ↓, "a" for ↑, and "e" for →) (For multiple lyrics, separate them with a comma/,)

It will then read each note that is in the file of the 1st input

6th input is the file of the player2 ust (player2 us usually the character playing against)
7th-10th inputs are the lyrics for each arrow note for player2 (It is usually: "e" for ←, "u" or "o" for ↓, "a" for ↑, and "i" for →) (For multiple lyrics, separate them with a comma/,)


It will then read each note that is in the file of the 6th input

It will then process every section notes for both players

11th-21st inputs are for the data that will be in the output
18th-21st inputs are for the data for each section that will be in the output

The last input is the output file name (you should save the output file as a .json file)

•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

4. Hey! Why does it only face player1?! And why is it all just single notes?!

	1. For now the mustHitSection is always true, meaning ingame the camera only faces player1. I'm planning to make changing mustHitSections but it's not a High Priority.
	2. For now the script can only make single hold notes.
	
	If you want the chart to have switching cameras and hold notes you can edit and/or rechart the chart ingame with the Debug Menu. (Example: To make a section face player2 you go to the Section menu, untick mustHitSection and use the "Swap Section" function)


•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

5. Um, what is the "players-sectionnotes" and "temp_notelyrics" folder?

It's a temporary folder to store temporary note data
If it doesn't already exist, it will be created when starting the script
Everything in the folder is deleted when starting the script

•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

6. Any credits?

The example input USTs are from the song "Terminal" from the Salty's Sunday Night Mod
The example input USTs are made by me

•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••