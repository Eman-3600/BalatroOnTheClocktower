local blind = {
    name = "The Tonic",
    key = "tonic",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 6},
    boss = {min = 1, max = 10},
    boss_colour = HEX('565d6a'),
    loc_txt = {
        name ="The Tonic",
        text={
            "Must play at",
            "least 2 suits",
        },
    },
}

blind.debuff_hand = function (self, cards, hand, handname, check)
    if #cards < 2 then return true end

    for _, card in ipairs(cards) do
        card:create_suit_set()
    end

    if #(cards[1].ability.suit_set) > 1 then return false end

    local lead_suit = cards[1].base.suit

    for i = 2, #cards, 1 do
        local card = cards[i]

        if #(card.ability.suit_set) > 1 or not card:is_suit(lead_suit) then return false end
    end

    return true
end

blind.get_loc_debuff_text = function (self)
    return "Must play more than 1 suit"
end



return blind