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
            "Cards discarded previously this",
            "ante are at the top of the deck",
        },
    },
}

blind.eman_rig_shuffle = function (self, seed)

    local first = {}
    local after = {}

    for i = #G.deck.cards, 1, -1 do
        local card = table.remove(G.deck.cards, i)

        if card.ability.discarded_this_ante then
            table.insert(first, card)
        else
            table.insert(after, card)
        end
    end

    pseudoshuffle(first, pseudoseed(seed.."_first"))
    pseudoshuffle(after, pseudoseed(seed.."_after"))

    for _, v in ipairs(after) do
        table.insert(G.deck.cards, v)
    end

    for _, v in ipairs(first) do
        table.insert(G.deck.cards, v)
    end
end

return blind