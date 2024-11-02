local blind = {
    name = "The Tool",
    key = "tool",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 10},
    boss = {min = 2, max = 10},
    boss_colour = HEX('8c6c57'),
    loc_txt = {
        name ="The Tool",
        text={
            "Creates a card after",
            "play or discard",
        },
    },
}

blind.set_blind = function (self)
    self.prepped = false
end

blind.eman_modify_draw = function (self, hand_space)

    if not self.prepped then
        self.prepped = true
        return hand_space
    end
    
    G.E_MANAGER:add_event(Event({
        func = function() 
            local _card = create_playing_card({
                front = pseudorandom_element(G.P_CARDS, pseudoseed('tool')), 
                center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
            G.GAME.blind:wiggle()
            G.hand:sort()
            return true
        end}))
    
    playing_card_joker_effects({true})
    return hand_space - 1
end

return blind