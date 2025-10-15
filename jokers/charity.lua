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
    loc_txt = {
        name ="Charity",
        text={
            "The first card in",
            "each shop is {C:money}free{}",
        },
    },
}

joker.set_ability = function (self, card, initial, delay_sprites)
    card.ability.extra.active = false
end

joker.add_to_deck = function (self, card, from_debuff)
    
    G.E_MANAGER:add_event(Event({func = function()
        for k, v in pairs(G.I.CARD) do
            if v.set_cost then v:set_cost() end
        end
        return true end }))
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.eman_store_item and card.ability.extra.active then
        context.eman_store_item.cost = 0
    
    elseif not context.blueprint and context.buying_card then
        card.ability.extra.active = false
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
            return true end }))
    elseif not context.blueprint and context.end_of_round then
        card.ability.extra.active = true
    end
end



return joker