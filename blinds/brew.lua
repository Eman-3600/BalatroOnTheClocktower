local blind = {
    name = "The Brew",
    key = "brew",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 0},
    boss = {min = 1, max = 10},
    boss_colour = HEX('a04c6b'),
    loc_txt = {
        name ="The Brew",
        text={
            "#1# in 2 chance each",
            "draw to petrify a card",
        },
    },
}

blind.calculate = function (self, card, context)
    if context.hand_drawn then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function ()

                local non_stones = {}

                if (pseudorandom(pseudoseed('brew')) >= G.GAME.probabilities.normal/2) then return true end

                for _, v in ipairs(G.hand.cards) do
                    
                    if v.ability.effect ~= "Stone Card" then
                        table.insert(non_stones, v)
                    end
                end

                if #non_stones > 0 then
                    local card = pseudorandom_element(non_stones, pseudoseed('brew'))

                    G.GAME.blind.triggered = true
            
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        card:flip()
                        play_sound('card1')
                        card:juice_up(0.3, 0.3)
                        G.GAME.blind:wiggle()
                        return true
                        end
                    }))
            
                    delay(0.2)
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        card:set_ability(G.P_CENTERS.m_stone)
                        return true
                        end
                    }))
            
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        card:flip()
                        play_sound('tarot2', 1, 0.6)
                        card:juice_up(0.3, 0.3)
                        return true
                        end
                    }))
                end

                return true
            end
        }))
    end
end

blind.loc_vars = function (self)

    return { vars = {""..G.GAME.probabilities.normal}}
end

blind.collection_loc_vars = function (self)

    return { vars = {""..(G.GAME and G.GAME.probabilities.normal or 1)}}
end



return blind