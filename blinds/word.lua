local blind = {
    name = "The Word",
    key = "word",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 17},
    boss = {min = 2, max = 10},
    boss_colour = HEX('2750cd'),
    loc_txt = {
        name ="The Word",
        text={
            "One card drawn face",
            "down per suit in hand",
        },
    },
}

blind.stay_flipped = function (self, area, card)

    if area ~= G.hand then return false end

    for _, v in ipairs(G.hand.cards) do
        if v.base.suit == card.base.suit and v.ability.wheel_flipped then
            return false
        end
    end

    return true
end



return blind