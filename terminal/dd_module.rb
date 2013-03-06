module DragonsDireWolves

      # The prompt method
      def prompt
        print "> "
      end

      # Select card types
      def select_number_of_dragons()
      puts "Select the number of dragons (3-5)"
      dragons_qty = gets.chomp.to_i
        if dragons_qty < 3 or dragons_qty > 5
          puts "The number of dragons is invalid. Enter a number between 3 and 5."
          return select_number_of_dragons()
        end
        return dragons_qty
      end

      def select_number_of_dire_wolves()
      puts "Select the number of dire wolves (3-5)"
      dire_wolves_qty = gets.chomp.to_i
        if dire_wolves_qty < 3 or dire_wolves_qty > 5
          puts "The number of dire wolves is invalid."
          puts "Enter a number between 3 and 5."
          return select_number_of_dire_wolves()
        end
        return dire_wolves_qty
      end

      def select_number_of_armor_spells()
      puts "Select the number of armor spells (3-5)"
      armor_qty = gets.chomp.to_i
        if armor_qty < 1 or armor_qty > 5
          puts "The number of armor spells is invalid."
          puts "Enter a number between 3 and 5."
          return select_number_of_armor_spells()
        end
        return armor_qty
      end

      def select_number_of_debuff_spells()
      puts "Select the number of debuff spells (3-5)"
      debuff_qty = gets.chomp.to_i
        if debuff_qty < 3 or debuff_qty > 5
          puts "The number of debuff spells is invalid."
          puts "Enter a number between 3 and 5."
          return select_number_of_debuff_spells()
        end
        return debuff_qty
      end

      def select_number_of_healing_spells()
      puts "Select the number of healing spells (1-3)"
      healing_qty = gets.chomp.to_i
        if healing_qty < 1 or healing_qty > 3
          puts "The number of healing spells is invalid."
          puts "Enter a number between 1 and 3."
          return select_number_of_healing_spells()
        end
        return healing_qty
      end


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

      # AI player
      class AIPLAYER
        attr_accessor :name, :hp
            def initialize(name)
              @name = name
              @hp = 700
            end
      end

      # Human player
      class HMPLAYER
        attr_accessor :name, :hp
            def initialize(name)
              @name = name
              @hp = 700
            end
      end


      # Dire wolf
      class DIRE_WOLF
        attr_accessor :name, :attack, :type, :subtype, :effect
            def initialize(name)
              @name = name
              @attack = 100 + rand(30)
              @type = "beast"
              @subtype = "dire wolf"
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
        attr_accessor :name, :attack, :type, :subtype, :effect
            def initialize(name)
              @name = name
              @attack = 100 + rand(30)
              @type = "beast"
              @subtype = "dragon"
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
        attr_accessor :name, :heal, :type, :subtype
            def initialize(name)
              @name = name
              @heal = 50
              @type = "spell"
              @subtype = "healing spell"
            end


            def attributes
              "Heal: " + @heal.to_s + "\n"
            end

            def effect(opponent, card, own, arena)
            own.hp += card.heal
            end
      end

end
