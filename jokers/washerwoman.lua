local joker = {
    name = "Washerwoman",
    key = "washerwoman",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 4, y = 0},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {},
    loc_txt = {
        name ="Washerwoman",
        text={
            "The first base edition Joker",
            "in each shop gains the",
            "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
            "or {C:dark_edition}Polychrome{} edition",
        },
    },
}

joker.set_ability = function (self, card, initial, delay_sprites)
    card.ability.has_wash = true
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.eman_store_item and card.ability.has_wash then
        
        if not context.eman_store_item.edition and not context.eman_store_item.temp_edition and context.eman_store_item.ability.set == 'Joker' then
            card.ability.has_wash = false

            local edition = poll_edition('washerwoman', nil, true, true)
            local store_card = context.eman_store_item

            store_card.temp_edition = true

            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function ()
        
                    store_card:set_edition(edition)
                    store_card:set_cost()
                    store_card.temp_edition = nil

                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Washed!'});
        
                    return true
                end
            }))
        end
    elseif not context.blueprint and context.ending_shop then
        card.ability.has_wash = true
    end
end



return joker