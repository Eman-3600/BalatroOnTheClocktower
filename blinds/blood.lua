local blind = {
    name = "The Blood",
    key = "blood",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 3},
    boss = {min = 3, max = 10},
    boss_colour = HEX('b13b3d'),
    loc_txt = {
        name ="The Blood",
        text={
            "Destroys a card after",
            "Play or Discard",
        },
    },
}

blind.set_blind = function (self)
    self.prepped = false
end

blind.eman_modify_draw = function (self, hand_space)
    if not self.prepped or #G.hand.cards == 0 then
        self.prepped = true
        return hand_space
    end

    G.E_MANAGER:add_event(Event({
        func = function() 
            local card = pseudorandom_element(G.hand.cards, pseudoseed('blood')) 

            if card.ability.name == 'Glass Card' then 
                card:shatter()
            else
                card:start_dissolve()
            end

            G.GAME.blind:wiggle()
            G.hand:sort()
            return true
        end}))

    return hand_space + 1
end



return blind