/// @description /OUTPUTS WHAT AREA WEAPONS SPAWN AT
function scrGetWeapons() {


    scrWeapons()

    dir = 0
    txt = ""
    repeat(maxwep) {
        txt += string(wep_name[dir]) + ": " + string(wep_area[dir]) + "#"
        dir += 1
    }

    clipboard_set_text(txt)



}