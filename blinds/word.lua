local blind = {
    name = "The Word",
    key = "word",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 17},
    boss = {min = 2, max = 10},
    boss_colour = HEX('2750cd'),
    loc_txt = {
        name ="The Word",
        text={
            "1 card of each",
            "suit drawn face down",
        },
    },
}

blind.eman_modify_draw = function (self, hand_count)

    create_all_suit_sets()
    self.flipped_combos = {}

    for _, card in ipairs(G.hand.cards) do
        if card.ability.wheel_flipped then
            self.flipped_combos = create_unique_suit_combo(self.flipped_combos, card.ability.suit_set)
        end
    end

    return hand_count
end

blind.stay_flipped = function (self, area, card)

    if area ~= G.hand then return false end

    local next_suit_combo = create_unique_suit_combo(self.flipped_combos, card.ability.suit_set)

    if next_suit_combo[1] then
        self.flipped_combos = next_suit_combo

        return true
    end

    return false
end



return blind