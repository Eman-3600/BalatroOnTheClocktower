local joker = {
    name = "Detective",
    key = "detective",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 3, y = 0},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = 2},
    loc_txt = {
        name ="Detective",
        text={
            "{X:mult,C:white}X#1#{} Mult",
            "during a {C:attention}Boss Blind{}",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main and G.GAME.blind.boss then
        return {
            message = localize{type='variable',key='a_xmult',vars={card.ability.extra}},
            Xmult_mod = card.ability.extra
        }
    end
end



return joker