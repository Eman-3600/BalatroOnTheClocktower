local joker = {
    name = "Wildflower",
    key = "wildflower",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 8, y = 1},
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    config = {extra = {mult = 0, mult_mod = 4}},
    loc_txt = {
        name ="Wildflower",
        text={
            "This Joker gains {C:red}+#2#{} Mult",
            "when scored hand contains a",
            "{C:attention}Wild Card{} and not a {C:attention}Flush{}",
            "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.mult,
        card.ability.extra.mult_mod,
    }}
end

joker.in_pool = function (self)
    
    for _, v in ipairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_wild then return true end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.before then

        if not next(context.poker_hands['Flush']) then
            for _, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_wild and not v.debuff then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    elseif context.joker_main then
        if card.ability.extra.mult > 0 then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end
    end
end



return joker