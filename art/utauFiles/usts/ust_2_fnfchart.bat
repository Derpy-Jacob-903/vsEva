@echo off
cls
title UST -^> FNF Chart
chcp 65001 >nul
setlocal EnableDelayedExpansion
if not exist "players-sectionnotes\" md players-sectionnotes
@echo y | del "players-sectionnotes\" >nul
if not exist "temp_notelyrics\" md temp_notelyrics
@echo y | del "temp_notelyrics\" >nul

:input_player1
cls
echo For player1:
set /p "input1=File input (.ust)>"
if not exist %input1% (
echo  
echo File input "%input1%" does not exist!
echo Continue anyway? ^(Choosing N will retry input^)
choice
if !ERRORLEVEL! equ 2 goto:input_player1

)
set /p "timesig1=Time Signature (Example: 3/4)>"
for /f "delims=" %%c in ('cscript //nologo "math.vbs" "1920*(%timesig1%)"') do (set "sectionlength_1=%%c")
echo.
echo Use 'Choose note for each lyric' mode?
choice
set ifuse_cnfel=0
if %ERRORLEVEL% equ 1 set ifuse_cnfel=1
if not %ifuse_cnfel%==1 (
echo.
echo ^(For multiple lyrics, separate them with a comma/","^)
set /p "input1_1lyrics=Lyric/s for "←"  ->"
set /p "input1_2lyrics=Lyric/s for "↓"  ->"
set /p "input1_3lyrics=Lyric/s for "↑"  ->"
set /p "input1_4lyrics=Lyric/s for "→"  ->"
)
::Left
echo !input1_1lyrics:,=^

!>temp_notelyrics\1lyrics1.temp

::Down
echo !input1_2lyrics:,=^

!>temp_notelyrics\2lyrics1.temp

::Up
echo !input1_3lyrics:,=^

!>temp_notelyrics\3lyrics1.temp

::Right
echo !input1_4lyrics:,=^

!>temp_notelyrics\4lyrics1.temp

