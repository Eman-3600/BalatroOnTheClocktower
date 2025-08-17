local joker = {
    name = "Snake Charmer",
    key = "snake_charmer",
    atlas = "atlasclockjokers",
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {draw_count = 3}},
    loc_txt = {
        name ="Snake Charmer",
        text={
            "When round begins, {C:attention}lose",
            "{C:attention}all discards{} and draw",
            "{C:attention}#1#{} cards to {C:attention}hand",
            "per {C:attention}discard{} lost",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.draw_count,
    }}
end

joker.calculate = function (self, card, context)

    if context.first_hand_drawn and not context.blueprint_card then

        G.E_MANAGER:add_event(Event({
            func = function()

                local discards = G.GAME.current_round.discards_left
                ease_discard(-discards, nil, true)

                local hand_space = math.min(discards * card.ability.extra.draw_count, #G.deck.cards)

                card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Draw '..hand_space..'!'})

                for i = 1, hand_space do
                    draw_card(G.deck,G.hand, i*100/hand_space,'up', true)
                end
                
                return true
            end}))
    end
end



return joker