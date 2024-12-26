local joker = {
    name = "Negligence",
    key = "negligence",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 11,
    pos = {x = 7, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {},
    loc_txt = {
        name ="Negligence",
        text={
            "At start of blind,",
            "randomly enhances all",
            "drawn {C:attention}playing cards{}",
        },
    },
}

joker.calculate = function (self, card, context)
    if context.first_hand_drawn and not context.blueprint then
        G.E_MANAGER:add_event(Event({
            func = function() 

                if #G.hand.cards <= 0 then
                    return true
                end

                for i=1, #G.hand.cards do
                    local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
                end
                delay(0.1)

                for i=1, #G.hand.cards do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        local enhancement = SMODS.poll_enhancement({guaranteed = true})
                        G.hand.cards[i]:set_ability(G.P_CENTERS[enhancement])
                        return true

                        end }))
                end

                for i=1, #G.hand.cards do
                    local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
                end

                G.hand:sort()
                card:juice_up()
                return true
            end}))
        end
end



return joker