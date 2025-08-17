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

blind.calculate = function (self, card, context)
    if (context.destroy_card and context.cardarea == G.play) then
        if (to_big(G.GAME.chips + hand_chips * mult) >= to_big(G.GAME.blind.chips)) then
            return {
                remove = true
            }
        end
    end
end



return blind