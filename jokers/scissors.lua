local joker = {
    name = "Scissors",
    key = "scissors",
    atlas = "atlasclockjokers",
    rarity = 1,
    cost = 4,
    pos = {x = 4, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {mult = 12, min_suits = 3}},
    loc_txt = {
        name ="Scissors",
        text={
            "{C:red}+#1#{} Mult if poker",
            "hand contains at",
            "least {C:attention}#2#{} different {C:attention}suits",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra.mult,
        card.ability.extra.min_suits,
    }}
end

joker.calculate = function (self, card, context)
    if context.joker_main then

        local superposition = {}

        for i = 1, #context.scoring_hand do

            context.scoring_hand[i]:create_suit_set()

            superposition = BAOTC.create_unique_suit_combo(superposition, context.scoring_hand[i].ability.suit_set, true)

            if superposition.max_chain >= card.ability.extra.min_suits then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
end



return joker