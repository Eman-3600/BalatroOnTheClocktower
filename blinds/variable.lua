local blind = {
    name = "The Variable",
    key = "variable",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 27},
    boss = {min = 3, max = 10},
    config = {extra = 3},
    boss_colour = HEX('802424'),
    loc_txt = {
        name ="The Variable",
        text={
            "All cards debuffed until",
            "#1# cards discarded",
        },
    },
}

blind.collection_loc_vars = function (self)
    return {vars = {
        'X'
    }}
end

blind.loc_vars = function (self)
    return {vars = {
        (G.GAME.blind and not G.GAME.blind.eman_extra.beaten and G.GAME.blind.eman_extra.discards)
        or (self.config.extra * G.GAME.current_round.eman_discards)
    }}
end

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.discards = self.config.extra * G.GAME.current_round.eman_discards

    local i = G.GAME.current_round.eman_discards - G.GAME.current_round.discards_left

    if i > 0 then
        ease_discard(i)
    end
end

blind.defeat = function (self)
    G.GAME.blind.eman_extra.beaten = true
end

blind.recalc_debuff = function (self, card, from_blind)
    return card.area ~= G.jokers and G.GAME.blind.eman_extra.discards > 0
end

blind.eman_after_discard = function (self, forced, discarded, kept)
    if not forced and G.GAME.blind.eman_extra.discards > 0 then
        G.GAME.blind.eman_extra.discards = math.max(G.GAME.blind.eman_extra.discards - #discarded, 0)

        for _, v in ipairs(G.playing_cards) do
            G.GAME.blind:debuff_card(v)
        end

        G.GAME.blind:set_text()
    end
end




return blind