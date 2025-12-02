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
            "All jokers debuffed if",
            "money is less than $50",
        },
    },
}

blind.recalc_debuff = function (self, card, from_blind)
    return card.area == G.jokers and G.GAME.dollars < 50
end

return blind