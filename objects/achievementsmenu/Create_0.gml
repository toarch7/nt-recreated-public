scrAchievements()
ypos = 0
click = 0

mousex = 0
mousey = 0
hold_time = 0

max_height = 0

unlocks = 0
hidden = []

for (var i = 0; i < array_length(chiev_name); i++) {
    chiev_name[i] = loc(chiev_name[i])
    chiev_text[i] = loc(chiev_text[i])

    if chiev_have[i] {
        unlocks++
    }

    if !chiev_have[i] && chiev_hide[i] {
        array_push(hidden, i)
    }

    max_height += 28
}

max_height += 32 * 4 // splits

hiddens = array_length(hidden)

friction = 0.4