return {
    descriptions = {
        Back={
            b_baotc_devilish = {
                name ="Devilish Deck",
                text={
                    "Create two {C:dark_edition,T:e_baotc_phantom}Phantom{} copies",
                    "of first drawn card",
                    "each round",
                },
            },

            b_baotc_occult = {
                name ="Occult Deck",
                text={
                    "Deck starts with {C:baotc_jinxes}Jinxes{}",
                    "{C:attention}+2{} hand size",
                },
            },
        },
        Blind={},
        Edition={
            e_baotc_phantom = {
                name = "Phantom",
                text = {
                    "Vanishes after the",
                    "current blind ends",
                },
            },
        },
        Enhanced={},
        Joker={

            -- Regular Jokers

            j_baotc_ace_of_fours = {
                name ="Ace of 4s",
                text={
                    "Played {C:attention}Aces{} or {C:attention}4s{} give",
                    "{X:mult,C:white} X#1# {} Mult, whichever is",
                    "dominant in played hand",
                },
            },

            j_baotc_artist = {
                name ="Artist",
                text={
                    "{C:attention}+#1#{} hand size if",
                    "last hand caught fire",
                    "{X:attention,C:white} #2# {}"
                },
            },

            j_baotc_autoaim = {
                name ="Autoaim",
                text={
                    "On first draw, always draw",
                    "at least {C:attention}#1# Aces{}",
                },
            },

            j_baotc_noble = {
                name ="Noble",
                text={
                    "All card prices are",
                    "reduced by {C:money}$#1#{}",
                },
            },

            -- Forgotten Jokers

            j_baotc_astrolabe = {
                name ="Astrolabe",
                text={
                    "Sell this card to add",
                    "{C:dark_edition}Negative{} and {C:attention}Eternal{} to",
                    "a random {C:attention}Joker",
                },
            },

            j_baotc_charity = {
                name ="Charity",
                text={
                    "Creates a {C:attention,T:tag_coupon}Coupon Tag{}",
                    "at end of round",
                },
            },

            -- Travelers

            j_baotc_deviant = {
                name ="Deviant",
                text={
                    "{X:mult,C:white} X#1# {} Mult",
                },
            },

            j_baotc_bureaucrat = {
                name ="Bureaucrat",
                text={
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:blue}#1#{} Hands",
                    "Cards cost {C:money}$#2#{} more",
                },
            },

            j_baotc_thief = {
                name ="Thief",
                text={
                    "Played cards give",
                    "{C:money}$#1#{} when scored",
                    "{C:red}#2#{} discard each round",
                },
            },

            j_baotc_beggar = {
                name ="Beggar",
                text={
                    "Played cards with {C:spades}#1#{} or {C:clubs}#2#{}",
                    "suit give {X:mult,C:white} X#3# {} Mult when scored",
                    "Lose {C:money}$#4#{} at end of round",
                },
            },

            j_baotc_scapegoat = {
                name ="Scapegoat",
                text={
                    "Retrigger all cards played",
                    "Debuffs a scoring card",
                    "at random each hand",
                },
            },

            j_baotc_gunslinger = {
                name ="Gunslinger",
                text={
                    "First card scored",
                    "gives {X:mult,C:white} X#1# {} Mult",
                    "and is destroyed",
                },
            },

            j_baotc_butcher = {
                name ="Butcher",
                text={
                    "First played card of each",
                    "{C:attention}rank{} gives {X:mult,C:white} X#1# {} Mult when scored",
                    "Lose {C:money}$#2#{} per discard used",
                },
            },

            j_baotc_bone_collector = {
                name ="Bone Collector",
                text={
                    "At start of round, create a",
                    "{C:baotc_jinxes}#1#{} with a random {C:dark_edition}Edition{}",
                },
            },

            j_baotc_harlot = {
                name ="Harlot",
                text={
                    "Played cards with {C:hearts}#1#{} or {C:diamonds}#2#{}",
                    "suit give {X:mult,C:white} X#3# {} Mult when scored",
                    "Lose {C:money}$#4#{} at end of round",
                },
            },

            j_baotc_barista = {
                name ="Barista",
                text={
                    "Retrigger all cards played",
                    "Lose {C:money}$#1#{} each hand",
                },
            },
        },
        Other={
            -- Description Objects

            o_baotc_traveler = {
                name ="Traveler",
                text={
                    "After defeating a",
                    "{C:attention}Boss Blind{}, becomes",
                    "a new {C:baotc_traveler}Traveler{}"
                },
            }
        },
        Planet={},
        Spectral={
            c_baotc_shadow = {
                name = "Shadow",
                text = {
                    "Creates an {C:attention}Eternal",
                    "{C:baotc_forgotten}Forgotten{} {C:attention}Joker{},",
                    "destroys all other Jokers",
                },
            },

            c_baotc_mask = {
                name = "Mask",
                text = {
                    "Creates a copy of",
                    "the {C:baotc_traveler,T:j_baotc_deviant}Deviant{}",
                    "{C:blue}-1{} hand each round",
                },
            },
        },
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_baotc_forgotten = "Forgotten",
            k_baotc_traveler = "Traveler",
        },
        high_scores={},
        labels={
            baotc_phantom = "Phantom"
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={
            baotc_jinxes = "Jinxes"
        },
        suits_singular={
            baotc_jinxes = "Jinx"
        },
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}