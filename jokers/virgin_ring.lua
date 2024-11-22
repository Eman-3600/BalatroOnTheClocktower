local joker = {
    name = "Engagement Ring",
    key = "virgin_ring",
    atlas = "atlasclockjokers",
    rarity = 3,
    cost = 8,
    pos = {x = 8, y = 0},
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    config = {extra = {chips = 0, chips_mod = 8}},
    loc_txt = {
        name ="Engagement Ring",
        text={
            "This Joker gains {C:chips}+#2#{} Chips",
            "each time an {C:attention}enhanced{}",
            "card is discarded",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.chips,
        card.ability.extra.chips_mod,
    }}
end

joker.in_pool = function (self)
    
    for k, v in pairs(G.playing_cards) do
        if v.config.center ~= G.P_CENTERS.c_base then return true end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if context.discard and not context.blueprint then

        if context.other_card.config.center ~= G.P_CENTERS.c_base and
        not context.other_card.debuff then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod

            return {
                message = localize('k_upgrade_ex'),
                card = card,
                colour = G.C.CHIPS
            }
        end
    elseif context.joker_main then
        return {
            message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
            chip_mod = card.ability.extra.chips,
            colour = G.C.CHIPS
        }
    end
end



return joker