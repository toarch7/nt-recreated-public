credittext = [
    "",
    "@yVLAMBEER @wPRESENTS",
    "@wA GAME BY",
    "@wPROJECT LEAD, DESIGN & DEVELOPMENT#@sJAN WILLIEM NIJMAN",
    "@wPRODUCTION & ADDITIONAL DEVELOPMENT#@sRAMI ISMAIL",
    "@wART DIRECTION, LEAD ARTIST & ANIMATION#@sPAUL VEER",
    "@wORIGINAL SOUNDTRACK#@sJUKIO KALLIO",
    "@wSOUND DESIGN#@sJOONAS TURNER",
    "@wADDITIONAL ARTWORKING#@sJUSTIN CHAN",
	
    "@s(NON-VLAMBEER CREDITS PART)",
    
    "@wMOBILE PORT#@sTONCHO_",
    "@wCONTRIBUTORS#@sCILIAN",
    "@wTESTING@s##EVILCAT#CZIMBALA#SKU#WINT#VOROB,#DRAKIN#TIREDMETAL#IOMEGAI#PLOWECH#SENJEY##AND OTHERS",
    
    "@wPORTUGUESE TRANSLATION@s##EDU#MIGUEL#TITIO CARTOLA#GUIZARD#POTATO SALAD",
    "@wSPANISH TRANSLATION@s##FRI#BAYRON#WALTERLZ",
    "@wPOLISH TRANSLATION@s#LOSSTAROTT",
    "@wUKRAINIAN TRANSLATION@s##PRAWO#REPKON#CZIMBALA",
	"@wRUSSIAN TRANSLATION@s##TONCHO_#CILIAN###@sCYRILLIC BIGNAME GLYPHS#BORROWED FROM FOBE'S RUSSIFIER",
    "@wPERSIAN TRANSLATION@s#PLOOB",
	"@w\"M1\" FONT FROM ORIGINL GAME#@sYELLOWAFTERLIFE",
    
    "@wSPECIAL THANKS@s##@yVLAMBEER#@YYELLOWAFTERLIFE@s##AMVN#PATIENCE#SENJEY#ZOOBEAST#CILIAN#NEIBERN__#JOELOWMILLER#OLEZHA487#WILLIGIROUX#ANTONIOLOPEZLARE#YAMATVEY#NICELOPO123#XSENOXSOGOLIK#SBB##AND ALL OF THE DISCORD SERVER MEMBERS",
    
    "@wTHANK YOU FOR PLAYING!"
]

event_user(1)

show = 0
scroll = 0
scroll_delay = 0
scroll_speed = 0
largetext = false
height = 0
timer = 60
text = ""

if (!instance_exists(MenuOptions)) {
	audio_stop_all()
	
	snd_play(sndRestart)
	
	if (!instance_exists(SpiralCont)) {
		with (instance_create(x, y, SpiralCont)) {
			bossfight = true
		}
	}
	
	instance_destroy(MusCont)
	
	with instance_create(0, 0, MusCont) {
	    snd_stop(song)
	    snd_stop(amb)
	    alarm[0] = -1
	    song = musCredits
	    amb = amb0
	    song = custom_sound_check(song)
	    amb = custom_sound_check(amb)
	    snd_play(song)
	}
	
	file_delete(savegame_file)
}

scrLetterbox(false)