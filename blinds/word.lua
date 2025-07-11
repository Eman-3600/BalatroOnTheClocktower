local blind = {
    name = "The Word",
    key = "word",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 17},
    boss = {min = 1, max = 10},
    boss_colour = HEX('2750cd'),
    loc_txt = {
        name ="The Word",
        text={
            "#1# in 2 played",
            "cards become jinxes",
        },
    },
}

blind.loc_vars = function (self)

    return { vars = {""..G.GAME.probabilities.normal}}
end

blind.collection_loc_vars = function (self)

    return { vars = {""..(G.GAME and G.GAME.probabilities.normal or 1)}}
end

blind.calculate = function (self, card, context)
    if context.before then
        for k, v in ipairs(context.scoring_hand) do
            if (pseudorandom(pseudoseed('word')) < G.GAME.probabilities.normal/2) then
                G.GAME.eman_jinxes_enabled = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.change_base(v, 'baotc_jinxes', nil)
                        v:juice_up()
                        return true
                    end
                }))
            end
        end
    end
end



return blind