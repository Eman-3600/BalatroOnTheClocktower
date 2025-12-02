local blind = {
    name = "Vicious Vortex",
    key = "vicious_vortex",
    mult = 2,
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 30},
    boss = {min = 1, max = 10, showdown = true},
    dollars = 8,
    boss_colour = HEX('e7bf40'),
    loc_txt = {
        name ="Vicious Vortex",
        text={
            "Base Chips and Mult are zeroed",
            "if money is less than $#1#",
        },
    },
}

blind.loc_vars = function (self)

    return { vars = {number_format(5 * G.GAME.round_resets.ante + 10)}}
end

blind.collection_loc_vars = function (self)

    return { vars = {"(10 + 5 * Ante)"}}
end

blind.modify_hand = function (self, cards, poker_hands, text, mult, hand_chips)
    if G.GAME.dollars < (5 * G.GAME.round_resets.ante + 10) then
        return 0, 0, true
    end
    return mult, hand_chips, false
end

return blind