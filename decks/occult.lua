local deck = {
    name = "Occult Deck",
    key = "occult",
    pos = {x = 1, y = 0},
    config = {hand_size = 2, extra = {eman_jinxes_enabled = true}},
    atlas = "atlasclockdecks",
}

deck.apply = function(self)

    G.GAME.eman_jinxes_enabled = true
end

return deck