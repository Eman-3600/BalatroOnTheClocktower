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
    config = {extra = {aces = 1}},
    loc_txt = {
        name ="Autoaim",
        text={
            "If possible, always draw",
            "at least {C:attention}#1# Ace{}",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.aces,
    }}
end

joker.in_pool = function (self)

    for _, v in ipairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_stone then return true end
    end

    return false
end

joker.calculate = function (self, card, context)
    if context.eman_choose_drawn_card then

        local triggered_card = context.blueprint_card or card

        if context.eman_choose_drawn_card.rig_counts[triggered_card] < 1 then

            for _, v in ipairs(G.deck.cards) do
                -- queued_draw is used to avoid drawing the same card twice
                if v:get_id() == 14 and not v.ability.queued_draw then
                    return {
                        message = 'Fire!',
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