local joker = {
    name = "Bureaucrat",
    key = "bureaucrat",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 5, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {hands = 3, inflation = 1}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        card.ability.extra.hands,
        card.ability.extra.inflation,
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.GAME.inflation = G.GAME.inflation + card.ability.extra.inflation

    G.E_MANAGER:add_event(Event({func = function()
        for k, v in pairs(G.I.CARD) do
            if v.set_cost then v:set_cost() end
        end
        return true end }))
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.GAME.inflation = G.GAME.inflation - card.ability.extra.inflation

    G.E_MANAGER:add_event(Event({func = function()
        for k, v in pairs(G.I.CARD) do
            if v.set_cost then v:set_cost() end
        end
        return true end }))
end

joker.calculate = function (self, card, context)
    if context.setting_blind and not card.getting_sliced then

        G.E_MANAGER:add_event(Event({func = function()
            ease_hands_played(card.ability.extra.hands)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.hands}}})
        return true end }))
    end

    BAOTC.calculate_traveler(card, context)
end



return joker