/// @description area_get_name(area,subarea,loop)
/// @param area
/// @param subarea
/// @param loop
function area_get_name_hard(argument0, argument1, argument2) {
    var ___area = "?"
    var ___subarea = "?"
    var ___loop = ""

    if argument0 == 106 {
        ___area = "HQ"
        ___subarea = string(argument1)
    } else if argument0 == 107 {
        ___area = "$$$"
        ___subarea = ""
    } else if argument0 > 100 {
        ___area = string(argument0 - 100)
        ___subarea = "-?"
    } else if argument0 == 100 {
        ___area = "???"
        ___subarea = ""
    } else {
        ___area = string(argument0)
        ___subarea = "-" + string(argument1)
    }

    if instance_exists(Credits) {
        ___area = "END"

        if instance_exists(Cinematic) {
            ___subarea = "1"
        } else if GameCont.area == 106 && GameCont.subarea == 3 {
            ___subarea = "2"
        }

        argument2 = 0
    }

    if argument2 && ___area != 107 {
        ___loop = " H" + string(argument2)
    }

    return ___area + ___subarea + ___loop
}