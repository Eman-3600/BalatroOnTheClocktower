local joker = {
    name = "Orderly Joker",
    key = "orderly",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 5,
    pos = {x = 3, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {chips = 30}},
    loc_txt = {
        name ="Orderly Joker",
        text={
            "The first card of each",
            "{C:attention}suit{} scores {C:chips}+#1#{} Chips",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.chips
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play then

        local superposition = {}


        for _, _card in ipairs(G.play.cards) do
            _card:create_suit_set()

            local p = BAOTC.create_unique_suit_combo(superposition, _card.ability.suit_set)

            if #p > 0 then
                superposition = p
            end

            if _card == context.other_card then
                if #p > 0 then
                    return {
                        chips = card.ability.extra.chips,
                        card = card
                    }
                end

                break
            end
        end
    end
end



return joker