#encoding: utf-8
require 'green_shoes'
require_relative 'dd_module'
include DragonsDireWolves


class SummonerChronicles < Shoes

  url '/',                          :welcome
  url '/battle_preparation',        :battle_preparation
  url '/battle',                    :battle


    def welcome
      flow margin: 20 do
        title TITLE.upcase, :align => "center"
        para INTRODUCTION, margin: 30, :align => "center"

        image "images/title.png", width: 830, height: 530
        subtitle link("Prepare for duel") {visit '/battle_preparation'}, :align => "center"
      end
    end #welcome end


    def battle_preparation

          name_flow = flow margin: 25 do
              flow do
                  caption NAME_PROMPT

                  @player_name = edit_line
                    @player_name_button = button "Enter your name to the Chronicles" do
                    @@hm_player = HMPLAYER.new(@player_name.text)
                    @player_name.clear
                    @player_name_button.clear
                    name_flow.append {para "Welcome, #{@@hm_player.name}.\n"}
                    end
              end
          end


          flow margin: 10 do
          # Select and create computer players
          @possible_ai_players = ["High Priestess of Eltia",
          "Summoner of the Great Temple", "Lord of Dibia", "Great Assassin of the West"]
          @@ai_player = AIPLAYER.new(@possible_ai_players.sample)


          # 3. Possible cards
          @possible_cards = {:dragon => ["Derimor the blue scale dragon",
           "Barador the cave dweller", "Teragon the fire master",
           "Gali the lightning rider", "Ultrix the great avenger"],
           :dire_wolf => ["Ketox the silverback", "Halaton the ancient",
           "Endrimor the sabertooth", "Borox the peacemaker",
           "Otarix the quiet assasin"],
           :healing_spell => ["Potion of the ancients", "Elixir of life",
           "Aura of youth", "Potion of the Velix", "Regenerate"],
           :ice_spell => ["Cold wave", "Ice spikes", "Blue ray", "Frost spear",
           "Snow storm"],
           :fire_spell => ["Fire axe", "Scorching earth", "Burning spear",
            "Heat wave", "Lava burst"]}


          @@hm_deck = []
          @@ai_deck = []



          para "********************************************************************"

          caption "Please select the number of cards for each type."

          para "********************************************************************"



          # Select the number of each card types

          flow do
            para "Dragons"
            @dragons_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0;
            para "********************************************************************"
            para "Dire wolves"
            @dire_wolves_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0
            para "********************************************************************"
            para "Healing spells"
            @healing_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0
            para "********************************************************************"
            para "Fire spells"
            @fire_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0
            para "********************************************************************"
            para "Ice spells"
            @ice_qty = list_box items: [0, 1, 2, 3, 4, 5], choose: 0
            para "********************************************************************"
          end


          @prepare_button = button "Prepare cards" do
          # 5. The selected human player cards are sorted into sub-decks.
          @hm_deck_dragons = @possible_cards[:dragon].sample @dragons_qty.text
          @hm_deck_dire_wolves = @possible_cards[:dire_wolf].sample @dire_wolves_qty.text
          @hm_deck_healing_spells = @possible_cards[:healing_spell].sample @healing_qty.text
          @hm_deck_fire_spells = @possible_cards[:fire_spell].sample @fire_qty.text
          @hm_deck_ice_spells = @possible_cards[:ice_spell].sample @ice_qty.text

          # 6. AI cards are randomly picked and sorted
          @ai_deck_dragons = @possible_cards[:dragon].sample(rand(3)+3)
          @ai_deck_dire_wolves = @possible_cards[:dire_wolf].sample(rand(3)+3)
          @ai_deck_healing_spells = @possible_cards[:healing_spell].sample(rand(3)+3)
          @ai_deck_fire_spells = @possible_cards[:fire_spell].sample(rand(3)+3)
          @ai_deck_ice_spells = @possible_cards[:ice_spell].sample(rand(3)+3)

          # 7. The sorted player cards are generated.
          generate_dragons(@hm_deck_dragons, @@hm_deck)
          generate_dire_wolves(@hm_deck_dire_wolves, @@hm_deck)
          generate_healing_spells(@hm_deck_healing_spells, @@hm_deck)
          generate_fire_spells(@hm_deck_fire_spells, @@hm_deck)
          generate_ice_spells(@hm_deck_ice_spells, @@hm_deck)

          # 8. Generate AI cards
          generate_ai_dragons(@ai_deck_dragons, @@ai_deck)
          generate_ai_dire_wolves(@ai_deck_dire_wolves, @@ai_deck)
          generate_ai_healing_spells(@ai_deck_healing_spells, @@ai_deck)
          generate_ai_fire_spells(@ai_deck_fire_spells, @@ai_deck)
          generate_ai_ice_spells(@ai_deck_ice_spells, @@ai_deck)

          append{subtitle link("Enter battle") {visit '/battle'}}
          @prepare_button.clear
          end
        end
    end #battle_preparation end



    def battle
        flow margin: 20 do
        # 9. The player and the computer each play one card each turn until the health
        # points of either one of them falls to 0. The card played is removed
        # from the deck at the end of the turn.
        # If after 25 turns they both still live, the winner is the one with higher
        # health points.

        @arena_chosen = false
        caption ARENA, :align => "center"
        arena = flow margin: 20 do
          arena_button = button "Roll the dice" do
                @possible_arenas = ["High mountain", "Dark forrest"]
                @arena = @possible_arenas.sample
                if @arena == "High mountain"
                  arena_button.clear
                  arena.append {para "The battle will take place in the High mountain. Dragons will have
                                a chance for a critical strike."}
                elsif @arena == "Dark forrest"
                arena_button.clear
                  arena.append {para "The battle will take place in the Dark forrest. Dire wolves will have
                                a chance for a critical strike."}
                else
                end
              @arena_chosen = true
          end
        end




#Flow of stacks for each card with all properties
              para "These are your beasts and spells you command. Choose one to summon and unleash:"
              flow margin: 5 do
                flow margin_left: 5 do
                  a = []
                  @@hm_deck.each_with_index {|c,i|
                    a[i] = stack margin: 3, width: 150, height: 200 do
                        if c.subtype == "dragon"
                          background royalblue
                          border black, strokewidth: 2
                        elsif c.subtype == "dire wolf"
                          background forestgreen
                          border black, strokewidth: 2
                        elsif c.subtype == "healing spell"
                          background violet
                          border black, strokewidth: 2
                        elsif c.subtype == "fire spell"
                          background firebrick
                          border black, strokewidth: 2
                        elsif c.subtype == "ice spell"
                          background lightblue
                          border black, strokewidth: 2
                        else

                        end
                        para "#{i+1}. #{c.name}\n#{c.subtype}\n#{c.attributes}"
                          flow do
                            image c.image, width: 30, height: 30, margin_right: 30
                            button "Summon" do
                              if @arena_chosen == false
                                alert "Choose the arena first by rolling the dice!"
                              else
                                  @hm_card = c
                                  a[i].clear
                                  @@round +=1
                                  @ai_card = @@ai_deck.sample
                                  fight_round(@hm_card, @ai_card, @@hm_player, @@ai_player, @arena, @results, @@hm_deck, @@ai_deck, @@round)
                              end
                            end
                        end
                    end
                  }
                end
              end

              @@round = 0

              caption "Round records:"
              @results = stack do
              end
            
        end
    end #battle end
end

Shoes.app title: "Summoner's Chronicles", width: 800, height: 950