:read1
set lolwut=
set curlyric=
set curlength=
set ifrest=0
set section1count=0
set note1count=0
set display_note1count=0000
set mssadd=0
set lengthadd=0
set ifdisplaysectioncount_1=0
for /f "delims=" %%a in (%input1%) do (
set "curline=%%a"
if "%%a"=="[#VERSION]" set lolwut=version
if "%%a"=="[#SETTING]" set lolwut=setting
if "%%a"=="[#TRACKEND]" set lolwut=end

if !lolwut!==setting (
if "!curline:~0,6!"=="Tempo=" (set "bpm1=!curline:~6!" & set "ifdisplaysectioncount_1=1"& echo Found BPM: !bpm1!)
)
if !lolwut!==donenoteread (
set /a "note1count+=1"
set display_note1count=!note1count!
if "!display_note1count:~1,1!"=="" set "display_note1count=0!display_note1count!"
if "!display_note1count:~2,1!"=="" set "display_note1count=0!display_note1count!"
if "!display_note1count:~3,1!"=="" set "display_note1count=0!display_note1count!"
set lolwut=
)

if !ifdisplaysectioncount_1! equ 1 (
echo Section: !section1count!
set ifdisplaysectioncount_1=0
)

if "%%a"=="[#!display_note1count!]" (
if defined curlength if defined curlyric (
for /f "delims=" %%o in ('cscript //nologo "math.vbs" "!mssadd!+(1000/(!bpm1!/(1.875*(!curlength!/15))))"') do set "curnote_startmss=%%o"
if !ifrest! neq 1 (
echo !mssadd!,!curnotedirection1!,0
)>>players-sectionnotes\player1_section!section1count!Notes.temp

set "disp_curnotedirection1=UNKNOWN NOTE [!curnotedirection1!]"
set "disp_arrow1_1=  "
set "disp_arrow2_1=  "
set "disp_arrow3_1=  "
set "disp_arrow4_1= "
if !curnotedirection1! equ 0 (set "disp_curnotedirection1=← [!curnotedirection1!]" & set "disp_arrow1_1=← ")
if !curnotedirection1! equ 1 (set "disp_curnotedirection1=↓ [!curnotedirection1!]" & set "disp_arrow2_1=↓ ")
if !curnotedirection1! equ 2 (set "disp_curnotedirection1=↑ [!curnotedirection1!]" & set "disp_arrow3_1=↑ ")
if !curnotedirection1! equ 3 (set "disp_curnotedirection1=→ [!curnotedirection1!]" & set "disp_arrow4_1=→")
set "disp_format=!mssadd!,!curnotedirection1!,0"
for /f "delims=" %%o in ('cscript //nologo "math.vbs" "1920/!curlength!"') do set "lolwut_curlength=%%o"
if !ifrest! equ 1 set "disp_arrow1_1=R-" & set "disp_arrow2_1=E-" & set "disp_arrow3_1=S-" & set "disp_arrow4_1=T" & set "disp_curnotedirection1=N/A [REST]" & set "disp_format=N/A [REST]"
echo 	^| !disp_arrow1_1!!disp_arrow2_1!!disp_arrow3_1!!disp_arrow4_1! ^| ^( Lyric:!curlyric! ^| Length=!curlength! [1^/!lolwut_curlength! NOTE] ^| Note:!disp_curnotedirection1! ^| Output Format:!disp_format! ^)
set disp_arrow1_1=
set disp_arrow2_1=
set disp_arrow3_1=
set disp_arrow4_1=


set "mssadd=!curnote_startmss!"
set /a lengthadd+=!curlength!
if !lengthadd! equ %sectionlength_1% (set /a "section1count+=1" & set ifdisplaysectioncount_1=1& for /f "delims=" %%o in ('cscript //nologo "math.vbs" "!lengthadd!-%sectionlength_1%"') do set "lengthadd=%%o")
if !lengthadd! gtr %sectionlength_1% (set /a "section1count+=1" & set ifdisplaysectioncount_1=1& for /f "delims=" %%o in ('cscript //nologo "math.vbs" "!lengthadd!-%sectionlength_1%"') do set "lengthadd=%%o")

)
set curlength=
set curlyric=
set lolwut=noteread
)
if !lolwut!==noteread if "!curline:~0,7!"=="Length=" set "curlength=!curline:~7!"
if !lolwut!==noteread if "!curline:~0,6!"=="Lyric=" if not defined curlyric (
set "curlyric=!curline:~6!"

set ifrest=0

::Rest
if not %ifuse_cnfel%==1 if exist rlyrics1.temp for /f "delims=" %%n in (rlyrics1.temp) do if "!curlyric!"=="%%n" set ifrest=1
if /i "!curlyric!"=="R" set ifrest=1

::Left
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\1lyrics1.temp) do if "!curlyric!"=="%%n" set curnotedirection1=0

::Down
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\2lyrics1.temp) do if "!curlyric!"=="%%n" set curnotedirection1=1

::Up
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\3lyrics1.temp) do if "!curlyric!"=="%%n" set curnotedirection1=2

::Right
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\4lyrics1.temp) do if "!curlyric!"=="%%n" set curnotedirection1=3

set ifunknownlyric=1
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\1lyrics1.temp,temp_notelyrics\2lyrics1.temp,temp_notelyrics\3lyrics1.temp,temp_notelyrics\4lyrics1.temp) do (if "%%n"=="!curlyric!" set ifunknownlyric=0)
if %ifuse_cnfel%==1 set ifunknownlyric=1
if /i "!curlyric!"=="R" set ifunknownlyric=0

