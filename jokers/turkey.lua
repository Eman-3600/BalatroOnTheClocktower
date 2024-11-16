local joker = {
    name = "Turkey",
    key = "turkey",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 2, y = 0},
    config = {slots = 4, slot_mod = 1},
    loc_txt = {
        name ="Turkey",
        text={
            "{C:attention}+#1#{} consumable slots",
            "{C:red}-#2#{} consumable slot",
            "per consumable used"
        },
    },
}

joker.set_ability = function (self, card, initial, delay_sprites)
    card.ability.extra = {
        slots = self.config.slots,
        slot_mod = self.config.slot_mod,
    }
end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        (card.ability.extra and card.ability.extra.slots or self.config.slots),
        (card.ability.extra and card.ability.extra.slot_mod or self.config.slot_mod),
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.consumeable then

        if card.ability.extra.slots - card.ability.extra.slot_mod <= 0 then 
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    card_eval_status_text(card, 'extra', nil, nil, nil, 
                    {
                        message = localize('k_eaten_ex'),
                        colour = G.C.RED
                    }
                    );
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end}))
                    return true
                end
            }))
        else
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slot_mod
            card.ability.extra.slots = card.ability.extra.slots - card.ability.extra.slot_mod
            G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={card.ability.extra.slots}}}); return true
                end}))
        end
    end
end



return joker