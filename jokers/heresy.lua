local joker = {
    name = "Heresy",
    key = "heresy",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 10,
    pos = {x = 4, y = 3},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_txt = {
        name ="Heresy",
        text={
            "Swaps base",
            "Chips and Mult",
        },
    },
}

joker.calculate = function (self, card, context)
    if context.eman_modify_hand then
        
        local _joker = context.blueprint_card or card

        G.E_MANAGER:add_event(Event({
            func = function()
                _joker:juice_up(0.5, 0.5)
                return true
            end
        }))

        return {
            mult = context.eman_modify_hand.chips,
            chips = context.eman_modify_hand.mult,
        }
    end
end



return joker