if !ifunknownlyric! equ 1 (
echo 
echo ==================================
echo ERROR: UNKNOWN LYRIC
echo Lyric: !curlyric!
echo.
echo Choose what note this is:
echo [W] for "↑"
echo [A] for "←"
echo [S] for "↓"
echo [D] for "→"
echo [R] for REST
echo.
echo. or:
echo.
echo    [W]   [R]    [↑]   [Rest]
echo [A][S][D]    [←][↓][→]
echo  ChoiceKeys ^|  Arrows/Rest
echo.
choice /c WASDR /n /m "CHOICE:"
if !ERRORLEVEL! equ 1 set "curnotedirection1=2" & set "lolwut_error_un=3lyrics1.temp"
if !ERRORLEVEL! equ 2 set "curnotedirection1=0" & set "lolwut_error_un=1lyrics1.temp"
if !ERRORLEVEL! equ 3 set "curnotedirection1=1" & set "lolwut_error_un=2lyrics1.temp"
if !ERRORLEVEL! equ 4 set "curnotedirection1=3" & set "lolwut_error_un=4lyrics1.temp"
if !ERRORLEVEL! equ 5 set set "ifrest=1" & set "lolwut_error_un=rlyrics1.temp"
if not %ifuse_cnfel%==1 (
choice /c YN /n /m "Remember choice note lyric? [Y,N]:" 
if !ERRORLEVEL! equ 1 echo !curlyric!>>temp_notelyrics\!lolwut_error_un!
)
echo ==================================
echo.
)

if defined curlength if defined curlyric set lolwut=donenoteread
)

)

echo 
:input_player2
cls
echo For player2:
set /p "input2=File input (.ust)>"
if not exist %input2% (
echo  
echo File input "%input2%" does not exist!
echo Continue anyway? ^(Choosing N will retry input^)
choice
if !ERRORLEVEL! equ 2 goto:input_player2

)
set /p "timesig2=Time Signature (Example: 3/4)>"
for /f "delims=" %%c in ('cscript //nologo "math.vbs" "1920*(%timesig1%)"') do (set "sectionlength_2=%%c")
echo.
echo Use 'Choose note for each lyric' mode?
choice
set ifuse_cnfel=0
if %ERRORLEVEL% equ 1 set ifuse_cnfel=1
if not %ifuse_cnfel%==1 (
echo.
echo ^(For multiple lyrics, separate them with a comma/","^)
set /p "input2_1lyrics=Lyric/s for "←"  ->"
set /p "input2_2lyrics=Lyric/s for "↓"  ->"
set /p "input2_3lyrics=Lyric/s for "↑"  ->"
set /p "input2_4lyrics=Lyric/s for "→"  ->"
)
::Left
echo !input2_1lyrics:,=^

!>temp_notelyrics\1lyrics2.temp

::Down
echo !input2_2lyrics:,=^

!>temp_notelyrics\2lyrics2.temp

::Up
echo !input2_3lyrics:,=^

!>temp_notelyrics\3lyrics2.temp

::Right
echo !input2_4lyrics:,=^

!>temp_notelyrics\4lyrics2.temp

