local blind = {
    name = "The Talon",
    key = "talon",
    mult = 1,
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 22},
    boss = {min = 2, max = 10},
    debuff = {h_size_le = 4},
    boss_colour = HEX('c68329'),
    loc_txt = {
        name ="The Talon",
        text={
            "Cannot play more",
            "than 4 cards",
        },
    },
}

blind.get_loc_debuff_text = function (self)
    return "Must play fewer than 5 cards"
end




return blind