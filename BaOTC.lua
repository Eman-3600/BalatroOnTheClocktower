----------------------------------------------
------------MOD CODE -------------------------

-- list of all blinds
local blind_list = {
    "lie",
    "scale",
    "blood",
    "brew",
    "taint",
    "tax",
    "tonic",
    "axe",
    "curse",
    "kiss",
    "tool",
    "puppet",
    "knife",
    "cheat",
    "fear",
    "blast",
    "seat",
    "word",
    "veil",
    "mirror",
    "web",
    "omen",
    "talon",
    "trick",

    "scarlet_thorn",
}

-- list of all jokers
local joker_list = {
    "clockmaker",
    "soldier",
    "monk",
    "turkey",
    "detective",
    "washerwoman",
    "gravedigger",
    "raven",
    "mayor",
    "virgin_ring",
    "choirboy",
    "meta",
    "artist",
    "scissors",
    "the_anomaly",
    "love_letter",
    "dreamer",
    "wildflower",
    "old_news",
    "autoaim",
    "snake_charmer",
    "librarian",
    "gambler",
    "farmer",

    "isolation",
    "quicksilver",
    "servitude",
    "diplomacy",
    "rocket_surgery",

    "elvis",
}

local mod_path = SMODS.current_mod.path
SMODS.Atlas{
    object_type = "atlas",
    key = "atlasclockbosses",
    atlas_table = "ANIMATION_ATLAS",
    path = "ClockBlinds.png",
    px = 34,
    py = 34,
    frames = 21,
}

SMODS.Atlas{
    object_type = "atlas",
    key = "atlasclockjokers",
    path = "ClockJokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{
    object_type = "atlas",
    key = "atlasclockextras",
    path = "ClockExtras.png",
    px = 71,
    py = 95,
}

SMODS.Rarity{
    key = "forgotten",
    loc_txt = {
        name ="Forgotten",
    },
    badge_colour = HEX('630c2b'),
}

SMODS.Edition {
    key = "phantom",
    shader = false,
    disable_shadow = true,
    disable_base_shader = false,

    discovered = true,
    config = {},

    loc_txt = {
        name = "Phantom",
        label = "Phantom",
        text = {
            "Vanishes after the",
            "current blind ends",
        },
    },
}

SMODS.Voucher {
    key = "history",
    atlas = "atlasclockextras",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "History",
        text = {
            "{C:baotc_forgotten}Forgotten{} Jokers may",
            "appear in any of",
            "the {C:attention}Buffoon Packs",
        },
    },
}

SMODS.Voucher {
    key = "library",
    atlas = "atlasclockextras",
    pos = {x = 0, y = 1},
    config = {extra = 1},
    loc_txt = {
        name = "Library",
        text = {
            "{C:attention}+#1#{} Card in",
            "all {C:attention}Booster Packs",
        },
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra}}
    end,
    requires = {'v_baotc_history'},
}

SMODS.Consumable {
    key = "shadow",
    set = 'Spectral',
    atlas = "atlasclockextras",
    pos = {x = 1, y = 0},
    config = {},
    loc_txt = {
        name = "Shadow",
        text = {
            "Creates an {C:attention}Eternal",
            "{C:baotc_forgotten}Forgotten{} Joker",
        },
    },
    can_use = function (self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end,
    use = function (self, card, area, copier)

        local used_tarot = copier or card

        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            G.GAME.eman_force_eternal_forgotten = true
            local _card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'shadow')
            G.GAME.eman_force_eternal_forgotten = false
            _card:set_eternal(true)
            _card:add_to_deck()
            G.jokers:emplace(_card)
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end,
}

-- pattern basically taken from Cryptid
function Blind:eman_before_discard(forced, discarded, kept)
    -- Called directly when the player discards cards
    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_before_discard and type(obj.eman_before_discard) == "function" then
			return obj:eman_before_discard(forced, discarded, kept)
		end
	end
end

function Blind:eman_after_discard(forced, discarded, kept)
    -- Called after the player discards cards

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_after_discard and type(obj.eman_after_discard) == "function" then
			return obj:eman_after_discard(forced, discarded, kept)
		end
	end
end

function Blind:eman_after_draw(draw_count)
    -- Called after the player draws cards

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_after_draw and type(obj.eman_after_draw) == "function" then
			return obj:eman_after_draw(draw_count)
		end
	end
end

function Blind:eman_modify_draw(hand_space)
    -- Called before the player draws cards; returns new hand space

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_modify_draw and type(obj.eman_modify_draw) == "function" then
			return obj:eman_modify_draw(hand_space) or hand_space
		end
	end

    return hand_space
end

function Blind:eman_before_play(played_hand)
    -- Called when the player plays cards before they are scored

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_before_play and type(obj.eman_before_play) == "function" then
			return obj:eman_before_play(played_hand)
		end
	end
end

function Blind:eman_should_destroy(card, hand_chips, mult)
    -- Called when checking which cards should be destroyed

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_should_destroy and type(obj.eman_should_destroy) == "function" then
			return obj:eman_should_destroy(card, hand_chips, mult)
		end
	end
end

function Blind:eman_should_draw_phantom()
    -- Called when drawing a card; returns whether or not the drawn card should be a phantom

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_should_draw_phantom and type(obj.eman_should_draw_phantom) == "function" then
			return obj:eman_should_draw_phantom()
		end
	end
end

