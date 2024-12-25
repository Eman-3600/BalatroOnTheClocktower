local joker = {
    name = "Dreamer",
    key = "dreamer",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 7, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {},
    loc_txt = {
        name ="Dreamer",
        text={
            "{C:attention}Playing cards{} found in",
            "{C:attention}Standard Packs{} have an",
            "{C:dark_edition}edition{} and a {C:attention}seal{}",
        },
    },
}

joker.calculate = function (self, card, context)
    if not context.blueprint and context.eman_booster_item and context.eman_booster_pack.ability.name:find('Standard') then

        local standard_card = context.eman_booster_item

        local edition = poll_edition('dreamer'..G.GAME.round_resets.ante, nil, true, true)
        standard_card:set_edition(edition)

        local seal_type = SMODS.poll_seal({guaranteed = true, type_key = 'dreamer'..G.GAME.round_resets.ante})
        standard_card:set_seal(seal_type)
    end
end



return joker