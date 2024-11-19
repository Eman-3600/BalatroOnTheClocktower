local joker = {
    name = "Raven",
    key = "raven",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 0},
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_txt = {
        name ="Raven",
        text={
            "Sell this card to",
            "add {C:dark_edition}Polychrome{} to",
            "a random Joker",
        },
    },
}

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
                target_card:set_edition({polychrome = true})
    
                return true
            end}))
        end
    end
end



return joker