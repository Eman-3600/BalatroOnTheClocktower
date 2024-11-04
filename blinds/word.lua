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
            "1 card of each",
            "suit drawn face down",
        },
    },
}

blind.stay_flipped = function (self, area, card)

    if area ~= G.hand then return false end

    for _, v in ipairs(G.hand.cards) do
        if v.ability.wheel_flipped and (v:is_suit(card.base.suit) or card:is_suit(v.base.suit)) then
            return false
        end
    end

    return true
end



return blind