local deck = {
    name = "Devilish Deck",
    key = "devilish",
    pos = {x = 0, y = 0},
    config = {extra = {eman_clones = 2}},
    atlas = "atlasclockdecks",
    loc_txt = {
        name ="Devilish Deck",
        text={
            "Create two {C:dark_edition}Phantom{} copies",
            "of first drawn card",
            "each round",
        },
    }
}

deck.calculate = function (self, card, context)
    if (context.setting_blind) then
        G.GAME.current_round.eman_clones = 2
    end
end

return deck