local joker = {
    name = "Gunslinger",
    key = "gunslinger",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 0, y = 5},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 3}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        card.ability.extra.x_mult,
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then

        return {
            xmult = card.ability.extra.x_mult
        }
    end

    if context.destroy_card and context.cardarea == G.play and not context.blueprint then
        if (context.destroy_card == context.scoring_hand[1]) then
            return {
                remove = true
            }
        end
    end

    BAOTC.calculate_traveler(card, context)
end



return joker