:read2
set lolwut=
set curlyric=
set curlength=
set ifrest=0
set section2count=0
set note2count=0
set display_note2count=0000
set mssadd=0
set lengthadd=0
set ifdisplaysectioncount_2=0
for /f "delims=" %%a in (%input2%) do (
set "curline=%%a"
if "%%a"=="[#VERSION]" set lolwut=version
if "%%a"=="[#SETTING]" set lolwut=setting
if "%%a"=="[#TRACKEND]" set lolwut=end

if !lolwut!==setting (
if "!curline:~0,6!"=="Tempo=" (set "bpm2=!curline:~6!" & set "ifdisplaysectioncount_2=1"& echo Found BPM: !bpm2!)
)

if !lolwut!==donenoteread (
set /a "note2count+=1"
set display_note2count=!note2count!
if "!display_note2count:~1,1!"=="" set "display_note2count=0!display_note2count!"
if "!display_note2count:~2,1!"=="" set "display_note2count=0!display_note2count!"
if "!display_note2count:~3,1!"=="" set "display_note2count=0!display_note2count!"
set lolwut=
)

if !ifdisplaysectioncount_2! equ 1 (
echo Section: !section2count!
set ifdisplaysectioncount_2=0
)

if "%%a"=="[#!display_note2count!]" (
if defined curlength if defined curlyric (
for /f "delims=" %%o in ('cscript //nologo "math.vbs" "!mssadd!+(1000/(!bpm2!/(1.875*(!curlength!/15))))"') do set "curnote_startmss=%%o"
if !ifrest! neq 1 (
echo !mssadd!,!curnotedirection2!,0
)>>players-sectionnotes\player2_section!section2count!Notes.temp

set "disp_curnotedirection2=UNKNOWN NOTE [!curnotedirection2!]"
set "disp_arrow1_2=  "
set "disp_arrow2_2=  "
set "disp_arrow3_2=  "
set "disp_arrow4_2= "
if !curnotedirection2! equ 4 (set "disp_curnotedirection2=← [!curnotedirection2!]" & set "disp_arrow1_2=← ")
if !curnotedirection2! equ 5 (set "disp_curnotedirection2=↓ [!curnotedirection2!]" & set "disp_arrow2_2=↓ ")
if !curnotedirection2! equ 6 (set "disp_curnotedirection2=↑ [!curnotedirection2!]" & set "disp_arrow3_2=↑ ")
if !curnotedirection2! equ 7 (set "disp_curnotedirection2=→ [!curnotedirection2!]" & set "disp_arrow4_2=→")
set "disp_format=!mssadd!,!curnotedirection2!,0"
for /f "delims=" %%o in ('cscript //nologo "math.vbs" "1920/!curlength!"') do set "lolwut_curlength=%%o"
if !ifrest! equ 1 set "disp_arrow1_2=R-" & set "disp_arrow2_2=E-" & set "disp_arrow3_2=S-" & set "disp_arrow4_2=T" & set "disp_curnotedirection2=N/A [REST]" & set "disp_format=N/A [REST]"
echo 	^| !disp_arrow1_2!!disp_arrow2_2!!disp_arrow3_2!!disp_arrow4_2! ^| ^( Lyric:!curlyric! ^| Length=!curlength! [1^/!lolwut_curlength! NOTE] ^| Note:!disp_curnotedirection2! ^| Output Format:!disp_format! ^)
set disp_arrow1_2=
set disp_arrow2_2=
set disp_arrow3_2=
set disp_arrow4_2=


set "mssadd=!curnote_startmss!"
set /a lengthadd+=!curlength!
if !lengthadd! equ %sectionlength_2% (set /a "section2count+=1" & set ifdisplaysectioncount_2=1& for /f "delims=" %%o in ('cscript //nologo "math.vbs" "!lengthadd!-%sectionlength_2%"') do set "lengthadd=%%o")
if !lengthadd! gtr %sectionlength_2% (set /a "section2count+=1" & set ifdisplaysectioncount_2=1& for /f "delims=" %%o in ('cscript //nologo "math.vbs" "!lengthadd!-%sectionlength_2%"') do set "lengthadd=%%o")

)
set curlength=
set curlyric=
set lolwut=noteread
)
if !lolwut!==noteread if "!curline:~0,7!"=="Length=" set "curlength=!curline:~7!"
if !lolwut!==noteread if "!curline:~0,6!"=="Lyric=" if not defined curlyric (
set "curlyric=!curline:~6!"

set ifrest=0

::Rest
if not %ifuse_cnfel%==1 if exist rlyrics2.temp for /f "delims=" %%n in (rlyrics2.temp) do if "!curlyric!"=="%%n" set ifrest=1
if /i "!curlyric!"=="R" set ifrest=1

::Left
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\1lyrics2.temp) do if "!curlyric!"=="%%n" set curnotedirection2=4

::Down
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\2lyrics2.temp) do if "!curlyric!"=="%%n" set curnotedirection2=5

::Up
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\3lyrics2.temp) do if "!curlyric!"=="%%n" set curnotedirection2=6

::Right
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\4lyrics2.temp) do if "!curlyric!"=="%%n" set curnotedirection2=7

set ifunknownlyric=1
if not %ifuse_cnfel%==1 for /f "delims=" %%n in (temp_notelyrics\1lyrics2.temp,temp_notelyrics\2lyrics2.temp,temp_notelyrics\3lyrics2.temp,temp_notelyrics\4lyrics2.temp) do (if "%%n"=="!curlyric!" set ifunknownlyric=0)
if %ifuse_cnfel%==1 set ifunknownlyric=1
if /i "!curlyric!"=="R" set ifunknownlyric=0

