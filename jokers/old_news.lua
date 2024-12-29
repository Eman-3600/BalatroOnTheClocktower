local joker = {
    name = "Old News",
    key = "old_news",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 2},
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    config = {extra = {chips = 0, chip_mod = 20}},
    loc_txt = {
        name ="Old News",
        text={
            "This Joker gains {C:chips}+#2#{} Chips",
            "when scored hand contains a",
            "{C:attention}Stone Card{} and a {C:attention}Pair{}",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.chips,
        card.ability.extra.chip_mod,
    }}
end

joker.in_pool = function (self)
    
    for _, v in ipairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_stone then return true end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.before then

        if next(context.poker_hands['Pair']) then
            for _, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_stone and not v.debuff then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS,
                        card = card
                    }
                end
            end
        end
    elseif context.joker_main then
        if card.ability.extra.chips > 0 then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end
end



return joker