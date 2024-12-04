local joker = {
    name = "Isolation",
    key = "isolation",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 3, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {h_size = 1, h_size_total = 0}},
    loc_txt = {
        name ="Isolation",
        text={
            "If played hand has only",
            "{C:attention}1{} card, create a random",
            "{C:spectral}Spectral{} card and incur",
            "{C:red}-#1#{} hand size this round"
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.h_size,
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size_total)
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size_total)
end

joker.calculate = function (self, card, context)
    if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then

        if #context.full_hand == 1 then
            
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()

                    G.hand:change_size(-card.ability.extra.h_size)
                    card.ability.extra.h_size_total = card.ability.extra.h_size_total - card.ability.extra.h_size

                    local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'isolation')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)}))
            return {
                message = localize('k_plus_spectral'),
                colour = G.C.SECONDARY_SET.Spectral,
                card = self
            }
        end
    elseif context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
        G.hand:change_size(-card.ability.extra.h_size_total)
        card.ability.extra.h_size_total = 0
    end
end



return joker