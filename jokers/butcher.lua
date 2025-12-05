local joker = {
    name = "Butcher",
    key = "butcher",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 1, y = 5},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 1.5, fee = 1}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        card.ability.extra.x_mult,
        card.ability.extra.fee,
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play and not context.end_of_round then

        local id = context.other_card:get_id()

        if id > 0 then
            for i=1, #context.scoring_hand do
                if (context.scoring_hand[i]:get_id() == id) then
                    if context.scoring_hand[i] == context.other_card then
                        return {
                            xmult = card.ability.extra.x_mult
                        }
                    else
                        break
                    end
                end
            end
        end
        
    end

    if not context.blueprint and context.pre_discard and context.cardarea == G.jokers then
        ease_dollars(-card.ability.extra.fee)
        card_eval_status_text(card, 'dollars', -card.ability.extra.fee)
    end

    BAOTC.calculate_traveler(card, context)
end



return joker