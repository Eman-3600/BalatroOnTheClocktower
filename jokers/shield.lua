local joker = {
    name = "Steel Shield",
    key = "shield",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 4,
    pos = {x = 5, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = 12},
    loc_txt = {
        name ="Steel Shield",
        text={
            "Played {C:attention}Steel Cards{}",
            "score {C:red}+#1#{} Mult",
        },
    },
}

joker.in_pool = function (self)
    
    for _, v in ipairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_steel then return true end
    end
    
    return false
end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play then

        if context.other_card.config.center == G.P_CENTERS.m_steel then
            
            return {
                card = card,
                mult = card.ability.extra
            }
        end
    end
end



return joker