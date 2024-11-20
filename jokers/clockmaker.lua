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
    config = {extra = {chips = 35, chip_mod = 35}},
    loc_txt = {
        name ="Clockmaker",
        text={
            "{C:blue}+#1#{} Chips",
        },
    },
}

joker.set_ability = function (self, card, initial, delay_sprites)
    card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * (G.GAME and G.GAME.clockmakers_taken or 0))
end

joker.add_to_deck = function (self, card, from_debuff)
    if not from_debuff then
        G.GAME.clockmakers_taken = G.GAME.clockmakers_taken + 1
    end
end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.chips,
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
    end
end



return joker