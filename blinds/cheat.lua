local blind = {
    name = "The Cheat",
    key = "cheat",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 13},
    boss = {min = 1, max = 10},
    boss_colour = HEX('0a4e4e'),
    loc_txt = {
        name ="The Cheat",
        text={
            "Cycles drawn",
            "suits",
        },
    },
}

blind.eman_rig_shuffle = function (self, seed)

    local suits = {}

    for k, v in pairs(SMODS.Suits) do
        table.insert(suits, k)
    end

    local next = {}

    for i = #G.deck.cards, 1, -1 do
        local card = table.remove(G.deck.cards, i)
        card:create_suit_set()

        table.insert(next, card)
    end

    local sorted = {}
    local curr_suit = 0

    while #next > 0 do
        curr_suit = (curr_suit % #suits) + 1

        for i = #next, 1, -1 do
            local card = next[i]

            for k, v in ipairs(card.ability.suit_set) do
                if v == suits[curr_suit] then
                    table.insert(sorted, table.remove(next, i))
                    goto continue
                end
            end
        end

        ::continue::
    end

    for i = #sorted, 1, -1 do
        table.insert(G.deck.cards, table.remove(sorted, i))
    end
end

return blind