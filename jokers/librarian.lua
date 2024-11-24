local joker = {
    name = "Librarian",
    key = "librarian",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 7, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {},
    loc_txt = {
        name ="Librarian",
        text={
            "{C:baotc_forgotten}Forgotten{} Jokers",
            "can appear in the shop",
        },
    },
}

joker.calculate = function (self, card, context)
    if not context.blueprint and context.eman_modify_pool_rarity then
        
        if G.GAME.eman_pool_target == G.shop_jokers and pseudorandom(pseudoseed('librarian'..(context.eman_modify_pool_rarity._append or ''))) > 0.97 then
            return {rarity = 'baotc_forgotten'}
        end
    end
end



return joker