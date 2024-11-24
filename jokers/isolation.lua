local joker = {
    name = "Isolation",
    key = "isolation",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 10,
    pos = {x = 3, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_txt = {
        name ="Isolation",
        text={
            "If {C:attention}poker hand{} is a",
            "{C:attention}secret hand{}, create a",
            "random {C:spectral}Spectral{} card",
            "{C:inactive}(Must have room)"
        },
    },
}

joker.in_pool = function (self)
    
    for k, v in pairs(G.GAME.hands) do
        if v.eman_secret and v.visible then return true end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then

        local poker_hand = G.GAME.hands[context.scoring_name]

        if poker_hand.eman_secret then
            
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
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
    end
end



return joker