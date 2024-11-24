local joker = {
    name = "Quicksilver",
    key = "quicksilver",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 4, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 2}},
    loc_txt = {
        name ="Quicksilver",
        text={
            "Each unique {C:attention}enhancement",
            "played scores {X:mult,C:white} X#1# {} Mult",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.x_mult,
    }}
end

joker.in_pool = function (self)

    for k, v in pairs(G.playing_cards) do
        if v.config.center ~= G.P_CENTERS.c_base then return true end
    end

    return false
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play then

        local center = context.other_card.config.center
        local first_centers = {}

        for _, _card in ipairs(G.play.cards) do
            if _card.config.center ~= G.P_CENTERS.c_base and not first_centers[_card.config.center] then
                first_centers[_card.config.center] = _card
            end
        end

        if first_centers[center] == context.other_card then
            return {
                card = context.blueprint_card or card,
                x_mult = card.ability.extra.x_mult
            }
        end
    end
end



return joker