local blind = {
    name = "The Knife",
    key = "knife",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 12},
    boss = {min = 5, max = 10},
    boss_colour = HEX('e95133'),
    loc_txt = {
        name ="The Knife",
        text={
            "Burn 2 cards",
            "after each draw",
        },
    },
}

blind.calculate = function (self, card, context)
    if context.hand_drawn then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function ()

                for i = 1, 2 do

                    if #G.deck.cards == 0 then break end

                    draw_card(G.deck, G.discard, i*50, 'down', false)
                end

                G.GAME.blind:wiggle()

                return true
            end
        }))
    end
end

blind.stay_flipped = function (self, area, card)

    if area == G.discard and card.facing == 'back' then
        card.ability.wheel_flipped = true

        return true
    end

    return false
end

return blind