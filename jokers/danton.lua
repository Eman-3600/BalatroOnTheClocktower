local joker = {
    name = "Danton",
    key = "danton",
    atlas = "atlasclockjokers",
    rarity = 4,
    cost = 20,
    pos = {x = 9, y = 2},
    soul_pos = {x = 9, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {},
    loc_txt = {
        name ="Danton",
        text={
            "All bosses are finisher blinds,",
            "beating one creates a {C:dark_edition}Negative{}",
            "copy of a random Joker",
            "{s:0.8,C:attention}Danton{s:0.8} excluded",
        },
    },
}

joker.add_to_deck = function (self, card, from_debuff)
    if not (G.GAME.round_resets.blind_choices.Boss.boss and not G.GAME.round_resets.blind_choices.Boss.boss.showdown) then
        G.from_boss_tag = true
        G.FUNCS.reroll_boss()
    end
end

joker.calculate = function (self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.config.blind.boss
    and G.GAME.blind.config.blind.boss.showdown then
        local targets = {}

        for _, _joker in ipairs(G.jokers.cards) do
            if _joker.config.center ~= self then
                table.insert(targets, _joker)
            end
        end

        if #targets > 0 then
            local target = pseudorandom_element(targets, pseudoseed('danton'))

            local clone = copy_card(target, nil, nil, nil, target.edition)
            clone:start_materialize()
            clone:add_to_deck()
            clone:set_edition({negative = true})
            G.jokers:emplace(clone)
        end
    end
end



return joker