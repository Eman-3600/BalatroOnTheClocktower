local joker = {
    name = "Artist",
    key = "artist",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 3, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {h_size = 2, active = false}},
    loc_txt = {
        name ="Artist",
        text={
            "{C:attention}+#1#{} hand size if",
            "last hand caught fire",
            "{X:attention,C:white} #2# {}"
        },
    },
}

joker.add_to_deck = function (self, card, from_debuff)
    card.ability.extra.active = G.GAME.last_hand_fire

    if G.GAME.last_hand_fire then
        G.hand:change_size(card.ability.extra.h_size)
    end
end

joker.remove_from_deck = function (self, card, from_debuff)
    if card.ability.extra.active then
        G.hand:change_size(-card.ability.extra.h_size)
    end
end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.h_size,
        G.GAME.last_hand_fire and "Active" or "Inactive",
    }}
end

joker.update = function (self, card, dt)

    local now_active = G.GAME.last_hand_fire

    if now_active and not card.ability.extra.active and not card.debuff then
        card.ability.extra.active = true

        if card.area == G.jokers then
            G.hand:change_size(card.ability.extra.h_size)

            G.E_MANAGER:add_event(Event({ func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
    
                return true
            end}))
        end
    elseif card.ability.extra.active and not now_active and not card.debuff then
        card.ability.extra.active = false

        if card.area == G.jokers then
            G.hand:change_size(-card.ability.extra.h_size)

            G.E_MANAGER:add_event(Event({ func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
    
                return true
            end}))
        end
    end
end



return joker