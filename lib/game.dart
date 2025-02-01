import 'dart:math';

import 'package:flutter/material.dart';

import 'objects/cards.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int cardsUsed = 13;
  final deck = [
    PlayingCard("assets/club/cardClubs_A.png", 1, Suit.club),
    PlayingCard("assets/club/cardClubs_2.png", 2, Suit.club),
    PlayingCard("assets/club/cardClubs_3.png", 3, Suit.club),
    PlayingCard("assets/club/cardClubs_4.png", 4, Suit.club),
    PlayingCard("assets/club/cardClubs_5.png", 5, Suit.club),
    PlayingCard("assets/club/cardClubs_6.png", 6, Suit.club),
    PlayingCard("assets/club/cardClubs_7.png", 7, Suit.club),
    PlayingCard("assets/club/cardClubs_8.png", 8, Suit.club),
    PlayingCard("assets/club/cardClubs_9.png", 9, Suit.club),
    PlayingCard("assets/club/cardClubs_10.png", 10, Suit.club),
    PlayingCard("assets/club/cardClubs_J.png", 11, Suit.club),
    PlayingCard("assets/club/cardClubs_Q.png", 12, Suit.club),
    PlayingCard("assets/club/cardClubs_K.png", 13, Suit.club),
    PlayingCard("assets/diamond/cardDiamonds_A.png", 1, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_2.png", 2, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_3.png", 3, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_4.png", 4, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_5.png", 5, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_6.png", 6, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_7.png", 7, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_8.png", 8, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_9.png", 9, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_10.png", 10, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_J.png", 11, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_Q.png", 12, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_K.png", 13, Suit.diamond),
    PlayingCard("assets/heart/cardHearts_A.png", 1, Suit.heart),
    PlayingCard("assets/heart/cardHearts_2.png", 2, Suit.heart),
    PlayingCard("assets/heart/cardHearts_3.png", 3, Suit.heart),
    PlayingCard("assets/heart/cardHearts_4.png", 4, Suit.heart),
    PlayingCard("assets/heart/cardHearts_5.png", 5, Suit.heart),
    PlayingCard("assets/heart/cardHearts_6.png", 6, Suit.heart),
    PlayingCard("assets/heart/cardHearts_7.png", 7, Suit.heart),
    PlayingCard("assets/heart/cardHearts_8.png", 8, Suit.heart),
    PlayingCard("assets/heart/cardHearts_9.png", 9, Suit.heart),
    PlayingCard("assets/heart/cardHearts_10.png", 10, Suit.heart),
    PlayingCard("assets/heart/cardHearts_J.png", 11, Suit.heart),
    PlayingCard("assets/heart/cardHearts_Q.png", 12, Suit.heart),
    PlayingCard("assets/heart/cardHearts_K.png", 13, Suit.heart),
    PlayingCard("assets/spade/cardSpades_A.png", 1, Suit.spade),
    PlayingCard("assets/spade/cardSpades_2.png", 2, Suit.spade),
    PlayingCard("assets/spade/cardSpades_3.png", 3, Suit.spade),
    PlayingCard("assets/spade/cardSpades_4.png", 4, Suit.spade),
    PlayingCard("assets/spade/cardSpades_5.png", 5, Suit.spade),
    PlayingCard("assets/spade/cardSpades_6.png", 6, Suit.spade),
    PlayingCard("assets/spade/cardSpades_7.png", 7, Suit.spade),
    PlayingCard("assets/spade/cardSpades_8.png", 8, Suit.spade),
    PlayingCard("assets/spade/cardSpades_9.png", 9, Suit.spade),
    PlayingCard("assets/spade/cardSpades_10.png", 10, Suit.spade),
    PlayingCard("assets/spade/cardSpades_J.png", 11, Suit.spade),
    PlayingCard("assets/spade/cardSpades_Q.png", 12, Suit.spade),
    PlayingCard("assets/spade/cardSpades_K.png", 13, Suit.spade),
  ];
  final deckSize = 52;
  late List<PlayingCard> hand;
  final handSize = 13;
  int points = 0;
  late Random random;
  int round = 1;
  int seed = DateTime.now().microsecondsSinceEpoch;
  Set<PlayingCard> selected = {};
  bool sortedBySuit = false;
  late bool validHand;

  void resetDeck() {
    deck.shuffle( random );
    hand = deck.sublist(0, handSize);
    hand.sort((a, b) => a.rank.compareTo(b.rank));
    if( sortedBySuit ) hand.sort((a, b) => a.suit.index.compareTo(b.suit.index));
    validHand = isHandValid();
  }

  bool isHandValid() {
    Map<Set<PlayingCard>, bool> threes = {}, fours = {};
    List<PlayingCard> temp = List.from(hand);

    temp.sort((a, b) => a.rank.compareTo(b.rank));

    // 3 set
    for( int i = 0; i < 11; i++ ) {
      if( temp[i].rank == temp[i + 1].rank &&
          temp[i].rank == temp[i + 2].rank ) {
        threes[ { temp[i], temp[i + 1], temp[i +2] } ] = false;
      }
    }

    // 4 set
    for( int i = 0; i < 10; i++ ) {
      if( temp[i].rank == temp[i + 1].rank &&
          temp[i].rank == temp[i + 2].rank &&
          temp[i].rank == temp[i + 3].rank ) {
        fours[ { temp[i], temp[i + 1], temp[i +2], temp[i + 3] } ] = false;
        i += 4;
      }
    }

    temp.sort((a, b) => a.suit.index.compareTo(b.suit.index));

    // 3 seq
    for( int i = 0; i < 11; i++ ) {
      if( ( temp[i].suit == temp[i + 1].suit &&
            temp[i].suit == temp[i + 2].suit ) &&
          ( temp[i].rank + 1 == temp[i + 1].rank &&
            temp[i].rank + 2 == temp[i + 2].rank ) ) {
        threes[ { temp[i], temp[i + 1], temp[i +2] } ] = true;
      }
    }

    // 4 seq
    for( int i = 0; i < 10; i++ ) {
      if( ( temp[i].suit == temp[i + 1].suit &&
            temp[i].suit == temp[i + 2].suit &&
            temp[i].suit == temp[i + 3].suit ) &&
          ( temp[i].rank + 1 == temp[i + 1].rank &&
            temp[i].rank + 2 == temp[i + 2].rank &&
            temp[i].rank + 3 == temp[i + 3].rank ) ) {
        fours[ { temp[i], temp[i + 1], temp[i +2], temp[i + 3] } ] = true;
      }
    }

    // check
    List<Set<PlayingCard>> curr = [], foursKeys = fours.keys.toList(), threesKeys = threes.keys.toList();

    for( int a = 0; a < foursKeys.length; a++ ) {
      curr.add(foursKeys[a]);

      for( int i = 0; i < threesKeys.length; i++ ) {
        if( !curr.any( (inUse) => inUse.any( threesKeys[i].contains ) ) ) {
          curr.add( threesKeys[i] );

          for( int j = i + 1; j < threesKeys.length; j++ ) {
            if( !curr.any( (inUse) => inUse.any( threesKeys[j].contains ) ) ) {
              curr.add( threesKeys[j] );

              for( int k = j + 1; k < threesKeys.length; k++ ) {
                if( !curr.any( (inUse) => inUse.any( threesKeys[k].contains ) ) ) {
                  curr.add( threesKeys[k] );
                  if( curr.any( (inUse) => ( threes[inUse] ?? false ) || ( fours[inUse] ?? false ) ) ) {
                    return true;
                  }
                  curr.remove( threesKeys[k] );
                }
              }
              curr.remove( threesKeys[j] );
            }
          }
          curr.remove( threesKeys[i] );
        }
      }
      curr.remove(foursKeys[a]);
    }

    return false;
  }

  @override
  void initState() {
    random = Random(seed);
    deck.shuffle( random );
    hand = deck.sublist(0, handSize);
    hand.sort((a, b) => a.rank.compareTo(b.rank));
    validHand = isHandValid();
    
    super.initState();
  }

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon( Icons.person )
          ),
          IconButton(
            onPressed: () {},
            icon: Icon( Icons.settings )
          )
        ],
        centerTitle: true,
        title: Text( "Remi Manado" )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text( "Cards remaining: ${deckSize - cardsUsed}/52" ),
              Text( "Points: $points" ),
              Text( "Round: $round" ),
              Text( "Seed: $seed" )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: hand.map(
              (card) => SizedBox(
                width: MediaQuery.of(context).size.width / handSize,
                child: GestureDetector(
                  onTap: () => setState(() {
                    if( selected.contains(card) ) {
                      selected.remove(card);
                    } else {
                      selected.add(card);
                    }
                  }),
                  child: Stack(
                    children: [
                      Image.network( card.face, fit: BoxFit.contain ),
                      if( selected.contains(card) ) Positioned.fill( child: Container( color: Colors.black.withAlpha(100) ) )
                    ]
                  )
                )
              )
            ).toList()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if( deckSize - cardsUsed < selected.length ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction( label: "OK", onPressed: () {} ),
                        behavior: SnackBarBehavior.floating,
                        content: Text( "Not enough cards remaining in deck" )
                      )
                    );
                  } else {
                    setState(() {
                      for( PlayingCard card in selected ) {
                        hand.remove(card);
                      }
                      while( hand.length < handSize ) {
                        hand.add( deck[cardsUsed] );
                        cardsUsed++;
                      }
                      hand.sort((a, b) => a.rank.compareTo(b.rank));
                      if( sortedBySuit ) hand.sort((a, b) => a.suit.index.compareTo(b.suit.index));
                      selected.clear();
                    });
                    validHand = isHandValid();
                  }
                },
                child: Text( "Discard" )
              ),
              TextButton(
                onPressed: () {
                  if( validHand ) {
                    setState(() {
                      for( PlayingCard card in hand ) {
                        points += card.rank;
                      }
                      resetDeck();
                      round++;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction( label: "OK", onPressed: () {} ),
                        behavior: SnackBarBehavior.floating,
                        content: Text( "Invalid hand" )
                      )
                    );
                  }
                },
                child: Text( validHand ? "Play hand" : "Invalid hand" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  seed = DateTime.now().microsecondsSinceEpoch;
                  random = Random(seed);
                  resetDeck();
                  points = 0;
                  round = 1;
                  selected.clear();
                  cardsUsed = 13;
                }),
                child: Text( "Reset" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  hand.sort((a, b) => a.rank.compareTo(b.rank));
                  sortedBySuit = false;
                }),
                child: Text( "Sort by rank" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  hand.sort((a, b) => a.rank.compareTo(b.rank));
                  hand.sort((a, b) => a.suit.index.compareTo(b.suit.index));
                  sortedBySuit = true;
                }),
                child: Text( "Sort by suit" )
              ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => setState(() {
                  hand = [
                    PlayingCard("assets/club/cardClubs_A.png", 1, Suit.club),
                    PlayingCard("assets/club/cardClubs_2.png", 2, Suit.club),
                    PlayingCard("assets/club/cardClubs_3.png", 3, Suit.club),
                    PlayingCard("assets/club/cardClubs_4.png", 4, Suit.club),
                    PlayingCard("assets/club/cardClubs_5.png", 5, Suit.club),
                    PlayingCard("assets/club/cardClubs_6.png", 6, Suit.club),
                    PlayingCard("assets/club/cardClubs_7.png", 7, Suit.club),
                    PlayingCard("assets/club/cardClubs_8.png", 8, Suit.club),
                    PlayingCard("assets/club/cardClubs_9.png", 9, Suit.club),
                    PlayingCard("assets/club/cardClubs_10.png", 10, Suit.club),
                    PlayingCard("assets/club/cardClubs_J.png", 11, Suit.club),
                    PlayingCard("assets/club/cardClubs_Q.png", 12, Suit.club),
                    PlayingCard("assets/club/cardClubs_K.png", 13, Suit.club)
                  ];
                }),
                child: Text( "All clubs" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  hand = [
                    PlayingCard("assets/club/cardClubs_10.png", 10, Suit.club),
                    PlayingCard("assets/club/cardClubs_J.png", 11, Suit.club),
                    PlayingCard("assets/club/cardClubs_Q.png", 12, Suit.club),
                    PlayingCard("assets/club/cardClubs_K.png", 13, Suit.club),
                    PlayingCard("assets/diamond/cardDiamonds_J.png", 11, Suit.diamond),
                    PlayingCard("assets/diamond/cardDiamonds_Q.png", 12, Suit.diamond),
                    PlayingCard("assets/diamond/cardDiamonds_K.png", 13, Suit.diamond),
                    PlayingCard("assets/heart/cardHearts_J.png", 11, Suit.heart),
                    PlayingCard("assets/heart/cardHearts_Q.png", 12, Suit.heart),
                    PlayingCard("assets/heart/cardHearts_K.png", 13, Suit.heart),
                    PlayingCard("assets/spade/cardSpades_J.png", 11, Suit.spade),
                    PlayingCard("assets/spade/cardSpades_Q.png", 12, Suit.spade),
                    PlayingCard("assets/spade/cardSpades_K.png", 13, Suit.spade),
                  ];
                }),
                child: Text( "Best hand" )
              )
            ],
          )
        ],
      )
    );
  }
}