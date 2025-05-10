local blind = {
    name = "The Axe",
    key = "axe",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 7},
    boss = {min = 1, max = 10},
    boss_colour = HEX('a32630'),
    loc_txt = {
        name ="The Axe",
        text={
            "Debuffs and destroys the",
            "highest ranked card played",
        },
    },
}

blind.eman_before_play = function (self, played_hand)
    if #played_hand > 0 then
        local highest = get_highest(played_hand)[1]

        G.GAME.blind.triggered = true

        if highest[1] then
            highest[1].ability.condemned = true
            highest[1]:set_debuff(true)
            highest[1]:juice_up()
        end
    end
end

blind.calculate = function (self, card, context)
    if (context.destroy_card and context.cardarea == G.play) then
        if (context.destroy_card.ability.condemned) then
            return {
                remove = true
            }
        end
    end
end

blind.defeat = function (self)
    for _, card in ipairs(G.hand.cards) do
            
        card:set_debuff(false)
        card.ability.condemned = false
    end
end

blind.disable = function (self)
    for _, card in ipairs(G.hand.cards) do
            
        card:set_debuff(false)
        card.ability.condemned = false
    end
end



return blind