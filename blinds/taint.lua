local blind = {
    name = "The Taint",
    key = "taint",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 4},
    boss = {min = 1, max = 10},
    boss_colour = HEX('628d44'),
    loc_txt = {
        name ="The Taint",
        text={
            "1 card in hand",
            "always debuffed",
        },
    },
}

blind.eman_after_draw = function (self, count)

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function ()

            for _, v in ipairs(G.hand.cards) do
                if v.debuff then
                    return true
                end
            end

            if #G.hand.cards > 0 then

                local card = pseudorandom_element(G.hand.cards, pseudoseed('taint'))

                self.triggered = true

                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    card:juice_up(0.3, 0.3)
                    play_sound('tarot2', 1, 0.6)
                    G.GAME.blind:wiggle()
                    card:set_debuff(true)
                    return true
                    end
                }))
            end

            return true
        end
    }))


end

blind.recalc_debuff = function (self, card, from_blind)
    return card.debuff
end



return blind