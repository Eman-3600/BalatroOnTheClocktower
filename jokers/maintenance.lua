local joker = {
    name = "Maintenance",
    key = "maintenance",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 12,
    pos = {x = 6, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {chips = 0, chips_mod = 50}},
    loc_txt = {
        name ="Maintenance",
        text={
            "Each blind, destroys a",
            "random {C:attention}playing card{} and",
            "gains {C:chips}+#2#{} Chips",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.chips,
        card.ability.extra.chips_mod,
    }}
end

joker.calculate = function (self, card, context)
    if context.first_hand_drawn and not context.blueprint then
        G.E_MANAGER:add_event(Event({
            func = function() 

                if #G.hand.cards <= 0 then
                    return true
                end

                local _card = pseudorandom_element(G.hand.cards, pseudoseed('maintenance'))
                if _card.ability.name == 'Glass Card' then 
                    _card:shatter()
                else
                    _card:start_dissolve()
                end

                G.hand:sort()
                card:juice_up()
                return true
            end}))

        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
    
        card_eval_status_text((card), 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}})
    elseif context.joker_main then
        return {
            message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
            chip_mod = card.ability.extra.chips,
            colour = G.C.CHIPS
        }
    end
end



return joker