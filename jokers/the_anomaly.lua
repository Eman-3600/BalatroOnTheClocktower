local joker = {
    name = "The Anomaly",
    key = "the_anomaly",
    atlas = "atlasclockjokers",
    rarity = 3,
    cost = 8,
    pos = {x = 5, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {x_mult = 4}},
    loc_txt = {
        name ="The Anomaly",
        text={
            "{X:mult,C:white} X#1# {} Mult if",
            "played hand is a",
            "{C:attention}secret poker hand"
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.x_mult,
    }}
end

joker.in_pool = function (self)
    
    for k, v in pairs(G.GAME.hands) do
        if v.eman_secret and v.visible then return true end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if context.joker_main then

        local poker_hand = G.GAME.hands[context.scoring_name]

        if poker_hand.eman_secret then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                Xmult_mod = card.ability.extra.x_mult
            }
        end
    end
end



return joker