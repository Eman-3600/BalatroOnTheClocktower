local joker = {
    name = "Gambler",
    key = "gambler",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 3},
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    config = {extra = {x_mult = 1, x_mult_mod = 0.5}},
    loc_txt = {
        name ="Gambler",
        text={
            "This Joker gains {X:mult,C:white} X#2# {} Mult",
            "per {C:attention}Glass Card{} scored,",
            "resets when a {C:attention}Glass Card{} breaks",
            "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.x_mult,
        card.ability.extra.x_mult_mod,
    }}
end

joker.in_pool = function (self)
    
    for _, v in ipairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_glass then return true end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if context.cards_destroyed and not context.blueprint then
        for _, v in ipairs(context.glass_shattered) do
            if v.shattered then
                card.ability.extra.x_mult = 1

                G.E_MANAGER:add_event(Event({ func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
        
                    return true
                end}))
            end
        end
    elseif context.remove_playing_cards and not context.blueprint then
        for _, v in ipairs(context.removed) do
            if v.shattered then
                card.ability.extra.x_mult = 1

                G.E_MANAGER:add_event(Event({ func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
        
                    return true
                end}))
            end
        end
    end
    
    if context.individual and not context.blueprint and context.cardarea == G.play then

        if context.other_card.config.center == G.P_CENTERS.m_glass then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                        
            return {
                extra = {focus = card, message = localize('k_upgrade_ex')},
                card = card,
                colour = G.C.MULT
            }
        end
    elseif context.joker_main then

        if card.ability.extra.x_mult > 1 then
        
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                Xmult_mod = card.ability.extra.x_mult
            }

        end
    end
end



return joker