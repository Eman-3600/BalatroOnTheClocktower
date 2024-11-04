local blind = {
    name = "The Mirror",
    key = "mirror",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 19},
    boss = {min = 3, max = 10},
    boss_colour = HEX('729678'),
    loc_txt = {
        name ="The Mirror",
        text={
            "Reshuffles deck",
            "before each draw",
        },
    },
}

blind.eman_modify_draw = function (self, hand_space)
    
    if #G.discard.cards == 0 then return hand_space end

    delay(0.2)
    local discard_count = #G.discard.cards
    G.GAME.blind:wiggle()
    for i=1, discard_count do
        draw_card(G.discard, G.deck, i*100/discard_count,'up', nil ,nil, 0.005, i%2==0, nil, math.max((21-i)/20,0.7))
    end
    delay(0.3)
    G.deck:shuffle('nr'..G.GAME.round_resets.ante)
    delay(0.1)

    return hand_space
end




return blind