function Blind:eman_modify_chips(hand_chips, mult)
    -- Called when checking which cards should be destroyed

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_modify_chips and type(obj.eman_modify_chips) == "function" then
			return obj:eman_modify_chips(hand_chips, mult)
		end
	end
end

function Blind:eman_rig_shuffle(seed)
    -- Called when shuffling deck; used to rig the shuffle

    if not self.disabled then
		local obj = self.config.blind
		if obj.eman_rig_shuffle and type(obj.eman_rig_shuffle) == "function" then
			return obj:eman_rig_shuffle(seed)
		end
	end
end

-- basically taken from MathBlinds, which was basically taken from Mystblinds, which was basically taken from 5CEBalatro lol
for k, v in ipairs(blind_list) do
    local blind = NFS.load(mod_path .. "blinds/" .. v .. ".lua")()

    -- load if present
    if not blind then
        sendErrorMessage("[BaOTC] Cannot find blind with shorthand: " .. v)
    else
        blind.key = v
        blind.discovered = false 

        local blind_obj = SMODS.Blind(blind)

        for k_, v_ in pairs(blind) do
            if type(v_) == 'function' then
                blind_obj[k_] = blind[k_]
            end
        end
    end
end

for k, v in ipairs(joker_list) do
    local joker = NFS.load(mod_path .. "jokers/" .. v .. ".lua")()

    -- load if present
    if not joker then
        sendErrorMessage("[BaOTC] Cannot find blind with shorthand: " .. v)
    else
        joker.key = v
        joker.discovered = false

        local joker_obj = SMODS.Joker(joker)

        for k_, v_ in pairs(joker) do
            if type(v_) == 'function' then
                joker_obj[k_] = joker[k_]
            end
        end
    end
end



function eman_draw_phantom_card(percent, dir, sort, delay, mute, stay_flipped, vol, discarded_only)

    percent = percent or 50
    delay = delay or 0.1 
    if dir == 'down' then 
        percent = 1-percent
    end
    sort = sort or false
    local drawn = nil

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = delay,
        func = function()

            local card = create_playing_card({
                front = pseudorandom_element(G.P_CARDS, pseudoseed('phantom')), 
                center = G.P_CENTERS.c_base}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})
            if G.GAME.blind then
                G.GAME.blind:wiggle()
            end
            card:set_edition("e_baotc_phantom", true, true)

            
            card = G.deck:remove_card(card)
            if card then drawn = true end
            local stay_flipped = G.GAME and G.GAME.blind and G.GAME.blind:stay_flipped(G.hand, card)
            if G.GAME.modifiers.flipped_cards then
                if pseudorandom(pseudoseed('flipped_card')) < 1/G.GAME.modifiers.flipped_cards then
                    stay_flipped = true
                end
            end
            G.hand:emplace(card, nil, stay_flipped)

            if not mute and drawn then
                G.VIBRATION = G.VIBRATION + 0.6
                play_sound('card1', 0.85 + percent*0.2/100, 0.6*(vol or 1))
            end
            if sort then
                G.hand:sort()
            end
            return true
        end
      }))
end

function x_suits_missing(cards, x)
    local suits = {
        'Hearts',
        'Clubs',
        'Diamonds',
        'Spades',
    }

    for _, card in ipairs(cards) do
        
        for i = 1, #suits, 1 do
            if (suits[i] == card.base.suit) then
                table.remove(suits, i)
            else
                i = i + 1
            end
        end

        if #suits == 0 then break end
    end

    return #suits >= x
end

function x_ranks_missing(cards, x)
    local ranks = {
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        'Jack',
        'Queen',
        'King',
        'Ace',
    }

    for _, card in ipairs(cards) do
        
        for i = 1, #ranks, 1 do
            if (ranks[i] == card.base.value) then
                table.remove(ranks, i)
            else
                i = i + 1
            end
        end

        if #ranks == 0 then break end
    end

    return #ranks >= x
end

-- Stores within each card all the suits it is considered to be
function create_all_suit_sets()
    
    for _, card in ipairs(G.playing_cards) do
        card:create_suit_set()
    end
end

-- Stores within the card all the suits it is considered to be
function Card:create_suit_set()
    local suit_set = {}

    for k, v in pairs(SMODS.Suits) do
        if self:is_suit(k) then
            table.insert(suit_set, k)
        end
    end

    self.ability.suit_set = suit_set
end

-- Creates and returns the different ways in which the given cards can be considered to be different suits
-- If this is impossible, will return an empty table instead
-- Used by the Word to flip cards of different suits
function create_unique_suit_combo(initial, suit_set, keep_old)
    local superpositions = {}

    if #initial == 0 then

        superpositions.max_chain = 0

        for _, suit in ipairs(suit_set) do
            local p = {}
            p[suit] = true

            table.insert(superpositions, p)

            superpositions.max_chain = 1
        end

        return superpositions
    end

    if keep_old then
        for _, position in ipairs(initial) do
            table.insert(superpositions, position)
        end

        superpositions.max_chain = initial.max_chain
    else
        superpositions.max_chain = 0
    end

    for _, suit in ipairs(suit_set) do
        for _, position in ipairs(initial) do
            if not position[suit] then
                local p = {}

                p[suit] = true

                local entries = 1

                for k, v in pairs(position) do
                    p[k] = true

                    entries = entries + 1
                end

                if entries > superpositions.max_chain then
                    superpositions.max_chain = entries
                end

                table.insert(superpositions, p)
            end
        end
    end

    return superpositions
end
    ----------------------------------------------
    ------------MOD CODE END----------------------