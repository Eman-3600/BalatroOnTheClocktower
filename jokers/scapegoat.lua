local joker = {
    name = "Scapegoat",
    key = "scapegoat",
    atlas = "atlasclockjokers",
    rarity = 'baotc_traveler',
    cost = 15,
    pos = {x = 7, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {retriggers = 1}},
}

joker.loc_vars = function (self, info_queue, card)

    info_queue[#info_queue+1] = BAOTC.Desc.traveler

    return {}
end

joker.calculate = function (self, card, context)

    if context.before and not context.blueprint then
        local targets = {}

        for _, v in ipairs(context.scoring_hand) do
            if not v.debuff then
                table.insert(targets, v)
            end
        end

        if #targets > 0 then
            local target = pseudorandom_element(targets, pseudoseed('scapegoat'))

            target:set_debuff(true)
            target:juice_up()
        end
    end

    if context.repetition and context.cardarea == G.play then

        return {
            message = localize('k_again_ex'),
            repetitions = 1,
        }
    end

    BAOTC.calculate_traveler(card, context)
end



return joker