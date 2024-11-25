local joker = {
    name = "Servitude",
    key = "servitude",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 5, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 1.25}},
    loc_txt = {
        name ="Servitude",
        text={
            "All Jokers",
            "give {X:mult,C:white} X#1# {} Mult",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.x_mult,
    }}
end

joker.calculate = function (self, card, context)
    if context.other_joker and context.other_joker.ability.set == 'Joker' then

        if context.other_joker ~= card then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_joker:juice_up(0.5, 0.5)
                    return true
                end
            }))
        end
        return {
            message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
            Xmult_mod = card.ability.extra.x_mult
        }
    end
end



return joker