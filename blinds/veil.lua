local blind = {
    name = "The Veil",
    key = "veil",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 18},
    boss = {min = 2, max = 10},
    boss_colour = HEX('433e4d'),
    loc_txt = {
        name ="The Veil",
        text={
            "All cards drawn face down;",
            "flip after Play or Discard",
        },
    },
}

blind.stay_flipped = function (self, area, card)

    return area == G.hand
end

blind.eman_after_discard = function (self, forced, discarded, kept)
    return self:eman_unveil(kept)
end

blind.eman_before_play = function (self, played_hand)
    return self:eman_unveil(G.hand.cards)
end

blind.eman_unveil = function (self, cards)
    
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function ()

            for _, card in ipairs(cards) do
                if card.ability.wheel_flipped then
                    card.ability.wheel_flipped = false
                    card:flip()
                end
            end

            return true
        end
    }))
end




return blind