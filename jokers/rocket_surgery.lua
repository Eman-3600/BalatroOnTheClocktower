local joker = {
    name = "Rocket Surgery",
    key = "rocket_surgery",
    atlas = "atlasclockjokers",
    rarity = 'baotc_forgotten',
    cost = 11,
    pos = {x = 8, y = 2},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_txt = {
        name ="Rocket Surgery",
        text={
            "Adds {C:money}Dollars{} to",
            "base Mult",
        },
    },
}

joker.calculate = function (self, card, context)
    if context.eman_modify_hand then
        
        local _joker = context.blueprint_card or card

        if G.GAME.dollars > 0 then

            G.E_MANAGER:add_event(Event({
                func = function()
                    _joker:juice_up(0.5, 0.5)
                    return true
                end
            }))

            return {
                mult = context.eman_modify_hand.mult + G.GAME.dollars,
                chips = context.eman_modify_hand.chips,
            }
        end
    end
end



return joker