local joker = {
    name = "Pacifist",
    key = "pacifist",
    atlas = "atlasclockjokers",
    rarity = 3,
    cost = 9,
    pos = {x = 1, y = 4},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {extra = {}},
    loc_txt = {
        name ="Pacifist",
        text={
            "If {C:attention}first discard{} of round",
            "has only {C:attention}1{} card, add",
            "a random {C:attention}seal{}",
        },
    },
}

joker.calculate = function (self, card, context)
    if context.first_hand_drawn and not context.blueprint then
        local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
    elseif context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
        G.E_MANAGER:add_event(Event({func = function()
            local seal_type = SMODS.poll_seal({ guaranteed = true, type_key = 'paci' })
            context.other_card:set_seal(seal_type, true)
            context.other_card:juice_up()
            return true
        end}))
        delay(0.6)
    end
end



return joker