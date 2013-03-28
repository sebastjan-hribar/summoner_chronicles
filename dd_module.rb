
module DragonsDireWolves

      # The sorted player cards are generated.
      def generate_dragons(hm_deck_dragons, hm_deck)
        hm_deck_dragons.each {|dragon|
        hm_deck << dragon = DRAGON.new(dragon)}
      end

      def generate_dire_wolves(hm_deck_dire_wolves, hm_deck)
        hm_deck_dire_wolves.each {|dire_wolf|
        hm_deck << dire_wolf = DIRE_WOLF.new(dire_wolf) }
      end

      def generate_healing_spells(hm_deck_healing_spells, hm_deck)
        hm_deck_healing_spells.each {|healing_spell|
        hm_deck << healing_spell = HEAL.new(healing_spell)}
      end

      def generate_fire_spells(hm_deck_fire_spells, hm_deck)
        hm_deck_fire_spells.each {|fire_spell|
        hm_deck << fire_spell = FIRE.new(fire_spell)}
      end

      def generate_ice_spells(hm_deck_ice_spells, hm_deck)
        hm_deck_ice_spells.each {|ice_spell|
        hm_deck << ice_spell = ICE.new(ice_spell)}
      end

      # Generate AI cards
      def generate_ai_dragons(ai_deck_dragons, ai_deck)
        ai_deck_dragons.each {|dragon|ai_deck << dragon = DRAGON.new(dragon)}
      end

      def generate_ai_dire_wolves(ai_deck_dire_wolves, ai_deck)
        ai_deck_dire_wolves.each {|dire_wolf|
        ai_deck << dire_wolf = DIRE_WOLF.new(dire_wolf) }
      end

      def generate_ai_healing_spells(ai_deck_healing_spells, ai_deck)
        ai_deck_healing_spells.each {|healing_spell|
        ai_deck << healing_spell = HEAL.new(healing_spell)}
      end

      def generate_ai_fire_spells(ai_deck_fire_spells, ai_deck)
        ai_deck_fire_spells.each {|fire_spell|
        ai_deck << fire_spell = FIRE.new(fire_spell)}
      end

      def generate_ai_ice_spells(ai_deck_ice_spells, ai_deck)
        ai_deck_ice_spells.each {|ice_spell|
        ai_deck << ice_spell = ICE.new(ice_spell)}
      end

      def fight_round(hm_card, ai_card, hm_player, ai_player, arena, results, hm_deck, ai_deck, round)

          records = []
          records << "Round: #{round}."
          players = [hm_player, ai_player]
          opponent = players.sample
          if opponent == ai_player
                  own = hm_player
                  card = hm_card
                  records << "#{own.name} played #{card.name} - #{card.subtype}."
            if card.respond_to? :attack
                  records << "#{card.name} hits with: #{card.damage(arena)}"
                  card.effect(opponent, card, own, arena)
            elsif card.respond_to? :heal
                  records << "#{card.name} heals for: #{card.heal}"
                  card.effect(opponent, card, own, arena)
            else
            end

            opponent = hm_player
                  own = ai_player
                  card = ai_card
                  records << "#{own.name} played #{card.name} - #{card.subtype}."
            if card.respond_to? :attack
                  records << "#{card.name} hits with: #{card.damage(arena)}"
                  card.effect(opponent, card, own, arena)
            elsif card.respond_to? :heal
                  records << "#{card.name} heals for: #{card.heal}"
                  card.effect(opponent, card, own, arena)
            else
            end

          elsif opponent == hm_player
                  own = ai_player
                  card = ai_card
                  records << "#{own.name} played #{card.name} - #{card.subtype}."
            if card.respond_to? :attack
                  records << "#{card.name} hits with: #{card.damage(arena)}"
                  card.effect(opponent, card, own, arena)
            elsif card.respond_to? :heal
                  records << "#{card.name} heals for: #{card.heal}"
                  card.effect(opponent, card, own, arena)
            else
            end

            opponent = ai_player
                  own = hm_player
                  card = hm_card
                  records << "#{own.name} played #{card.name} - #{card.subtype}."
            if card.respond_to? :attack
                  records << "#{card.name} hits with: #{card.damage(arena)}"
                  card.effect(opponent, card, own, arena)
            elsif card.respond_to? :heal
                  records << "#{card.name} heals for: #{card.heal}"
                  card.effect(opponent, card, own, arena)
            else
            end
          else
          end

          hm_deck.delete(hm_card)
          ai_deck.delete(ai_card)

          results.prepend {
para"---------------------------------------------------------------------
Health points:
#{hm_player.name}: #{hm_player.hp}.
#{ai_player.name}: #{ai_player.hp}.
---------------------------------------------------------------------"}

        results.prepend {records.each_with_index {|r, i| para "#{i+1}. #{r}"}}


             if hm_deck.length == 0 or ai_deck.length == 0
                results.prepend {para "There is no victor, you will live to see another day!"}
                results.prepend {para link("DUEL AGAIN") {visit '/'}}
             elsif hm_player.hp <= 0 or ai_player.hp <= 0

                      if hm_player.hp > ai_player.hp
                        results.prepend {para "#{hm_player.name} is victorious!"}
                        results.prepend {para link("DUEL AGAIN") {visit '/'}}
                      elsif ai_player.hp > hm_player.hp
                        results.prepend {para "#{ai_player.name} is victorious!"}
                        results.prepend {para link("DUEL AGAIN") {visit '/'}}
                      elsif hm_player.hp == ai_player.hp
                        results.prepend {para "There is no victor, you will live to see another day!"}
                        results.prepend {para link("DUEL AGAIN") {visit '/'}}
                      elsif hm_deck.length == 0 or ai_deck.length == 0
                        results.prepend {para "There is no victor, you will live to see another day!"}
                        results.prepend {para link("DUEL AGAIN") {visit '/'}}
                      else
                      end
              else
              end
      end



      # AI player
      class AIPLAYER
        attr_accessor :name, :hp
            def initialize(name)
              @name = name
              @hp = 900
            end
      end

      # Human player
      class HMPLAYER
        attr_accessor :name, :hp
            def initialize(name)
              @name = name
              @hp = 900
            end
      end


      # Dire wolf
      class DIRE_WOLF
        attr_accessor :name, :attack, :type, :subtype, :effect, :image
            def initialize(name)
              @name = name
              @attack = 100 + rand(30)
              @type = "beast"
              @subtype = "dire wolf"
            end

            def image
            "images/wolf.png"
            end
            
            def attributes
              "Attack: " + @attack.to_s + "\n"
            end

            def effect(opponent, card, own, arena)
              opponent.hp -= @damage
            end

            def damage(arena)
              if arena == "Dark forrest"
              @damage = @attack * (rand(2)+1)
              else
              @damage = @attack
              end
              return @damage
            end
      end


      # Dragon
      class DRAGON
        attr_accessor :name, :attack, :type, :subtype, :effect, :image
            def initialize(name)
              @name = name
              @attack = 100 + rand(30)
              @type = "beast"
              @subtype = "dragon"
            end

            def image
            "images/dragon.png"
            end


            def attributes
              "Attack: " + @attack.to_s + "\n"
            end


            def effect(opponent, card, own, arena)
              opponent.hp -= @damage
            end

            def damage(arena)
              if arena == "High mountain"
              @damage = @attack * (rand(2)+1)
              else
              @damage = @attack
              end
              return @damage
            end
      end


      # Heal
      class HEAL
        attr_accessor :name, :heal, :type, :subtype, :image
            def initialize(name)
              @name = name
              @heal = 100
              @type = "spell"
              @subtype = "healing spell"
            end


            def image
            "images/heal_potion.png"
            end

            def attributes
              "Heal: " + @heal.to_s + "\n"
            end

            def effect(opponent, card, own, arena)
            own.hp += card.heal
            end
      end


      # Fire
      class FIRE
        attr_accessor :name, :attack, :type, :subtype, :effect, :image
            def initialize(name)
              @name = name
              @attack = 130 + rand(30)
              @type = "spell"
              @subtype = "fire spell"
            end

            def image
            "images/fire.png"
            end


            def attributes
              "Attack: " + @attack.to_s + "\n"
            end


            def effect(opponent)
              opponent.hp -= @attack
            end
      end


      # Ice
      class ICE
        attr_accessor :name, :attack, :type, :subtype, :effect, :image
            def initialize(name)
              @name = name
              @attack = 130 + rand(30)
              @type = "spell"
              @subtype = "ice spell"
            end

            def image
            "images/ice.png"
            end


            def attributes
              "Attack: " + @attack.to_s + "\n"
            end


            def effect(opponent)
              opponent.hp -= @attack
            end
      end

      # Text

      TITLE = "Summoner's Chronicles"

      INTRODUCTION = "You are in the arena. At your disposal for battle are dragons, dire wolves
and spells. You may choose up to 25 cards."

      NAME_PROMPT = "Please state your name, summoner, to be written in the Dragons' records."

      ARENA = "It is time to select the arena for the battle. Depending on the
selected arena, certain beasts will be granted more power.
Roll the dice!"


end
