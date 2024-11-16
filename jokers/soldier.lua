local joker = {
    name = "Soldier",
    key = "soldier",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 4,
    pos = {x = 0, y = 0},
    blueprint_compat = true,
    config = {chips_per = 25},
    loc_txt = {
        name ="Soldier",
        text={
            "{C:blue}+#1#{} Chips per",
            "base edition Joker",
            "{C:inactive,s:0.9}(Currently {C:blue,s:0.9}+#2#{C:inactive,s:0.9} Chips)"
        },
    },
}

joker.soldier_get_chips = function (self)
    if G.jokers then
        local applicable = 0
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.edition then
                applicable = applicable + 1
            end
        end

        return self.config.chips_per * applicable
    end

    return 0
end

joker.loc_vars = function (self, info_queue, card)
    local total = self:soldier_get_chips()
    return {vars = {
        self.config.chips_per,
        total,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main then
        local total = self:soldier_get_chips()
        return {
            message = localize{type='variable',key='a_chips',vars={total}},
            chip_mod = total
        }
    end
end



return joker