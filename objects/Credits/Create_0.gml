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
    "@s(FURTHER CREDITS PART#IS NOT RELATED TO VLAMBEER)",
    
    "@wMOBILE PORT#@sTONCHO_",
    "@wCONTRIBUTORS#@sCILIAN",
    "@wTESTING@s##EVILCAT#DRAKIN#TIREDMETAL#VOROBUSHEK#IOMEGAI#PLOWECH#SENJEY##AND OTHERS",
    
    "@wPORTUGUESE TRANSLATION@s##EDU#MIGUEL#TITIO CARTOLA#GUIZARD#POTATO SALAD",
    "@wSPANISH TRANSLATION@s##FRI#BAYRON#WALTERLZ",
    "@wUKRAINIAN TRANSLATION@s##PRAWO#REPKON",
    "@wPERSIAN TRANSLATION@s#PLOOB",
    
    "@wSPECIAL THANKS@s##@yVLAMBEER#@YYELLOWAFTERLIFE@s##AMVN#PATIENCE#SENJEY#ZOOBEAST#CILIAN#NEIBERN__#JOELOWMILLER#OLEZHA487#WILLIGIROUX#ANTONIOLOPEZLARE#NICELOPO123#XSENOXSOGOLIK#SBB#AND ALL OF THE DISCORD SERVER MEMBERS",
    
    "@wTHANK YOU FOR PLAYING!"
]

show = 0
alarm[0] = 60

audio_stop_all()

snd_play(sndRestart)

with instance_create(x, y, SpiralCont)
bossfight = 1

with MusCont {
    instance_destroy()
}

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

file_delete("gamestate.dat")
