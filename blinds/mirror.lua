local blind = {
    name = "The Mirror",
    key = "mirror",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 19},
    boss = {min = 3, max = 10},
    boss_colour = HEX('729678'),
    loc_txt = {
        name ="The Mirror",
        text={
            "Cards discarded previously",
            "this ante are drawn face down",
        },
    },
}

blind.stay_flipped = function (self, area, card)

    if area ~= G.hand then return false end

    return card.ability.discarded_this_ante
end




return blind