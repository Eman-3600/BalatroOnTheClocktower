local joker = {
    name = "Noble",
    key = "noble",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 7,
    pos = {x = 2, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {savings = 2}},
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.savings,
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.GAME.inflation = G.GAME.inflation - card.ability.extra.savings

    G.E_MANAGER:add_event(Event({func = function()
        for k, v in pairs(G.I.CARD) do
            if v.set_cost then v:set_cost() end
        end
        return true end }))
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.GAME.inflation = G.GAME.inflation + card.ability.extra.savings

    G.E_MANAGER:add_event(Event({func = function()
        for k, v in pairs(G.I.CARD) do
            if v.set_cost then v:set_cost() end
        end
        return true end }))
end



return joker