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
            "Scoring over #1# chips",
            "makes your Jokers eternal",
        },
    },
}

blind.defeat = function (self)

    if (not self.disabled) and (G.GAME.chips >= G.GAME.blind.chips * 2) then
        for _, joker in ipairs(G.jokers.cards) do
            joker:set_eternal(true)
            if (joker.ability.eternal) then
                joker:juice_up(0.3, 0.3)
            end
        end
    end
end

blind.loc_vars = function (self)

    return { vars = {""..(get_blind_amount(G.GAME.round_resets.ante) * self.mult * G.GAME.starting_params.ante_scaling * 2)}}
end

blind.collection_loc_vars = function (self)

    self.vars = {"{4X Base}"}
    return self.vars
end



return blind