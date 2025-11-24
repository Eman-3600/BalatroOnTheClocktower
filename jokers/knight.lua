local joker = {
    name = "Knight",
    key = "knight",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 5, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = 10},
    loc_txt = {
        name ="Knight",
        text={
            "{C:red}+#1#{} Mult per",
            "held consumable",
        },
    },
}

-- joker.in_pool = function (self)
    
--     for _, v in ipairs(G.playing_cards) do
--         if v.config.center == G.P_CENTERS.m_steel then return true end
--     end
    
--     return false
-- end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra
    }}
end

joker.calculate = function (self, card, context)
    -- if context.individual and context.cardarea == G.play then

    --     if context.other_card.config.center == G.P_CENTERS.m_steel then
            
    --         return {
    --             card = card,
    --             mult = card.ability.extra
    --         }
    --     end
    -- end

    -- if context.other_consumeable then

    --     G.E_MANAGER:add_event(Event({
    --         func = function()
    --             context.other_consumeable:juice_up(0.5, 0.5)
    --             return true
    --         end
    --     }))
    --     return {
    --         message = localize{type='variable',key='a_mult',vars={card.ability.extra}},
    --         mult_mod = card.ability.extra
    --     }
    -- end

    if context.joker_main then

        local mult_total = #G.consumeables.cards * card.ability.extra

        return {
            mult = mult_total
        }
    end
end



return joker