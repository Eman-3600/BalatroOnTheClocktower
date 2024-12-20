local blind = {
    name = "Scarlet Thorn",
    key = "scarlet_thorn",
    mult = 2,
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 26},
    boss = {min = 1, max = 10, showdown = true},
    dollars = 8,
    boss_colour = HEX('b93a28'),
    loc_txt = {
        name ="Scarlet Thorn",
        text={
            "Hands cannot score",
            "over #1# chips",
        },
    },
}

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.hands_sub = 0

    if G.GAME.round_resets.hands < 3 then
        G.GAME.blind.eman_extra.hands_sub = G.GAME.round_resets.hands - 3
        ease_hands_played(-G.GAME.blind.eman_extra.hands_sub)
    end
end

blind.eman_modify_chips = function (self, hand_chips, mult)
    local total = math.min(math.floor(hand_chips*mult), math.floor(G.GAME.blind.chips * .35))

    return total
end

blind.loc_vars = function (self)

    return { vars = {number_format(get_blind_amount(G.GAME.round_resets.ante) * self.mult * G.GAME.starting_params.ante_scaling * .35)}}
end

blind.collection_loc_vars = function (self)

    self.vars = {"35% of"}
    return self.vars
end

return blind