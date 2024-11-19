local joker = {
    name = "Elvis",
    key = "elvis",
    atlas = "atlasclockjokers",
    rarity = 4,
    cost = 20,
    pos = {x = 9, y = 0},
    soul_pos = {x = 9, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 1, x_mult_mod = 0.5, active = false}},
    loc_txt = {
        name ="Elvis",
        text={
            "This Joker has {X:mult,C:white} X#2# {} Mult",
            "per {C:attention}playing card{} in your",
            "{C:attention}full deck{} if {C:attention}face cards{}",
            "outnumber other cards",
            "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
        },
    },
}

joker.set_ability = function (self, card, initial, delay_sprites)
    card.ability.extra.active = self:elvis_balanced(card)
end

joker.elvis_balanced = function (self, card)

    if not G.playing_cards then return false end
    
    local face_cards = 0
    local other_cards = 0

    for _, v in ipairs(G.playing_cards) do
        if v:is_face() then
            face_cards = face_cards + 1
        else
            other_cards = other_cards + 1
        end
    end

    return face_cards > other_cards
end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.x_mult,
        card.ability.extra.x_mult_mod,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main and card.ability.extra.x_mult > 1 then
        return {
            message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
            Xmult_mod = card.ability.extra.x_mult
        }
    end
end

joker.update = function (self, card, dt)
    local now_active = self:elvis_balanced(card)

    if now_active and not card.ability.extra.active then
        card.ability.extra.active = true

        G.E_MANAGER:add_event(Event({ func = function()
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})

            return true
        end}))
    elseif card.ability.extra.active and not now_active then
        card.ability.extra.active = false

        G.E_MANAGER:add_event(Event({ func = function()
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})

            return true
        end}))
    end

    if now_active then
        card.ability.extra.x_mult = 1 + (#G.playing_cards * card.ability.extra.x_mult_mod)
    else
        card.ability.extra.x_mult = 1
    end
end



return joker