local blind = {
    name = "The Trick",
    key = "trick",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 23},
    boss = {min = 4, max = 10},
    boss_colour = HEX('34715a'),
    loc_txt = {
        name ="The Trick",
        text={
            "Debuffs cards not of",
            "the lead suit played",
        },
    },
}

blind.eman_before_play = function (self, played_hand)
    local first = played_hand[1]

    for i = 2, #played_hand do
        local card = played_hand[i]

        if not card:is_suit(first.base.suit) and not first:is_suit(card.base.suit) then
            card:set_debuff(true)
        end
    end
end




return blind