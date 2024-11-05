local blind = {
    name = "The Web",
    key = "web",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 20},
    boss = {min = 5, max = 10},
    boss_colour = HEX('595959'),
    loc_txt = {
        name ="The Web",
        text={
            "Discards all cards",
            "before drawing more",
        },
    },
}

blind.eman_modify_draw = function (self, hand_space)
    
    if #G.hand.cards == 0 then return hand_space end

    local hand_count = #G.hand.cards
    G.GAME.blind:wiggle()
    G.FUNCS.draw_from_hand_to_discard()
    delay(0.3)

    return math.min(#G.deck.cards, hand_space + hand_count)
end




return blind