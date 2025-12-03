local joker = {
    name = "Charity",
    key = "charity",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 3, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {}},
}

-- joker.set_ability = function (self, card, initial, delay_sprites)
--     card.ability.extra.active = false
-- end

-- joker.add_to_deck = function (self, card, from_debuff)
    
--     G.E_MANAGER:add_event(Event({func = function()
--         for k, v in pairs(G.I.CARD) do
--             if v.set_cost then v:set_cost() end
--         end
--         return true end }))
-- end

-- joker.calculate = function (self, card, context)
--     if not context.blueprint and context.eman_store_item and card.ability.extra.active then
--         context.eman_store_item.cost = 0
    
--     elseif not context.blueprint and context.buying_card then
--         card.ability.extra.active = false
--         G.E_MANAGER:add_event(Event({func = function()
--             for k, v in pairs(G.I.CARD) do
--                 if v.set_cost then v:set_cost() end
--             end
--             return true end }))
--     elseif not context.blueprint and context.end_of_round then
--         card.ability.extra.active = true
--     end
-- end

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = {key = 'tag_coupon', set = 'Tag'}

    return {}
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.end_of_round and context.cardarea == G.jokers then
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_coupon'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
end



return joker