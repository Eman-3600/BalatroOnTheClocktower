local blind = {
    name = "The Tax",
    key = "tax",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 5},
    boss = {min = 3, max = 10},
    boss_colour = HEX('aaab2d'),
    loc_txt = {
        name ="The Tax",
        text={
            "The first #1# you",
            "draw is discarded",
        },
    },
    vars = {localize('ph_most_played')},
}

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.spent = nil
end

-- Called directly after drawing cards from the deck to hand if the boss is enabled
-- I probably didn't need to make a custom function & inject but it works and
-- hasn't caused infinite loops
blind.eman_after_draw = function (self, count)

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = function ()

            if G.GAME.blind.eman_extra.spent then return true end

            local most_played = G.GAME.current_round.most_played_poker_hand

            -- TEMPORARY SOLUTION: Likes to discard the wrong cards/too many cards
            local found_hands = evaluate_poker_hand(G.hand.cards)

            if next(found_hands[most_played]) then

                local thrown_hand = found_hands[most_played][1]
                
                G.E_MANAGER:add_event(Event({ func = function()
                    G.hand:unhighlight_all()
                    G.GAME.blind:wiggle()
                    local any_selected = nil
                    local _cards = {}
                    for k, v in ipairs(thrown_hand) do
                        _cards[#_cards+1] = v
                    end
                    for i = 1, #_cards do
                        if _cards[i] then 
                            local selected_card = _cards[i]
                            G.hand:add_to_highlighted(selected_card, true)
                            any_selected = true
                            play_sound('card1', 1)
                        end
                    end
                    delay(0.2)
                    if any_selected then G.FUNCS.discard_cards_from_highlighted() end
                return true end }))
                G.GAME.blind.eman_extra.spent = true
                delay(0.7)
            end

            return true
        end
    }))

end

blind.loc_vars = function (self)

    return { vars = {""..(G.GAME.current_round.most_played_poker_hand or "(most played hand)")}}
end

blind.collection_loc_vars = function (self)

    self.vars = {"(most played hand)"}
    return self.vars
end



return blind