local joker = {
    name = "Thief",
    key = "thief",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 6, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {dollars = 1, discards = -1}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        card.ability.extra.dollars,
        card.ability.extra.discards,
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
    ease_discard(card.ability.extra.discards)
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
    ease_discard(-card.ability.extra.discards)
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play and not context.end_of_round then

        return {
            dollars = card.ability.extra.dollars
        }
    end

    BAOTC.calculate_traveler(card, context)
end



return joker