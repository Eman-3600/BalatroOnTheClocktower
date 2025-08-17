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
            "Deck has jinxes",
            "this blind",
        },
    },
}

blind.in_pool = function (self)

    return not G.GAME.eman_jinxes_enabled
end

blind.set_blind = function (self)
    local ranks = G.GAME.starting_params.no_faces and {"A", "10", "9", "8", "7", "6", "5", "4", "3", "2"} or
        {"A", "K", "Q", "J", "10", "9", "8", "7", "6", "5", "4", "3", "2"}
    
    for _, r in ipairs(ranks) do
        SMODS.add_card({
            set = 'Playing Card',
            area = G.deck,
            skip_materialize = true,
            edition = 'e_baotc_phantom',
            suit = 'baotc_JINXES',
            rank = r,
            enhanced_poll = 1
        })
    end
end

-- blind.eman_rig_shuffle = function (self, seed)

--     local suits = {}

--     for k, v in pairs(SMODS.Suits) do
--         table.insert(suits, k)
--     end

--     table.insert(suits, "_")

--     local next = {}

--     for i = #G.deck.cards, 1, -1 do
--         local card = table.remove(G.deck.cards, i)
--         card:create_suit_set()

--         table.insert(next, card)
--     end

--     local sorted = {}
--     local curr_suit = 0

--     while #next > 0 do
--         curr_suit = (curr_suit % #suits) + 1

--         for i = #next, 1, -1 do
--             local card = next[i]

--             for k, v in ipairs(card.ability.suit_set) do
--                 if v == suits[curr_suit] then
--                     table.insert(sorted, table.remove(next, i))
--                     goto continue
--                 end
--             end
--         end

--         for i = #next, 1, -1 do
--             table.insert(sorted, table.remove(next, i))
--         end

--         ::continue::
--     end

--     for i = #sorted, 1, -1 do
--         table.insert(G.deck.cards, table.remove(sorted, i))
--     end
-- end

return blind