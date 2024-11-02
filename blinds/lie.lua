local blind = {
    name = "The Lie",
    key = "lie",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 1},
    boss = {min = 5, max = 10},
    boss_colour = HEX('904ca0'),
    loc_txt = {
        name ="The Lie",
        text={
            "Ranks and Suits are",
            "randomized this blind",
        },
    },
}

blind.set_blind = function (self)
    if not self.disabled then
        for _, card in ipairs(G.playing_cards) do
            card.ability.truth = card.config.card

            card:set_base(pseudorandom_element(G.P_CARDS, pseudoseed('lie')))
        end
    end
end

blind.disable = function (self)
    for _, card in ipairs(G.playing_cards) do
        if (card.ability.truth) then
            card:set_base(card.ability.truth)
        end
    end
end

blind.defeat = function (self)
    for _, card in ipairs(G.playing_cards) do
        if (card.ability.truth) then
            card:set_base(card.ability.truth)
        end
    end
end



return blind