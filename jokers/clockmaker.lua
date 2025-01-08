local joker = {
    name = "Clockmaker",
    key = "clockmaker",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 2,
    pos = {x = 2, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {chips = 0, chip_mod = 5}},
    loc_txt = {
        name ="Clockmaker",
        text={
            "Gains {C:chips}+#2#{} Chips when",
            "{C:attention}played hand{} doesn't win",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.chips,
        card.ability.extra.chip_mod,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main then
        if card.ability.extra.chips > 0 then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips
            }
        end
    elseif context.after and G.GAME.eman_chips < G.GAME.blind.chips then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
        return {
            message = localize{type='variable',key='a_chips',vars={card.ability.extra.chip_mod}},
            colour = G.C.CHIPS
        }
    end
end



return joker