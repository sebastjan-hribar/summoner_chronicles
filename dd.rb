#encoding: utf-8
require 'nkf'
require 'green_shoes'
require_relative 'dd_module'
include DragonsDireWolves


class SummonerChronicles < Shoes

  url '/',                          :welcome
  url '/battle_preparation',        :battle_preparation
  url '/battle',                    :battle



    def welcome
      flow do
        title TITLE.upcase, :align => "center"
        para INTRODUCTION, margin: 30, :align => "center"
        subtitle link("Prepare for battle") {visit '/battle_preparation'}
      end
    end #welcome end



    def battle_preparation
      flow do
          # 2. Players' selection
          # Define and create human player
          para NAME_PROMPT

          @players = []
          @player_name = edit_line; @player_name_button = button "Submitt name" do 
            @players << @hm_player = HMPLAYER.new(@player_name)
            @player_name.clear
            @player_name_button.clear
            alert("Player #{@hm_player.name} was created.")
            end


          # Select and create computer players
          @possible_ai_players = ["High Priestess of Eltia",
          "Summoner of the Great Temple", "Lord of Dibia", "Great Assassin of the West"]
          @players << @ai_player = AIPLAYER.new(@possible_ai_players.sample)


          # 3. Possible cards
          @possible_cards = {:dragon => ["'Derimor the blue scale dragon'",
           "'Barador the cave dweller'", "'Teragon the fire master'",
           "'Gali the lightning rider'", "'Ultrix the great avenger'"],
           :dire_wolf => ["'Ketox the silverback'", "'Halaton the ancient'",
           "'Endrimor the sabertooth'", "'Borox the peacemaker'",
           "'Otarix the quiet assasin'"],
           :healing_spell => ["'Potion of the ancients'", "'Elixir of life'",
           "'Aura of youth'", "'Potion of the Velix'"], :ice_spells => [],
           :fire_spells => []}


          # 4. The player states the number of cards for each type in the deck.
          # The number of cards in the deck must not be smaller than 20 and not
          # greater than 25.
          @hm_deck = []
          @ai_deck = []


          para "-----------------------------------------------------------------------------"

          caption "Please select the number of cards for each type."

          para "-----------------------------------------------------------------------------"



          # Select the number of each card types
          
          para "Select the number of dragons. Default value is 0."
          @dragons_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0

          para "Select the number of dire wolves. Default value is 0."
          @dire_wolves_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0

          para "Select the number of healing spells. Default value is 0."
          @healing_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0



          button "Prepare cards" do
          # 5. The selected human player cards are sorted into sub-decks.
          @hm_deck_dragons = @possible_cards[:dragon].sample @dragons_qty.text
          @hm_deck_dire_wolves = @possible_cards[:dire_wolf].sample @dire_wolves_qty.text
          @hm_deck_healing_spells = @possible_cards[:healing_spell].sample @healing_qty.text

          # 6. AI cards are randomly picked and sorted
          @ai_deck_dragons = @possible_cards[:dragon].sample(rand(3)+3)
          @ai_deck_dire_wolves = @possible_cards[:dire_wolf].sample(rand(3)+3)
          @ai_deck_healing_spells = @possible_cards[:healing_spell].sample(rand(3)+3)

          # 7. The sorted player cards are generated.
          generate_dragons(@hm_deck_dragons, @hm_deck)
          generate_dire_wolves(@hm_deck_dire_wolves, @hm_deck)
          generate_healing_spells(@hm_deck_healing_spells, @hm_deck)

          # 8. Generate AI cards
          generate_ai_dragons(@ai_deck_dragons, @ai_deck)
          generate_ai_dire_wolves(@ai_deck_dire_wolves, @ai_deck)
          generate_ai_healing_spells(@ai_deck_healing_spells, @ai_deck)
          
          append{@hm_deck.each {|c| para c.name}}
          append{subtitle link("Enter battle") {visit '/battle'}}
          end
        end
    end #battle_preparation end



    def battle
        flow do
        # 9. The player and the computer each play one card each turn until the health
        # points of either one of them falls to 0. The card played is removed
        # from the deck at the end of the turn.
        # If after 25 turns they both still live, the winner is the one with higher
        # health points.


        caption ARENA

        button "Roll the dice" do
              @possible_arenas = ["High mountain", "Dark forrest"]
              @arena = @possible_arenas.sample
              if @arena == "High mountain"
                append {para "The battle will take place in the High mountain. Dragons will have
                              a chance for a critical strike."}
              elsif @arena == "Dark forrest"
                append {para "The battle will take place in the Dark forrest. Dire wolves will have
                              a chance for a critical strike."}
              else
              end
        end


          
    #    while @hm_player.hp > 0 and ai_player.hp > 0
    #      puts "These are your beasts and spells you command. Choose one to summon:"
    #      puts "\n"
    #      hm_deck.each_with_index {|c,i| puts "#{i+1}. #{c.name}
    #    Type => #{c.type}; Subtype => #{c.subtype}; Attributes => #{c.attributes}\n"}
    #    prompt
    #      hm_card = hm_deck[(gets.to_i) - 1]
    #      ai_card = ai_deck.sample
button "test it" do
append {@hm_deck.each {|c| para c.name}}
end

#fight_turn





     #     if hm_deck.length == 0 or ai_deck.length == 0
     #       puts "There is no victor, you will live to see another day!"
     #       Process.exit(0)
     #     else
     #     end
     #   end # end while


    #        if @hm_player.hp > ai_player.hp
    #          puts "#{@hm_player.name} is victorious!"
    #        elsif ai_player.hp > @hm_player.hp
    #          puts "#{ai_player.name} is victorious!"
    #        elsif @hm_player.hp == ai_player.hp
    #          puts "There is no victor, you will live to see another day!"
    #          Process.exit(0)
    #        elsif hm_deck.length == 0 or ai_deck.length == 0
    #          puts "There is no victor, you will live to see another day!"
    #          Process.exit(0)
    #        else
    #        end
    end
    end #battle end
end

Shoes.app title: "Summoner's Chronicles", width: 800, height: 900

