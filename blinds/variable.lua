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
        self.config.extra * G.GAME.current_round.eman_discards
    }}
end

blind.set_blind = function (self)
    self.eman_discards = self.config.extra * G.GAME.current_round.eman_discards

    local i = G.GAME.current_round.eman_discards - G.GAME.current_round.discards_left

    if i > 0 then
        ease_discard(i)
    end
end

blind.recalc_debuff = function (self, card, from_blind)
    return card.area ~= G.jokers and self.eman_discards > 0
end

blind.eman_after_discard = function (self, forced, discarded, kept)
    if not forced then
        self.eman_discards = self.eman_discards - #discarded

        for _, v in ipairs(G.playing_cards) do
            G.GAME.blind:debuff_card(v)
        end
    end
end




return blind