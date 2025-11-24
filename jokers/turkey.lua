local joker = {
    name = "Turkey",
    key = "turkey",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 4,
    pos = {x = 2, y = 0},
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {slots = 2}},
    loc_txt = {
        name ="Turkey",
        text={
            "{C:attention}+#1#{} consumable slots",
            "Destroyed if a",
            "consumable is {C:attention}sold{}"
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        (card.ability.extra and card.ability.extra.slots or self.config.slots),
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.selling_card and context.card.area == G.consumeables then

        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                        return true; end}))
                return true
            end
        }))
        return {
            message = localize('k_eaten_ex'),
            colour = G.C.RED
        }
    end
end



return joker