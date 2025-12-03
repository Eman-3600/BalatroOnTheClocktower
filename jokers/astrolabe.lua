local joker = {
    name = "Astrolabe",
    key = "astrolabe",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 10,
    pos = {x = 2, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
}

joker.in_pool = function (self)

    return not G.GAME.eman_force_eternal_forgotten
end

joker.calculate = function (self, card, context)
    if context.selling_self then

        local eligible_editionless_jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) and v ~= card then
                table.insert(eligible_editionless_jokers, v)
            end
        end

        if #eligible_editionless_jokers > 0 then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()

                local target_card = pseudorandom_element(eligible_editionless_jokers, pseudoseed('raven'))
                target_card:set_edition({negative = true})
                target_card:set_eternal(true)
    
                return true
            end}))
        end
    end
end



return joker