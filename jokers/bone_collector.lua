local joker = {
    name = "Bone Collector",
    key = "bone_collector",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 2, y = 5},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {suit = 'baotc_jinxes'}},
}

joker.in_pool = function (self)

    return G.GAME.eman_jinxes_enabled
end

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {vars = {
        localize(card.ability.extra.suit, 'suits_singular'),
    }}
end

joker.calculate = function (self, card, context)
    if context.first_hand_drawn then
        G.E_MANAGER:add_event(Event({
            func = function() 

                local edition = poll_edition('bone_collector_e', nil, true, true)
                local _card = SMODS.add_card({
                    set = 'Playing Card',
                    area = G.hand,
                    edition = edition,
                    enhanced_poll = 1,
                    key_append = 'bone_collector_c',
                    suit = 'baotc_jinxes',
                })
                play_sound('tarot1')

                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                return true
            end}))

        playing_card_joker_effects({true})
    end

    BAOTC.calculate_traveler(card, context)
end



return joker