local blind = {
    name = "The Wish",
    key = "wish",
    mult = 1.5,
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 28},
    boss = {min = 4, max = 10},
    config = {},
    boss_colour = HEX('672aa1'),
    loc_txt = {
        name ="The Wish",
        text={
            "Replaces a",
            "random joker",
        },
    },
}

blind.set_blind = function (self)
    G.GAME.blind.eman_extra.prepped = true
end

blind.eman_after_draw = function (self, count)

    local valid_jokers = {}

    for _, j in ipairs(G.jokers.cards) do
        if not j.ability.eternal then
            table.insert(valid_jokers, j)
        end
    end

    if G.GAME.blind.eman_extra.prepped and #valid_jokers > 0 then

        local removed_joker = pseudorandom_element(valid_jokers, pseudoseed('wish_price'))
        local edition = removed_joker.edition
        local rarity = removed_joker.config.center.rarity
        local legendary = nil

        if rarity == 1 then
            rarity = 0
        elseif rarity == 3 then
            rarity = 0.99
        elseif rarity == 4 then
            rarity = nil
            legendary = true
        elseif rarity == 'baotc_forgotten' then
            rarity = nil
            G.GAME.eman_force_eternal_forgotten = true
        else
            rarity = 0.9
        end

        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.2, func = function ()

            removed_joker:start_dissolve()

            return true
        end}))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function ()
    
                play_sound("timpani")
                local card = create_card('Joker', G.jokers, legendary, rarity, nil, nil, nil, 'wish')
                card:set_edition(edition)
                G.GAME.eman_force_eternal_forgotten = false

                card:add_to_deck()
                G.jokers:emplace(card)
                card:juice_up(0.3, 0.5)
    
                G.GAME.blind:wiggle()
    
                return true
            end
        }))
    end

    G.GAME.blind.eman_extra.prepped = nil
end




return blind