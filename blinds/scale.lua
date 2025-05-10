local blind = {
    name = "The Scale",
    key = "scale",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 2},
    boss = {min = 5, max = 10},
    boss_colour = HEX('a54752'),
    loc_txt = {
        name ="The Scale",
        text={
            "Listed probabilities are",
            "reduced by 4x",
        },
    },
}

--[[
blind.defeat = function (self)

    if (not G.GAME.blind.disabled) and (G.GAME.chips >= G.GAME.blind.chips * 2) then
        for _, joker in ipairs(G.jokers.cards) do
            joker:set_eternal(true)
            if (joker.ability.eternal) then
                joker:juice_up(0.3, 0.3)
            end
        end
    end
end
]]--

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.prepped = true
    G.GAME.blind.eman_extra.probability_change = 4

    G.GAME.probabilities.normal = G.GAME.probabilities.normal / G.GAME.blind.eman_extra.probability_change
end

blind.disable = function (self)
    G.GAME.probabilities.normal = G.GAME.probabilities.normal * G.GAME.blind.eman_extra.probability_change

    G.GAME.blind.eman_extra.probability_change = 1
end

blind.defeat = function (self)
    if not G.GAME.blind.disabled then
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * G.GAME.blind.eman_extra.probability_change
    end
end



return blind