local joker = {
    name = "Gravedigger",
    key = "gravedigger",
    atlas = "atlasclockjokers",
    rarity = 2,
    cost = 7,
    pos = {x = 5, y = 0},
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    config = {extra = .1},
    loc_txt = {
        name ="Gravedigger",
        text={
            "This Joker gains {X:mult,C:white} X#1# {} Mult",
            "for each Joker {C:attention}sold{}",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
    },
}

joker.loc_vars = function (self, info_queue, card)
    return {vars = {
        card.ability.extra,
        card.ability.x_mult,
    }}
end

joker.calculate = function (self, card, context)
    if context.selling_card and not context.blueprint and context.card.ability.set == 'Joker' then
        card.ability.x_mult = card.ability.x_mult + card.ability.extra
        G.E_MANAGER:add_event(Event({
            func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
            end}))
    end
end



return joker