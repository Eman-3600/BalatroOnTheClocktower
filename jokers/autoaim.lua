local joker = {
    name = "Autoaim",
    key = "autoaim",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 7,
    pos = {x = 1, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {aces = 2}},
}

joker.loc_vars = function (self, info_queue, card)

    return {vars = {
        card.ability.extra.aces,
    }}
end

joker.calculate = function (self, card, context)

    local triggered_card = context.blueprint_card or card

    if context.setting_blind then
        
        triggered_card.ability.first_draw = true
    elseif context.eman_choose_drawn_card and triggered_card.ability.first_draw then

        if context.eman_choose_drawn_card.rig_counts[triggered_card] < card.ability.extra.aces then

            if context.eman_choose_drawn_card.rig_counts[triggered_card] >= card.ability.extra.aces - 1 then
                triggered_card.ability.first_draw = nil
            end

            for _, v in ipairs(G.deck.cards) do
                -- queued_draw is used to avoid drawing the same card twice
                if v:get_id() == 14 and not v.ability.queued_draw then
                    return {
                        message = 'Ace!',
                        colour = G.C.FILTER,
                        card = card,
                        rigged_draw = v
                    }
                end
            end

        end
    end
end



return joker