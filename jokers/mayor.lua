local joker = {
    name = "Mayor",
    key = "mayor",
    atlas = "atlasclockjokers",
    rarity = 3,
    cost = 8,
    pos = {x = 7, y = 0},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = 1.5},
    loc_txt = {
        name ="Mayor",
        text={
            "Played cards with a",
            "{C:attention}seal{} each give",
            "{X:mult,C:white} X#1# {} Mult",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra,
    }}
end

joker.in_pool = function (self)
    
    for _, v in ipairs(G.playing_cards) do
        if v.seal then
            return true
        end
    end
    
    return false
end

joker.calculate = function (self, card, context)
    if context.individual then

        if context.other_card.seal then
            return {
                x_mult = card.ability.extra,
                card = card
            }
        end
    end
end



return joker