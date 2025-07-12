local blind = {
    name = "The Kiss",
    key = "kiss",
    mult = 1.5,
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 9},
    boss = {min = 2, max = 10},
    boss_colour = HEX('ce3b4c'),
    loc_txt = {
        name ="The Kiss",
        text={
            "Hands cannot score",
            "over #1# chips",
        },
    },
}

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.hands_sub = 0

    if G.GAME.round_resets.hands < 2 then
        G.GAME.blind.eman_extra.hands_sub = G.GAME.round_resets.hands - 2
        ease_hands_played(-G.GAME.blind.eman_extra.hands_sub)
    end
end

blind.disable = function (self)
    G.GAME.blind.chips = G.GAME.blind.chips * 2 / self.mult
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end

blind.eman_modify_chips = function (self, hand_chips, mult)
    local total = math.min(math.floor(hand_chips*mult), math.floor(G.GAME.blind.chips * .5))

    return total
end

blind.loc_vars = function (self)

    return { vars = {number_format(get_blind_amount(G.GAME.round_resets.ante) * self.mult * G.GAME.starting_params.ante_scaling * .5)}}
end

blind.collection_loc_vars = function (self)

    return { vars = {"50% of"}}
end

return blind