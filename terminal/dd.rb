require_relative 'dd_module'
include DragonsDireWolves



# 1. Introduction

puts <<INTRODUCTION

-----------------Welcome to Dragons and Dire Wolves--------------------------

You are in the arena. At your disposal for battle are dragons, dire wolves
 and spells.

You may choose between 20 and 23 cards all together.
-----------------------------------------------------------------------------
INTRODUCTION

# 2. Players' selection
# Define and create human player
puts <<NAME
-----------------------------------------------------------------------------
"Please state your name, summoner, to be written in the Dragons' records."
-----------------------------------------------------------------------------

NAME

prompt
players = [] << hm_player = HMPLAYER.new(gets.chomp.to_s)


# Select and create computer players
possible_ai_players = ["High Priestess of Eltia",
"Summoner of the Great Temple", "Lord of Dibia", "Great Assassin of the West"]
players << ai_player = AIPLAYER.new(possible_ai_players.sample)


# 3. Possible cards
possible_cards = {:dragon => ["'Derimor the blue scale dragon'",
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
hm_deck = []
ai_deck = []

puts <<CARD_SELECTION
-----------------------------------------------------------------------------
#{hm_player.name}, please select the number of cards for each type.
-----------------------------------------------------------------------------

CARD_SELECTION

dragons_qty = select_number_of_dragons
dire_wolves_qty = select_number_of_dire_wolves
healing_qty = select_number_of_healing_spells


# 5. The selected human player cards are sorted into sub-decks.
hm_deck_dragons = possible_cards[:dragon].sample dragons_qty
hm_deck_dire_wolves = possible_cards[:dire_wolf].sample dire_wolves_qty
hm_deck_healing_spells = possible_cards[:healing_spell].sample healing_qty

# 6. AI cards are randomly picked and sorted
ai_deck_dragons = possible_cards[:dragon].sample(rand(3)+3)
ai_deck_dire_wolves = possible_cards[:dire_wolf].sample(rand(3)+3)
ai_deck_healing_spells = possible_cards[:healing_spell].sample(rand(3)+3)


# 7. The sorted player cards are generated.
generate_dragons(hm_deck_dragons, hm_deck)
generate_dire_wolves(hm_deck_dire_wolves, hm_deck)
generate_healing_spells(hm_deck_healing_spells, hm_deck)


# 8. Generate AI cards
generate_ai_dragons(ai_deck_dragons, ai_deck)
generate_ai_dire_wolves(ai_deck_dire_wolves, ai_deck)
generate_ai_healing_spells(ai_deck_healing_spells, ai_deck)


# 9. The player and the computer each play one card each turn until the health
# points of either one of them falls to 0. The card played is removed
# from the deck at the end of the turn.
# If after 25 turns they both still live, the winner is the one with higher
# health points.


puts <<ARENA
-----------------------------------------------------------------------------
It is time to select the arena for the battle. Depending on the
selected arena, certain beasts will be granted more power.
Roll the dice by pressing Enter!
-----------------------------------------------------------------------------

ARENA

prompt
dice = gets.chomp

possible_arenas = ["High mountain", "Dark forrest"]
arena = possible_arenas.sample
if arena == "High mountain"
puts "-------------------------------------------------------------------------"
  puts "The battle will take place in the High mountain. Dragons will have"
  puts "a chance for a critical strike."
puts "-------------------------------------------------------------------------"
  puts "\n"
elsif arena == "Dark forrest"
puts "-------------------------------------------------------------------------"
  puts "The battle will take place in the Dark forrest. Dire wolves will have"
  puts "a chance for a critical strike."
  puts "-----------------------------------------------------------------------"
  puts "\n"
else
end

while hm_player.hp > 0 and ai_player.hp > 0
  puts "These are your beasts and spells you command. Choose one to summon:"
  puts "\n"
  hm_deck.each_with_index {|c,i| puts "#{i+1}. #{c.name}
Type => #{c.type}; Subtype => #{c.subtype}; Attributes => #{c.attributes}\n"}
prompt
  hm_card = hm_deck[(gets.to_i) - 1]
  ai_card = ai_deck.sample

  ## The cards effects are activated (opponent sequence is random)
puts "#####################################################################"

  players = [hm_player, ai_player]
  opponent = players.sample

  if opponent == ai_player
    own = hm_player
    card = hm_card
    puts "#{own.name} played #{card.name} - #{card.subtype}."
    if card.respond_to? :attack
    puts "#{card.name} hits with:"
    puts card.damage(arena)
    card.effect(opponent, card, own, arena)
    elsif card.respond_to? :heal
    puts "#{card.name} heals for:"
    puts card.heal
    card.effect(opponent, card, own, arena)
    else
    end

    opponent = hm_player
    own = ai_player
    card = ai_card
    puts "#{own.name} played #{card.name} - #{card.subtype}."
    if card.respond_to? :attack
    puts "#{card.name} hits with:"
    puts card.damage(arena)
    card.effect(opponent, card, own, arena)
    elsif card.respond_to? :heal
    puts "#{card.name} heals for:"
    puts card.heal
    card.effect(opponent, card, own, arena)
    else
    end

  elsif opponent == hm_player
    own = ai_player
    card = ai_card
    puts "#{own.name} played #{card.name} - #{card.subtype}."
    if card.respond_to? :attack
    puts "#{card.name} hits with:"
    puts card.damage(arena)
    card.effect(opponent, card, own, arena)
    elsif card.respond_to? :heal
    puts "#{card.name} heals for:"
    puts card.heal
    card.effect(opponent, card, own, arena)
    else
    end

    opponent = ai_player
    own = hm_player
    card = hm_card
    puts "#{own.name} played #{card.name} - #{card.subtype}."
    if card.respond_to? :attack
    puts "#{card.name} hits with:"
    puts card.damage(arena)
    card.effect(opponent, card, own, arena)
    elsif card.respond_to? :heal
    puts "#{card.name} heals for:"
    puts card.heal
    card.effect(opponent, card, own, arena)
    else
    end
  else
  end
puts "#####################################################################"


  hm_deck.delete(hm_card)
  ai_deck.delete(ai_card)

  puts "---------------------------------------------------------------------"
  puts "#{hm_player.name}'s health is #{hm_player.hp}."
  puts "#{ai_player.name}'s health is #{ai_player.hp}."
  puts "---------------------------------------------------------------------"

  if hm_deck.length == 0 or ai_deck.length == 0
    puts "There is no victor, you will live to see another day!"
    Process.exit(0)
  else
  end
end


  if hm_player.hp > ai_player.hp
    puts "#{hm_player.name} is victorious!"
  elsif ai_player.hp > hm_player.hp
    puts "#{ai_player.name} is victorious!"
  elsif hm_player.hp == ai_player.hp
    puts "There is no victor, you will live to see another day!"
    Process.exit(0)
  elsif hm_deck.length == 0 or ai_deck.length == 0
    puts "There is no victor, you will live to see another day!"
    Process.exit(0)
  else
  end


