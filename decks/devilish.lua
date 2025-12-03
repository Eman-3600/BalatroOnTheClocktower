local deck = {
    name = "Devilish Deck",
    key = "devilish",
    pos = {x = 0, y = 0},
    config = {extra = {eman_clones = 2}},
    atlas = "atlasclockdecks",
}

deck.calculate = function (self, card, context)
    if (context.setting_blind) then
        G.GAME.current_round.eman_clones = 2
    end
end

return deck