if "!curline:~0,6!"=="Lyric=" if !ifunknownlyric! equ 1 (
echo 
echo ==================================
echo ERROR: UNKNOWN LYRIC
echo Lyric: !curlyric!
echo.
echo Choose what note this is:
echo [W] for "↑"
echo [A] for "←"
echo [S] for "↓"
echo [D] for "→"
echo [R] for REST
echo.
echo. or:
echo.
echo    [W]   [R]    [↑]   [Rest]
echo [A][S][D]    [←][↓][→]
echo  ChoiceKeys ^|  Arrows/Rest
echo.
choice /c WASDR /n /m "CHOICE:"
if !ERRORLEVEL! equ 1 set "curnotedirection2=6" & set "lolwut_error_un=3lyrics2.temp"
if !ERRORLEVEL! equ 2 set "curnotedirection2=4" & set "lolwut_error_un=1lyrics2.temp"
if !ERRORLEVEL! equ 3 set "curnotedirection2=5" & set "lolwut_error_un=2lyrics2.temp"
if !ERRORLEVEL! equ 4 set "curnotedirection2=7" & set "lolwut_error_un=4lyrics2.temp"
if !ERRORLEVEL! equ 5 set "ifrest=1" & set "lolwut_error_un=rlyrics2.temp"
if not %ifuse_cnfel%==1 (
choice /c YN /n /m "Remember choice note lyric? [Y,N]:" 
if !ERRORLEVEL! equ 1 echo !curlyric!>>temp_notelyrics\!lolwut_error_un!
)
echo ==================================
echo.
)

if defined curlength if defined curlyric set lolwut=donenoteread
)

)

if %section1count% gtr %section2count% (set gtr_sectioncount=%section1count%) else (set gtr_sectioncount=%section2count%)
echo 
echo Processing sections...
echo.
for /l %%a in (0,1,%gtr_sectioncount%) do (
set if_section_notexist=0
(
if exist "players-sectionnotes\player1_section%%aNotes.temp" type "players-sectionnotes\player1_section%%aNotes.temp"
if exist "players-sectionnotes\player2_section%%aNotes.temp" type "players-sectionnotes\player2_section%%aNotes.temp"
)>"players-sectionnotes\section%%aNotes.temp"
if exist "players-sectionnotes\player1_section%%aNotes.temp" del "players-sectionnotes\player1_section%%aNotes.temp"
if exist "players-sectionnotes\player2_section%%aNotes.temp" del "players-sectionnotes\player2_section%%aNotes.temp"
set cur_section_data=
for /f "delims=" %%j in (players-sectionnotes\section%%aNotes.temp) do (if not defined cur_section_data set "cur_section_data=%%j")


if not "!cur_section_data!"=="" (
for /f "skip=3 tokens=1-3" %%x in ('powershell "$file = Import-Csv -Header "Col1", "Col2", "Col3" -delimiter ',' "players-sectionnotes\section%%aNotes.temp"; $file | Sort-Object { [double]$_.Col1 } | Format-Table -AutoSize -Wrap"') do echo %%x,%%y,%%z>>"players-sectionnotes\new_section%%aNotes.temp"
del "players-sectionnotes\section%%aNotes.temp"
ren "players-sectionnotes\new_section%%aNotes.temp" "section%%aNotes.temp"
powershell -command "& {$stream = [IO.File]::OpenWrite('players-sectionnotes\section%%aNotes.temp'); $stream.SetLength($stream.Length - 2); $stream.Close(); $stream.Dispose()}"
cscript "newline_to_noteformat.vbs" "players-sectionnotes\section%%aNotes.temp">nul
)
echo Section %%a^/%gtr_sectioncount% done.
)

set "bpm_forboth=%bpm1%"
set "timesig_forboth=%timesig1%"


