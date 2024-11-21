local joker = {
    name = "Meta Joker",
    key = "meta",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 6,
    pos = {x = 1, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = 1},
    loc_txt = {
        name ="Meta Joker",
        text={
            "{C:red}+#1#{} Mult per",
            "scoring effect",
            "each hand",
        },
    },
}

function eman_evaluate_meta(effects)

    local effect_count = 0

    if effects.Xmult_mod then
        effect_count = effect_count + 1
    end
    if effects.x_mult then
        effect_count = effect_count + 1
    end
    if effects.x_mult_mod then
        effect_count = effect_count + 1
    end
    if effects.mult_mod then
        effect_count = effect_count + 1
    end
    if effects.mult then
        effect_count = effect_count + 1
    end
    if effects.h_mult then
        effect_count = effect_count + 1
    end
    if effects.chip_mod then
        effect_count = effect_count + 1
    end
    if effects.chips then
        effect_count = effect_count + 1
    end

    G.GAME.current_round.meta_scoring_effects = G.GAME.current_round.meta_scoring_effects + effect_count

    if effects.jokers then
        eman_evaluate_meta(effects.jokers)
    end
    if effects.edition then
        eman_evaluate_meta(effects.edition)
    end
end

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main then
        local mult = G.GAME.current_round.meta_scoring_effects * card.ability.extra

        if mult > 0 then
            return {
                message = localize{type='variable',key='a_mult',vars={mult}},
                mult_mod = mult
            }
        end
    end
end



return joker