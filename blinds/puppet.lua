local blind = {
    name = "The Puppet",
    key = "puppet",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 11},
    boss = {min = 4, max = 10},
    boss_colour = HEX('ebccb6'),
    loc_txt = {
        name ="The Puppet",
        text={
            "#1# in 3 drawn",
            "cards are Phantoms",
        },
    },
}

blind.loc_vars = function (self)

    return { vars = {""..G.GAME.probabilities.normal}}
end

blind.collection_loc_vars = function (self)

    return { vars = {""..(G.GAME and G.GAME.probabilities.normal or 1)}}
end

blind.eman_should_draw_phantom = function (self)
    return pseudorandom(pseudoseed('puppet')) < G.GAME.probabilities.normal/3
end

return blind