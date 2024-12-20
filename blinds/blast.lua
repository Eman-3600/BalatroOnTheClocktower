local blind = {
    name = "The Blast",
    key = "blast",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 15},
    boss = {min = 4, max = 10},
    boss_colour = HEX('774339'),
    loc_txt = {
        name ="The Blast",
        text={
            "Draw only 1 hand",
            "+5 Hand Size",
        },
    },
}

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.prepped = true
    G.GAME.blind.eman_extra.hand_size_change = 5

    G.hand:change_size(5)
end

blind.disable = function (self)
    G.hand:change_size(-G.GAME.blind.eman_extra.hand_size_change)

    G.GAME.blind.eman_extra.hand_size_change = 0
end

blind.defeat = function (self)
    if not G.GAME.blind.disabled then
        G.hand:change_size(-G.GAME.blind.eman_extra.hand_size_change)
    end
end

blind.eman_modify_draw = function (self, hand_space)
    if G.GAME.blind.eman_extra.prepped then
        G.GAME.blind.eman_extra.prepped = false

        return hand_space
    end

    G.E_MANAGER:add_event(Event({ func = function()
            
        G.GAME.blind:wiggle()
    return true end }))

    if #G.hand.cards < 1 and #G.play.cards < 1 then
        end_round()
    end

    return 0
end



return blind