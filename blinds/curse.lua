local blind = {
    name = "The Curse",
    key = "curse",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 8},
    boss = {min = 3, max = 10},
    boss_colour = HEX('60468e'),
    loc_txt = {
        name ="The Curse",
        text={
            "Destroys your",
            "winning hand",
        },
    },
}

blind.eman_should_destroy = function (self, card, hand_chips, mult)
    G.GAME.blind.triggered = G.GAME.chips + (hand_chips * mult) >= G.GAME.blind.chips
    return G.GAME.blind.triggered
end



return blind