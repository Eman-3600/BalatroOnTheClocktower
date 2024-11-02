local blind = {
    name = "The Tonic",
    key = "tonic",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 6},
    boss = {min = 3, max = 10},
    boss_colour = HEX('565d6a'),
    loc_txt = {
        name ="The Tonic",
        text={
            "Negative Jokers",
            "are debuffed",
        },
    },
}

blind.in_pool = function (self)

    if G.jokers and (self.boss.min <= math.max(1, G.GAME.round_resets.ante)) then
    
        for _, card in ipairs(G.jokers.cards) do
            if card.edition and card.edition.negative then
                return true
            end
        end
    end

    return false
end

blind.set_blind = function (self)
    self.prepped = true
end

blind.drawn_to_hand = function (self)
    if not self.disabled and self.prepped then
        self.prepped = false
        local successful

        for _, card in ipairs(G.jokers.cards) do
            
            if card.edition and card.edition.negative and not card.ability.debuff then
                successful = true

                card:set_debuff(true)
                card:juice_up()
            elseif card.ability.debuff then
                successful = true

                card:set_debuff(false)
                card:juice_up()
            end

            if successful then
                G.GAME.blind:wiggle()
            end
        end
    end
end

blind.press_play = function (self)
    self.prepped = true
end

blind.defeat = function (self)
    for _, card in ipairs(G.jokers.cards) do
            
        card:set_debuff(false)
    end
end



return blind