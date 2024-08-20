extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#MUSIC

func mainmenumusic():
	$Music/MainMenuMusic.play()
func stopmainmenumusic():
	$Music/MainMenuMusic.stop()
	
func tutorialmusic():
	$Music/TutorialMusic.play()
func stoptutorialmusic():
	$Music/TutorialMusic.stop()

#SFX

func steps():
	$SFX/Steps.play()
func stopsteps():
	$SFX/Steps.stop()
	
func jumpsound():
	$SFX/JumpSound.play()
func stopjumpsound():
	$SFX/JumpSound.stop()
	
func uihover():
	$SFX/UIHover.play()	
	
func uiclick():
	$SFX/UIClick.play()	
	
func uienter():
	$SFX/UIEnter.play()	
	
func uiquit():
	$SFX/UIQuit.play()
func uiquitno():
	$SFX/UIQuitNo.play()
func uiquityes():
	$SFX/UIQuitYes.play()
	
func newdialogue():
	$SFX/NewDialogue.play()

func hidedialogue():
	$SFX/HideDialogue.play()

func lupasound1():
	$SFX/LupaSound1.play()
func lupasound2():
	$SFX/LupaSound2.play()
func lupasound3():
	$SFX/LupaSound3.play()
func lupasound4():
	$SFX/LupaSound4.play()
func lupasound5():
	$SFX/LupaSound5.play()
func lupasound6():
	$SFX/LupaSound6.play()
func lupasound7():
	$SFX/LupaSound7.play()
func lupasound8():
	$SFX/LupaSound8.play()

func deathsound():
	$Voices/DeathSound.play()

func blink():
	$SFX/Blink.play()
func stopblink():
	$SFX/Blink.stop()
	
func entersound():
	$SFX/EnterSound.play()
#VOICES

func jumpvoice():
	$Voices/JumpVoice.play()
func stopjumpvoice():
	$Voices/JumpVoice.stop()
	
func uino():
	$Voices/UINo.play()

func turtlevoice():
	$Voices/TurtleVoice.play()
func stopturtlevoice():
	$Voices/TurtleVoice.stop()
	$Voices/TurtleVoice.play()
	
func ramirovoice():
	$Voices/RamiroVoice.play()
func stopramirovoice():
	$Voices/RamiroVoice.stop()
	$Voices/RamiroVoice.play()	

func ratvoice():
	$Voices/RatVoice.play()
func stopratvoice():
	$Voices/RatVoice.stop()
	$Voices/RatVoice.play()

func nabovoice():
	$Voices/NaboVoice.play()
func stopnabovoice():
	$Voices/NaboVoice.stop()
	$Voices/NaboVoice.play()

func land():
	$SFX/LandSound.play()
