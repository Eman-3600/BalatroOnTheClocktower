local joker = {
    name = "Barista",
    key = "barista",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 4, y = 5},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {repetitions = 1, fee = 1}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        card.ability.extra.fee,
    }}
end

joker.calculate = function (self, card, context)

    if context.before and not context.blueprint then
        ease_dollars(-card.ability.extra.fee)
        card_eval_status_text(card, 'dollars', -card.ability.extra.fee)
    end

    if context.repetition and context.cardarea == G.play then

        return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.repetitions,
        }
    end

    BAOTC.calculate_traveler(card, context)
end



return joker