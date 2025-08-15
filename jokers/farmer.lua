local joker = {
    name = "Farmer",
    key = "farmer",
    atlas = "atlasclockjokers",
    rarity = 3,
    cost = 8,
    pos = {x = 1, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {chance = 3}},
    loc_txt = {
        name ="Farmer",
        text={
            "Scored {C:attention}7s{} have a",
            "{C:green}#1# in #2#{} chance to turn a",
            "card in hand into a {C:attention}7{}",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        G.GAME.probabilities.normal,
        card.ability.extra.chance
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 7 then

            local valid_targets = {}

            for _, c in ipairs(G.hand.cards) do
                if c:get_id() ~= 7 and not c.ability.selected_by_farmer then
                    table.insert(valid_targets, c)
                end
            end

            if #valid_targets > 0 and pseudorandom(pseudoseed('farmer1')) < G.GAME.probabilities.normal / card.ability.extra.chance then

                local target = pseudorandom_element(valid_targets, pseudoseed('farmer2'))
                target.ability.selected_by_farmer = true
            
                return {
                    extra = {focus = context.blueprint_card or card, message = 'Farmed!', func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()

                                target:flip()
                                play_sound('card1', 1)
                                target:juice_up(0.3, 0.3)

                                SMODS.change_base(target, nil, '7')

                                target:flip()
                                play_sound('tarot2', 1, 0.6)
                                target:juice_up(0.3, 0.3)

                                target.ability.selected_by_farmer = nil
                                

                                return true
                            end)}))
                    end},
                    card = context.blueprint_card or card,
                    colour = G.C.TAROT,
                }

            end
        end
    end
end



return joker