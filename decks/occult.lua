local deck = {
    name = "Occult Deck",
    key = "occult",
    pos = {x = 1, y = 0},
    config = {hand_size = 2, extra = {eman_jinxes_enabled = true}},
    atlas = "atlasclockdecks",
    loc_txt = {
        name ="Occult Deck",
        text={
            "Deck starts with Jinxes",
            "{C:attention}+2{} hand size",
        },
    }
}

deck.apply = function(self)

    G.GAME.eman_jinxes_enabled = true
end

return deck