local joker = {
    name = "Choirboy",
    key = "choirboy",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 7,
    pos = {x = 0, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = 1},
    loc_txt = {
        name ="Choirboy",
        text={
            "When round begins, add",
            "a random {C:attention}face card{}",
            "with a random {C:attention}enhancement{}",
            "to your hand",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra,
    }}
end

joker.calculate = function (self, card, context)
    if context.first_hand_drawn then
        G.E_MANAGER:add_event(Event({
            func = function() 

                local _rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('choirboy_r'))
                --local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('choirboy_create'))

                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end

                local center = pseudorandom_element(cen_pool, pseudoseed('choirboy'))
                -- local _card = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('choirboy'))}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})

                local _card = SMODS.add_card({
                    set = 'Playing Card',
                    area = G.hand,
                    no_edition = true,
                    enhanced_poll = 1,
                    key_append = 'choirboy_c',
                    rank = _rank,
                })
                play_sound('generic1')
                play_sound('voice'..math.random(1, 11))

                _card:set_ability(center)
                
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                return true
            end}))

        playing_card_joker_effects({true})
    end
end



return joker