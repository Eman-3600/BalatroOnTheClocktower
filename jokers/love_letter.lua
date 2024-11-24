local joker = {
    name = "Love Letter",
    key = "love_letter",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 6,
    pos = {x = 6, y = 1},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {extra = {mult = {min = 7, max = 14}, x_mult = {min = 25, max = 35, fraction = .05}, chips = {min = 50, max = 100}, dollars = {min = 5, max = 8}}},
    loc_txt = {
        name ="Love Letter",
        text={
            "Scored {C:attention}Wild{} cards trigger",
            "random beneficial effects",
        },
    },
}

joker.in_pool = function (self)
    
    for _, v in ipairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_wild then return true end
    end
    
    return false
end

joker.love_letter_effects = {
    {
        weight = 35,
        func = function (card, wild_card, context)

            local mult = pseudorandom(pseudoseed('love_letter2'), card.ability.extra.mult.min, card.ability.extra.mult.max)

            return {
                card = card,
                mult = mult
            }
        end
    },
    {
        weight = 35,
        func = function (card, wild_card, context)

            local chips = pseudorandom(pseudoseed('love_letter2'), card.ability.extra.chips.min, card.ability.extra.chips.max)

            return {
                card = card,
                chips = chips
            }
        end
    },
    {
        weight = 15,
        func = function (card, wild_card, context)

            local xmult = pseudorandom(pseudoseed('love_letter2'), card.ability.extra.x_mult.min, card.ability.extra.x_mult.max) * card.ability.extra.x_mult.fraction

            return {
                card = card,
                x_mult = xmult
            }
        end
    },
    {
        weight = 10,
        func = function (card, wild_card, context)

            local dollars = pseudorandom(pseudoseed('love_letter2'), card.ability.extra.dollars.min, card.ability.extra.dollars.max)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + dollars
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))

            return {
                dollars = dollars,
                card = card
            }
        end
    },
    {
        weight = 1,
        func = function (card, wild_card, context)

            local mult = 20
            local dollars = 20
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + dollars
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))

            return {
                dollars = dollars,
                mult = mult,
                card = card
            }
        end
    },
    {
        weight = 3,
        func = function (card, wild_card, context)

            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then

                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {focus = card, message = localize('k_plus_tarot'), func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local _card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'love_letter2')
                                _card:add_to_deck()
                                G.consumeables:emplace(_card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                    end},
                    colour = G.C.SECONDARY_SET.Tarot,
                    card = card
                }

            else
                local dollars = pseudorandom(pseudoseed('love_letter2'), card.ability.extra.dollars.min, card.ability.extra.dollars.max)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + dollars
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
    
                return {
                    dollars = dollars,
                    card = card
                }
            end
        end
    },
    {
        weight = 1,
        func = function (card, wild_card, context)

            return {
                extra = {focus = card, message = '+1 Tag', func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local tag = pseudorandom_element(G.P_TAGS, pseudoseed('love_letter2'))

                            add_tag(Tag(tag.key))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)

                            return true
                        end)}))
                end},
                colour = G.C.GREEN,
                card = card
            }
        end
    },
}

local weight_total = 0
for _, effect in ipairs(joker.love_letter_effects) do
    weight_total = weight_total + effect.weight
end
joker.love_letter_effects.total_weight = weight_total

joker.calculate = function (self, card, context)
    if context.individual and context.cardarea == G.play then

        if context.other_card.config.center == G.P_CENTERS.m_wild then
            
            local roll = pseudorandom(pseudoseed('love_letter'), 1, self.love_letter_effects.total_weight)

            for _, effect in ipairs(self.love_letter_effects) do
                if roll <= effect.weight then
                    return effect.func(card, context.other_card, context)
                end
                roll = roll - effect.weight
            end
        end
    end
end



return joker