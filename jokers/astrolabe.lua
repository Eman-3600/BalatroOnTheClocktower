local joker = {
    name = "Astrolabe",
    key = "astrolabe",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 2, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {has_star = true, h_size = -1}},
    loc_txt = {
        name ="Astrolabe",
        text={
            "The first base edition Joker",
            "in each shop becomes {C:dark_edition}Negative{}",
            "{C:attention}#1#{} hand size",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.h_size,
    }}
end

joker.add_to_deck = function (self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
end

joker.remove_from_deck = function (self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
end

joker.calculate = function (self, card, context)
    if not context.blueprint and context.eman_store_item and card.ability.extra.has_star then
        
        if not context.eman_store_item.edition and not context.eman_store_item.temp_edition and context.eman_store_item.ability.set == 'Joker' then
            card.ability.extra.has_star = false

            local edition = {negative = true}
            local store_card = context.eman_store_item

            store_card.temp_edition = true

            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function ()
        
                    store_card:set_edition(edition)
                    store_card:set_cost()
                    store_card.temp_edition = nil

                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Illuminated!'});
        
                    return true
                end
            }))
        end
    elseif not context.blueprint and context.ending_shop then
        card.ability.extra.has_star = true
    end
end



return joker