if not "%bpm1%"=="%bpm2%" (
echo 
echo Found that the BPM found in both USTs are not identical
echo BPM1 = "%bpm1%"
echo BPM2 = "%bpm2%"
echo.
echo You have to set the BPM to use for the output chart ^(if specific inputs are not defined^)
set /p "bpm_forboth=BPM (FOR CHART)>"
)

if not "%timesig1%"=="%timesig2%" (
echo 
echo Found the the input Time Signatures for both player1 ^& player2 are not identical
echo TimeSig.1 = "%timesig1%"
echo TimeSig.2 = "%timesig2%"
echo.
echo You have to set the Time signature to use for the output chart ^(if specific inputs are not defined^)
set /p "timesig_forboth=Time Signature (FOR CHART) (Example: 3/4)>"
)

set c_input_altAnim=
set c_input_bpm=
set c_input_bpm2=
set c_input_changeBPM=
set c_input_lengthInSteps=
set c_input_needsVoices=
set c_input_player1=
set c_input_player2=
set c_input_song=
set c_input_speed=
set c_input_validScore=


echo Chart data input:
echo.
set /p "c_input_player1=Player 1 characterName:"
set /p "c_input_player2=Player 2 characterName:"
set /p "c_input_song=Song name (DO NOT PUT IN QUOTES):"
set /p "c_input_validScore=if validScore:"
set /p "c_input_needsVoices=if chart Track needs Voices:"
set /p "c_input_speed=Chart scroll speed:"
set /p "c_input_bpm=BPM (NO INPUT WILL USE THE BPM FOUND IN THE UST/s):"
if not defined c_input_bpm set "c_input_bpm=%bpm_forboth%"
echo.
echo 	For every section:
set /p "c_input_lengthInSteps=	lengthInSteps (NO INPUT WILL USE FORMULA: "16*(Time signature)" ):"
if not defined c_input_lengthInSteps for /f "delims=" %%c in ('cscript //nologo "math.vbs" "16*(%timesig_forboth%)"') do (set "c_input_lengthInSteps=%%c")
set /p "c_input_altAnim=	altAnim:"
set /p "c_input_changeBPM=	changeBPM:"
set /p "c_input_bpm2=	BPM (NO INPUT WILL USE THE SAME BPM FROM THE LAST BPM INPUT):"
if not defined c_input_bpm2 set "c_input_bpm2=%c_input_bpm% "
echo.
echo.
set /p "c_input_output_lol=File output name:"


::TIME TO WRITE!!!
(
echo {"song":
echo 	{
echo 	"sectionLengths":[]
echo 	,"player1":"%c_input_player1%"
echo 	,"player2":"%c_input_player2%"
echo 	,"notes":
echo 		[
set writesection_count=0
for /l %%a in (0,1,%gtr_sectioncount%) do (
set /a writesection_count+=1

if !writesection_count! equ 1 (echo 			{"typeOfSection":0) else (echo 			,{"typeOfSection":0)
set cur_section_data=
for /f "delims=" %%j in (players-sectionnotes\section%%aNotes.temp) do (if not defined cur_section_data set "cur_section_data=%%j")
if not "!cur_section_data!"=="" for /f "delims=" %%h in (players-sectionnotes\section%%aNotes.temp) do echo 			,"sectionNotes":[[%%h]]
if "!cur_section_data!"=="" echo 			,"sectionNotes":[]
echo 			,"lengthInSteps":%c_input_lengthInSteps%
echo 			,"altAnim":%c_input_altAnim%
echo 			,"bpm":%c_input_bpm2%
echo 			,"changeBPM":%c_input_changeBPM%
echo 			,"mustHitSection":true
echo 			}
)
echo 		]
echo 		,"song":"%c_input_song%"
echo 		,"validScore":%c_input_validScore%
echo 		,"sections":0
echo 		,"needsVoices":%c_input_needsVoices%
echo 		,"speed":%c_input_speed%
echo 		,"bpm":%c_input_bpm%
echo 	}
echo }
)>"%c_input_output_lol%"

echo 
echo DONE!
pause