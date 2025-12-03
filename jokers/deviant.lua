local joker = {
    name = "Deviant",
    key = "deviant",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 4, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 4}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        card.ability.extra.x_mult,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main then

        return {
            xmult = card.ability.extra.x_mult
        }
    end

    BAOTC.calculate_traveler(card, context)
end



return joker