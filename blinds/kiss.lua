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

blind.eman_modify_chips = function (self, hand_chips, mult)
    local total = math.min(math.floor(hand_chips*mult), math.floor(G.GAME.blind.chips * .5))

    return total
end

blind.loc_vars = function (self)

    return { vars = {""..(get_blind_amount(G.GAME.round_resets.ante) * self.mult * G.GAME.starting_params.ante_scaling * .5)}}
end

blind.collection_loc_vars = function (self)

    self.vars = {"{0.75X Base}"}
    return self.vars
end

return blind