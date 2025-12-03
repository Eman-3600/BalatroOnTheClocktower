local joker = {
    name = "Ace of 4s",
    key = "ace_of_fours",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 0, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 1.25, rank = 11}},
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.x_mult,
    }}
end

joker.calculate = function (self, card, context)
    if context.before then
        local aces = 0
        local fours = 0

        for _, v in ipairs(context.full_hand) do
            if v:get_id() == 4 then
                fours = fours + 1
            elseif v:get_id() == 14 then
                aces = aces + 1
            end
        end

        card.ability.extra.rank = (aces >= fours) and 14 or 4
    end

    if context.individual and context.cardarea == G.play then

        if context.other_card:get_id() == card.ability.extra.rank then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
end



return joker