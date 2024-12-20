local blind = {
    name = "The Omen",
    key = "omen",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 21},
    boss = {min = 3, max = 10},
    boss_colour = HEX('472d56'),
    loc_txt = {
        name ="The Omen",
        text={
            "After 1 hand, becomes",
            "a finisher blind",
        },
    },
}

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.prepped = false
end

blind.press_play = function (self)
    G.GAME.blind.eman_extra.prepped = true
end

blind.eman_modify_draw = function (self, hand_space)
    
    if G.GAME.blind.eman_extra.prepped then
        local showdown = self.eman_get_showdown()
        G.GAME.blind:set_blind(showdown)

        ease_background_colour{new_colour = G.C.BLUE, special_colour = G.C.RED, tertiary_colour = darken(G.C.BLACK, 0.4), contrast = 3}

        delay(0.5)
    end
    
    return hand_space
end



blind.eman_get_showdown = function ()

    local eligible_bosses = {}
    for k, v in pairs(G.P_BLINDS) do
        if not v.boss then
            
        elseif v.boss.showdown then
            eligible_bosses[k] = true
        end
    end
    for k, v in pairs(G.GAME.banned_keys) do
        if eligible_bosses[k] then eligible_bosses[k] = nil end
    end

    local min_use = 100
    for k, v in pairs(G.GAME.bosses_used) do
        if eligible_bosses[k] then
            eligible_bosses[k] = v
            if eligible_bosses[k] <= min_use then 
                min_use = eligible_bosses[k]
            end
        end
    end
    for k, v in pairs(eligible_bosses) do
        if eligible_bosses[k] then
            if eligible_bosses[k] > min_use then 
                eligible_bosses[k] = nil
            end
        end
    end
    local k, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))
    G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] + 1
    
    return G.P_BLINDS[boss]
end




return blind