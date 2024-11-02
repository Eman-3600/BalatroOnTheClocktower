local blind = {
    name = "The Fear",
    key = "fear",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 14},
    boss = {min = 3, max = 10},
    boss_colour = HEX('000000'),
    loc_txt = {
        name ="The Fear",
        text={
            "Playing or discarding a High",
            "Card makes a Joker perishable",
        },
    },
}

blind.eman_fear_hand = function (self, hand)
    local poker_hands = evaluate_poker_hand(hand)

    for k, v in pairs(poker_hands) do

        if k ~= "High Card" and next(v) then
            return true
        end
    end

    local valid_jokers = {}

    for _, joker in ipairs(G.jokers.cards) do
        
        if joker.config.center.perishable_compat and not joker.ability.eternal and not joker.ability.perishable then
            table.insert(valid_jokers, joker)
        end
    end

    if #valid_jokers > 0 then
        G.E_MANAGER:add_event(Event({ func = function()
            
            local joker = pseudorandom_element(valid_jokers, pseudoseed('fear'))

            joker:set_perishable(true)
            joker:juice_up(0.3, 0.3)
            G.GAME.blind:wiggle()
        return true end }))
    end

    return true
end

blind.eman_after_discard = function (self, forced, discarded, kept)
    return self:eman_fear_hand(discarded)
end

blind.eman_before_play = function (self, played_hand)
    return self:eman_fear_hand(played_hand)
end

return blind