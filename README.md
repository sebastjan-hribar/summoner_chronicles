Summoner's Chronicles (Dragons and Direwolves)
==============================================

The working title of this game is Dragons and Direwolves and it simulates a battle
in a card trading game.

My goal is to expand it with some RPG elements.

In folder "terminal" there is the working terminal version of the game.




General logic
-------------

01. Player is presented with the general game goal and possible card types.
02. Human player states their name (computer name is randomly selected).
03. Player states the number of cards for each type in the deck.
04. The number of cards in the deck must not be smaller than 20 and not
    greater than 25.
05. The selected cards are generated (also for the computer player).
06. Player rolls a dice to select an arena (specific arena grants chances for
    critical strikes to relevant beasts).
07. Player is presented with the generated deck and they are prompted
    for the card selection.
08. Players each play one card each turn until the health points of either
    one of them falls to 0. The Opponent status is randomized each turn.
09. Each card has an effect on the game state (players' hp, other cards, etc.)

12. The card played is removed from the sub-deck at the end of the turn.
13. If after 25 turns they both still live, the winner is the one with higher
    health points.


Card types
----------

### 01. Beasts ######
  * Dragons
  * Dire wolfs

### 02. Spells ######
  * Heal
  * Ice
  * Fire


TODO
----

01. Review and refactor the HP and damage dealing system in terms of amount
    of points. []
02. Turns are counted and this is used for damage over time and so forth. []
03. A card may have instant, delayed or prolonged effect. []
04. GUI []
05. Add Ice and Fire spells. []
06. Add story. []
07. Add records of the games played. []
08. Spelling check. []
09. Add actual AI, influencing the deck selection and also selection of the
    cards played, depending on the opponent's health. []


License
-------
Creative Commons - Attribution Share Alike

Credits
-------
I would like to thank the ruby community for all the support and help
with this project, especially to Jesús Gabriel y Galán, Jan Ewald and others
on the Ruby
forum.

