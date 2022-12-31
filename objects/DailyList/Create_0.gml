history = struct_secure_load(game_directory + "dailyruns.dat")

if is_undefined(history) {
    history = {
        daily: {},
        weekly: {},

        kills: [0, 0]
    }
} else if is_undefined(history[$ "kills"]) {
    history.kills = [0, 0]
}

viewtype = "daily"

dailykeys = struct_keys(history.daily)
weeklykeys = struct_keys(history.weekly)

array_sort(dailykeys, function(a, b) {
    var history = DailyList.history
    return scrReal(history.daily[$ b][$ "timestamp"]) - scrReal(history.daily[$ a][$ "timestamp"])
})

array_sort(weeklykeys, function(a, b) {
    var history = DailyList.history
    return scrReal(history.weekly[$ b][$ "timestamp"]) - scrReal(history.weekly[$ a][$ "timestamp"])
})

alpha = 0

scrWeapons()
scrUltras()

frame = 0

page = 0