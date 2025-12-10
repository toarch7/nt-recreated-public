#macro CHEAT_PRACTICE_FAINTED_TIME (45 * 30)
#macro PLAYER_LEVEL_MAX 10

#macro c_gold      #dad090
#macro c_ultra     #3dc616
#macro c_tooltip   #31293d
#macro c_uidark    #333333
#macro c_uigray    #999999
#macro c_uilight   #dcdcdc

#macro team_none   0
#macro team_enemy  1
#macro team_player 2
#macro team_popo   3

globalvar current_frame, is_desktop, is_mobile, is_steamdeck;

current_frame = 0
is_desktop = ((os_type == os_windows) || (os_type == os_linux) || (os_type == os_macosx))
is_mobile = ((os_type == os_android) || (os_type == os_ios))
is_steamdeck = scr_check_steamdeck()

#macro current_frame_active ((current_frame % 1) < timescale)