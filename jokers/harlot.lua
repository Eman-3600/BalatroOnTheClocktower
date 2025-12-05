local joker = {
    name = "Harlot",
    key = "harlot",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 3, y = 5},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 1.5, suits = {'Hearts', 'Diamonds'}, fee = 2}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        localize(card.ability.extra.suits[1], 'suits_singular'),
        localize(card.ability.extra.suits[2], 'suits_singular'),
        card.ability.extra.x_mult,
        card.ability.extra.fee,
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play and not context.end_of_round then

        for _, v in ipairs(card.ability.extra.suits) do
            if (context.other_card:is_suit(v)) then
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
        
    end

    if not context.blueprint and context.end_of_round and context.cardarea == G.jokers then
        ease_dollars(-card.ability.extra.fee)
        card_eval_status_text(card, 'dollars', -card.ability.extra.fee)
    end

    BAOTC.calculate_traveler(card, context)
end



return joker