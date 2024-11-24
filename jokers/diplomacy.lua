local joker = {
    name = "Diplomacy",
    key = "diplomacy",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 6, y = 2},
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    config = {},
    loc_txt = {
        name ="Diplomacy",
        text={
            "{C:money}Rental {C:legendary,E:1}Legendary{} Jokers",
            "can appear in the shop.",
            "When one is bought,",
            "destroy this Joker."
        },
    },
}

joker.calculate = function (self, card, context)
    if not context.blueprint and context.eman_store_item then
        
        if not context.eman_store_item.edition and context.eman_store_item.ability.set == 'Joker' and context.eman_store_item.config.center.rarity == 4 then
            local store_card = context.eman_store_item

            store_card:set_rental(true)
            store_card:set_cost()
        end
    elseif not context.blueprint and context.eman_modify_pool_rarity then
        
        if not context.eman_modify_pool_rarity.rarity and pseudorandom(pseudoseed('diplomacy'..(context.eman_modify_pool_rarity._append or ''))) > 0.98 then
            return {rarity = 4}
        end
    elseif not context.blueprint and context.buying_card then
        local bought_card = context.card

        if bought_card.ability.set == 'Joker' and bought_card.config.center.rarity == 4 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    card_eval_status_text(card, 'extra', nil, nil, nil, 
                    {
                        message = 'Deal!',
                        colour = G.C.PURPLE
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
        end
    end
end



return joker