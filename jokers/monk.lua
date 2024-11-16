local joker = {
    name = "Monk",
    key = "monk",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 4,
    pos = {x = 1, y = 0},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {mult_per = 8},
    loc_txt = {
        name ="Monk",
        text={
            "{C:red}+#1#{} Mult per",
            "{C:dark_edition}Special Edition{} Joker",
            "{C:inactive,s:0.9}(Currently {C:red,s:0.9}+#2#{C:inactive,s:0.9} Mult)"
        },
    },
}

joker.monk_get_mult = function (self)
    if G.jokers then
        local applicable = 0
        for _, joker in ipairs(G.jokers.cards) do
            if joker.edition then
                applicable = applicable + 1
            end
        end

        return self.config.mult_per * applicable
    end

    return 0
end

joker.loc_vars = function (self, info_queue, card)
    local total = self:monk_get_mult()
    return {vars = {
        self.config.mult_per,
        total,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main then
        local total = self:monk_get_mult()
        return {
            message = localize{type='variable',key='a_mult',vars={total}},
            mult_mod = total
        }
    end
end



return joker