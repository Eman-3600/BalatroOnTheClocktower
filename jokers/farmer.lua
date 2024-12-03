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
    config = {extra = {}},
    loc_txt = {
        name ="Farmer",
        text={
            "Scored {C:attention}7s{} turn a",
            "card in hand into a {C:attention}7{}",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        
    }}
end

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 7 then

            local valid_targets = {}

            for _, c in ipairs(G.hand.cards) do
                if c:get_id() ~= 7 then
                    table.insert(valid_targets, c)
                end
            end

            if #valid_targets > 0 then
            
                return {
                    extra = {focus = context.blueprint_card or card, message = 'Farmed!', func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                
                                local target = pseudorandom_element(valid_targets, pseudoseed('farmer'))

                                target:flip()
                                play_sound('card1', 1)
                                target:juice_up(0.3, 0.3)

                                delay(.15)

                                local suit_prefix = string.sub(target.base.suit, 1, 1)..'_'
                                target:set_base(G.P_CARDS[suit_prefix..'7'])

                                delay(.3)

                                target:flip()
                                play_sound('tarot2', 1, 0.6)
                                target:juice_up(0.3, 0.3)
                                

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