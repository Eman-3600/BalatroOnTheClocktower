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
            "reduced to nearly 0",
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
    self.prepped = true
    self.probability_change = 65356

    G.GAME.probabilities.normal = G.GAME.probabilities.normal / self.probability_change
end

blind.disable = function (self)
    G.GAME.probabilities.normal = G.GAME.probabilities.normal * self.probability_change

    self.probability_change = 1
end

blind.defeat = function (self)
    if not G.GAME.blind.disabled then
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * self.probability_change
    end
end



return blind