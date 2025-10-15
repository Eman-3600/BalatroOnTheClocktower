local joker = {
    name = "Enlightenment",
    key = "enlightenment",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 11,
    pos = {x = 8, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_txt = {
        name ="Enlightenment",
        text={
            "Upgrade level of all {C:attention}poker hands",
            "if {C:attention}poker hand{} is a {C:attention}#1#{},",
            "then change poker hand",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        localize(card.ability.to_do_poker_hand, 'poker_hands')
    }}
end

joker.set_ability = function (self, card, initial, delay_sprites)
    local poker_hands = {}
    for k, v in ipairs(G.GAME.hands) do
        if v.visible then poker_hands[#poker_hands+1] = k end
    end

    local old_hand = card.ability.to_do_poker_hand
    card.ability.to_do_poker_hand = nil

    if #poker_hands < 2 then
        card.ability.to_do_poker_hand = "High Card"
        return
    end

    while not card.ability.to_do_poker_hand do
        card.ability.to_do_poker_hand = pseudorandom_element(poker_hands, pseudoseed((card.area and card.area.config.type == 'title') and 'false_to_do' or 'enlightenment'))
        if card.ability.to_do_poker_hand == old_hand then card.ability.to_do_poker_hand = nil end
    end
end

joker.calculate = function (self, card, context)
    if context.after and not context.blueprint and not context.individual and not context.repetition then
        if context.scoring_name == card.ability.to_do_poker_hand then
            local poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.to_do_poker_hand then poker_hands[#poker_hands+1] = k end
            end
            card.ability.to_do_poker_hand = pseudorandom_element(poker_hands, pseudoseed('enlightenment'))
            return {
                message = localize('k_reset')
            }
        end
    elseif context.before and context.cardarea == G.jokers then
        if context.scoring_name == card.ability.to_do_poker_hand then
            local _card = context.blueprint_card or card
            card_eval_status_text(_card, 'jokers', nil, 0, nil, {card = card, message = localize('k_level_up_ex')})
            
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('tarot1')
                _card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
            update_hand_text({delay = 0}, {mult = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                _card:juice_up(0.8, 0.5)
                return true end }))
            update_hand_text({delay = 0}, {chips = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                _card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true end }))
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
            delay(1.3)
            for k, v in pairs(G.GAME.hands) do
                level_up_hand(_card, k, true)
            end
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[context.scoring_name].level, chips = G.GAME.hands[context.scoring_name].chips, mult = G.GAME.hands[context.scoring_name].mult, handname = localize(context.scoring_name, 'poker_hands')})
        end
    end
end



return joker