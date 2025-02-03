import 'dart:math';

import 'package:flutter/material.dart';

import 'objects/powers.dart';
import 'objects/cards.dart';
import 'tutorial.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int cardsUsed = 13;
  final deck = [
    PlayingCard("assets/club/cardClubs_2.png", Rank.two, Suit.club, 2),
    PlayingCard("assets/club/cardClubs_3.png", Rank.three, Suit.club, 3),
    PlayingCard("assets/club/cardClubs_4.png", Rank.four, Suit.club, 4),
    PlayingCard("assets/club/cardClubs_5.png", Rank.five, Suit.club, 5),
    PlayingCard("assets/club/cardClubs_6.png", Rank.six, Suit.club, 6),
    PlayingCard("assets/club/cardClubs_7.png", Rank.seven, Suit.club, 7),
    PlayingCard("assets/club/cardClubs_8.png", Rank.eight, Suit.club, 8),
    PlayingCard("assets/club/cardClubs_9.png", Rank.nine, Suit.club, 9),
    PlayingCard("assets/club/cardClubs_10.png", Rank.ten, Suit.club, 10),
    PlayingCard("assets/club/cardClubs_J.png", Rank.jack, Suit.club, 10),
    PlayingCard("assets/club/cardClubs_Q.png", Rank.queen, Suit.club, 10),
    PlayingCard("assets/club/cardClubs_K.png", Rank.king, Suit.club, 10),
    PlayingCard("assets/club/cardClubs_A.png", Rank.ace, Suit.club, 11),
    PlayingCard("assets/diamond/cardDiamonds_2.png", Rank.two, Suit.diamond, 2),
    PlayingCard("assets/diamond/cardDiamonds_3.png", Rank.three, Suit.diamond, 3),
    PlayingCard("assets/diamond/cardDiamonds_4.png", Rank.four, Suit.diamond, 4),
    PlayingCard("assets/diamond/cardDiamonds_5.png", Rank.five, Suit.diamond, 5),
    PlayingCard("assets/diamond/cardDiamonds_6.png", Rank.six, Suit.diamond, 6),
    PlayingCard("assets/diamond/cardDiamonds_7.png", Rank.seven, Suit.diamond, 7),
    PlayingCard("assets/diamond/cardDiamonds_8.png", Rank.eight, Suit.diamond, 8),
    PlayingCard("assets/diamond/cardDiamonds_9.png", Rank.nine, Suit.diamond, 9),
    PlayingCard("assets/diamond/cardDiamonds_10.png", Rank.ten, Suit.diamond, 10),
    PlayingCard("assets/diamond/cardDiamonds_J.png", Rank.jack, Suit.diamond, 10),
    PlayingCard("assets/diamond/cardDiamonds_Q.png", Rank.queen, Suit.diamond, 10),
    PlayingCard("assets/diamond/cardDiamonds_K.png", Rank.king, Suit.diamond, 10),
    PlayingCard("assets/diamond/cardDiamonds_A.png", Rank.ace, Suit.diamond, 11),
    PlayingCard("assets/heart/cardHearts_2.png", Rank.two, Suit.heart, 2),
    PlayingCard("assets/heart/cardHearts_3.png", Rank.three, Suit.heart, 3),
    PlayingCard("assets/heart/cardHearts_4.png", Rank.four, Suit.heart, 4),
    PlayingCard("assets/heart/cardHearts_5.png", Rank.five, Suit.heart, 5),
    PlayingCard("assets/heart/cardHearts_6.png", Rank.six, Suit.heart, 6),
    PlayingCard("assets/heart/cardHearts_7.png", Rank.seven, Suit.heart, 7),
    PlayingCard("assets/heart/cardHearts_8.png", Rank.eight, Suit.heart, 8),
    PlayingCard("assets/heart/cardHearts_9.png", Rank.nine, Suit.heart, 9),
    PlayingCard("assets/heart/cardHearts_10.png", Rank.ten, Suit.heart, 10),
    PlayingCard("assets/heart/cardHearts_J.png", Rank.jack, Suit.heart, 10),
    PlayingCard("assets/heart/cardHearts_Q.png", Rank.queen, Suit.heart, 10),
    PlayingCard("assets/heart/cardHearts_K.png", Rank.king, Suit.heart, 10),
    PlayingCard("assets/heart/cardHearts_A.png", Rank.ace, Suit.heart, 11),
    PlayingCard("assets/spade/cardSpades_2.png", Rank.two, Suit.spade, 2),
    PlayingCard("assets/spade/cardSpades_3.png", Rank.three, Suit.spade, 3),
    PlayingCard("assets/spade/cardSpades_4.png", Rank.four, Suit.spade, 4),
    PlayingCard("assets/spade/cardSpades_5.png", Rank.five, Suit.spade, 5),
    PlayingCard("assets/spade/cardSpades_6.png", Rank.six, Suit.spade, 6),
    PlayingCard("assets/spade/cardSpades_7.png", Rank.seven, Suit.spade, 7),
    PlayingCard("assets/spade/cardSpades_8.png", Rank.eight, Suit.spade, 8),
    PlayingCard("assets/spade/cardSpades_9.png", Rank.nine, Suit.spade, 9),
    PlayingCard("assets/spade/cardSpades_10.png", Rank.ten, Suit.spade, 10),
    PlayingCard("assets/spade/cardSpades_J.png", Rank.jack, Suit.spade, 10),
    PlayingCard("assets/spade/cardSpades_Q.png", Rank.queen, Suit.spade, 10),
    PlayingCard("assets/spade/cardSpades_K.png", Rank.king, Suit.spade, 10),
    PlayingCard("assets/spade/cardSpades_A.png", Rank.ace, Suit.spade, 11),
  ];
  final deckSize = 52;
  late List<PlayingCard> hand;
  final handSize = 13;
  int points = 0;
  final powers = [
    Power( "+1 point for every black in hand", () {}, "Blacks" ),
    Power( "+1 point for every red in hand", () {}, "Reds" ),
    Power( "+1 point for every club in hand", () {}, "Clubs" ),
    Power( "+1 point for every diamond in hand", () {}, "Diamonds" ),
    Power( "+1 point for every heart in hand", () {}, "Hearts" ),
    Power( "+1 point for every spade in hand", () {}, "Spades" ),
    Power( "+1 point for every even number hand", () {}, "Evens" ),
    Power( "+1 point for every odd number in hand", () {}, "Odds" ),
    Power( "+1 point for every face in hand", () {}, "Faces" ),
    Power( "+1 point for every ace in hand", () {}, "Aces" )
  ];
  late Random random;
  int round = 1;
  int seed = DateTime.now().microsecondsSinceEpoch;
  Set<PlayingCard> selected = {};
  bool sortedBySuit = false;
  int threshold = 1;
  late bool validHand;

  void resetDeck() {
    deck.shuffle( random );
    hand = deck.sublist(0, handSize);
    hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
    if( sortedBySuit ) hand.sort((a, b) => a.suit.index.compareTo(b.suit.index));
    validHand = isHandValid();
  }

  void resetGame() {
    cardsUsed = 13;
    points = 0;
    round = 1;
    selected.clear();
    threshold = 1;
    seed = DateTime.now().microsecondsSinceEpoch;
    random = Random(seed);
    resetDeck();
  }

  bool isHandValid() {
    Map<Set<PlayingCard>, bool> threes = {}, fours = {};
    List<PlayingCard> temp = List.from(hand);

    temp.sort((a, b) => a.rank.index.compareTo(b.rank.index));

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
          ( temp[i].rank.index + 1 == temp[i + 1].rank.index &&
            temp[i].rank.index + 2 == temp[i + 2].rank.index ) ) {
        threes[ { temp[i], temp[i + 1], temp[i +2] } ] = true;
      }
    }

    // 4 seq
    for( int i = 0; i < 10; i++ ) {
      if( ( temp[i].suit == temp[i + 1].suit &&
            temp[i].suit == temp[i + 2].suit &&
            temp[i].suit == temp[i + 3].suit ) &&
          ( temp[i].rank.index + 1 == temp[i + 1].rank.index &&
            temp[i].rank.index + 2 == temp[i + 2].rank.index &&
            temp[i].rank.index + 3 == temp[i + 3].rank.index ) ) {
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
    hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
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
            onPressed: () => Navigator.of(context).push( MaterialPageRoute (builder: (context) => Tutorial() ) ),
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
              Text( "Seed: $seed" ),
              Text( "Threshold: $threshold" )
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
                      hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
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
                        points += card.val;
                      }
                      if( points < threshold ) {
                        setState( () => resetGame() );
                      } else {
                        resetDeck();
                        round++;
                        threshold *= 2;
                      }
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
                onPressed: () => setState( () => resetGame() ),
                child: Text( "Reset" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
                  sortedBySuit = false;
                }),
                child: Text( "Sort by rank" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
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
                    PlayingCard("assets/club/cardClubs_2.png", Rank.two, Suit.club, 2),
                    PlayingCard("assets/club/cardClubs_3.png", Rank.three, Suit.club, 3),
                    PlayingCard("assets/club/cardClubs_4.png", Rank.four, Suit.club, 4),
                    PlayingCard("assets/club/cardClubs_5.png", Rank.five, Suit.club, 5),
                    PlayingCard("assets/club/cardClubs_6.png", Rank.six, Suit.club, 6),
                    PlayingCard("assets/club/cardClubs_7.png", Rank.seven, Suit.club, 7),
                    PlayingCard("assets/club/cardClubs_8.png", Rank.eight, Suit.club, 8),
                    PlayingCard("assets/club/cardClubs_9.png", Rank.nine, Suit.club, 9),
                    PlayingCard("assets/club/cardClubs_10.png", Rank.ten, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_J.png", Rank.jack, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_Q.png", Rank.queen, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_K.png", Rank.king, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_A.png", Rank.ace, Suit.club, 11),
                  ];
                  validHand = isHandValid();
                }),
                child: Text( "All clubs" )
              ),
              TextButton(
                onPressed: () => setState(() {
                  hand = [
                    PlayingCard("assets/club/cardClubs_J.png", Rank.jack, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_Q.png", Rank.queen, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_K.png", Rank.king, Suit.club, 10),
                    PlayingCard("assets/club/cardClubs_A.png", Rank.ace, Suit.club, 11),
                    PlayingCard("assets/diamond/cardDiamonds_Q.png", Rank.queen, Suit.diamond, 10),
                    PlayingCard("assets/diamond/cardDiamonds_K.png", Rank.king, Suit.diamond, 10),
                    PlayingCard("assets/diamond/cardDiamonds_A.png", Rank.ace, Suit.diamond, 11),
                    PlayingCard("assets/heart/cardHearts_Q.png", Rank.queen, Suit.heart, 10),
                    PlayingCard("assets/heart/cardHearts_K.png", Rank.king, Suit.heart, 10),
                    PlayingCard("assets/heart/cardHearts_A.png", Rank.ace, Suit.heart, 11),
                    PlayingCard("assets/spade/cardSpades_Q.png", Rank.queen, Suit.spade, 10),
                    PlayingCard("assets/spade/cardSpades_K.png", Rank.king, Suit.spade, 10),
                    PlayingCard("assets/spade/cardSpades_A.png", Rank.ace, Suit.spade, 11)
                  ];
                  validHand = isHandValid();
                }),
                child: Text( "Best hand" )
              ),
               TextButton(
                onPressed: () => setState(() {
                  hand = [
                    PlayingCard("assets/club/cardClubs_2.png", Rank.two, Suit.club, 2),
                    PlayingCard("assets/club/cardClubs_3.png", Rank.three, Suit.club, 3),
                    PlayingCard("assets/club/cardClubs_4.png", Rank.four, Suit.club, 4),
                    PlayingCard("assets/club/cardClubs_5.png", Rank.five, Suit.club, 5),
                    PlayingCard("assets/diamond/cardDiamonds_2.png", Rank.two, Suit.diamond, 2),
                    PlayingCard("assets/diamond/cardDiamonds_3.png", Rank.three, Suit.diamond, 3),
                    PlayingCard("assets/diamond/cardDiamonds_4.png", Rank.four, Suit.diamond, 4),
                    PlayingCard("assets/heart/cardHearts_2.png", Rank.two, Suit.heart, 2),
                    PlayingCard("assets/heart/cardHearts_3.png", Rank.three, Suit.heart, 3),
                    PlayingCard("assets/heart/cardHearts_4.png", Rank.four, Suit.heart, 4),
                    PlayingCard("assets/spade/cardSpades_2.png", Rank.two, Suit.spade, 2),
                    PlayingCard("assets/spade/cardSpades_3.png", Rank.three, Suit.spade, 3),
                    PlayingCard("assets/spade/cardSpades_4.png", Rank.four, Suit.spade, 4),
                  ];
                  validHand = isHandValid();
                }),
                child: Text( "Worst hand" )
              )
            ],
          )
        ],
      )
    );
  }
}