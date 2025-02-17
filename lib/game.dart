import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'objects/cards.dart';
import 'settings.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.audioPlayer
  });

  final AudioPlayer audioPlayer;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  int cardsUsed = 13;
  final deck = [
    PlayingCard("assets/club/cardClubs_2.png", Rank.two, Suit.club),
    PlayingCard("assets/club/cardClubs_3.png", Rank.three, Suit.club),
    PlayingCard("assets/club/cardClubs_4.png", Rank.four, Suit.club),
    PlayingCard("assets/club/cardClubs_5.png", Rank.five, Suit.club),
    PlayingCard("assets/club/cardClubs_6.png", Rank.six, Suit.club),
    PlayingCard("assets/club/cardClubs_7.png", Rank.seven, Suit.club),
    PlayingCard("assets/club/cardClubs_8.png", Rank.eight, Suit.club),
    PlayingCard("assets/club/cardClubs_9.png", Rank.nine, Suit.club),
    PlayingCard("assets/club/cardClubs_10.png", Rank.ten, Suit.club),
    PlayingCard("assets/club/cardClubs_J.png", Rank.jack, Suit.club),
    PlayingCard("assets/club/cardClubs_Q.png", Rank.queen, Suit.club),
    PlayingCard("assets/club/cardClubs_K.png", Rank.king, Suit.club),
    PlayingCard("assets/club/cardClubs_A.png", Rank.ace, Suit.club),
    PlayingCard("assets/diamond/cardDiamonds_2.png", Rank.two, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_3.png", Rank.three, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_4.png", Rank.four, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_5.png", Rank.five, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_6.png", Rank.six, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_7.png", Rank.seven, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_8.png", Rank.eight, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_9.png", Rank.nine, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_10.png", Rank.ten, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_J.png", Rank.jack, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_Q.png", Rank.queen, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_K.png", Rank.king, Suit.diamond),
    PlayingCard("assets/diamond/cardDiamonds_A.png", Rank.ace, Suit.diamond),
    PlayingCard("assets/heart/cardHearts_2.png", Rank.two, Suit.heart),
    PlayingCard("assets/heart/cardHearts_3.png", Rank.three, Suit.heart),
    PlayingCard("assets/heart/cardHearts_4.png", Rank.four, Suit.heart),
    PlayingCard("assets/heart/cardHearts_5.png", Rank.five, Suit.heart),
    PlayingCard("assets/heart/cardHearts_6.png", Rank.six, Suit.heart),
    PlayingCard("assets/heart/cardHearts_7.png", Rank.seven, Suit.heart),
    PlayingCard("assets/heart/cardHearts_8.png", Rank.eight, Suit.heart),
    PlayingCard("assets/heart/cardHearts_9.png", Rank.nine, Suit.heart),
    PlayingCard("assets/heart/cardHearts_10.png", Rank.ten, Suit.heart),
    PlayingCard("assets/heart/cardHearts_J.png", Rank.jack, Suit.heart),
    PlayingCard("assets/heart/cardHearts_Q.png", Rank.queen, Suit.heart),
    PlayingCard("assets/heart/cardHearts_K.png", Rank.king, Suit.heart),
    PlayingCard("assets/heart/cardHearts_A.png", Rank.ace, Suit.heart),
    PlayingCard("assets/spade/cardSpades_2.png", Rank.two, Suit.spade),
    PlayingCard("assets/spade/cardSpades_3.png", Rank.three, Suit.spade),
    PlayingCard("assets/spade/cardSpades_4.png", Rank.four, Suit.spade),
    PlayingCard("assets/spade/cardSpades_5.png", Rank.five, Suit.spade),
    PlayingCard("assets/spade/cardSpades_6.png", Rank.six, Suit.spade),
    PlayingCard("assets/spade/cardSpades_7.png", Rank.seven, Suit.spade),
    PlayingCard("assets/spade/cardSpades_8.png", Rank.eight, Suit.spade),
    PlayingCard("assets/spade/cardSpades_9.png", Rank.nine, Suit.spade),
    PlayingCard("assets/spade/cardSpades_10.png", Rank.ten, Suit.spade),
    PlayingCard("assets/spade/cardSpades_J.png", Rank.jack, Suit.spade),
    PlayingCard("assets/spade/cardSpades_Q.png", Rank.queen, Suit.spade),
    PlayingCard("assets/spade/cardSpades_K.png", Rank.king, Suit.spade),
    PlayingCard("assets/spade/cardSpades_A.png", Rank.ace, Suit.spade)
  ];
  final deckSize = 52;
  late List<PlayingCard> hand;
  final handSize = 13;
  PlayingCard? selected;
  bool sortedByRank = true;
  late bool validHand;

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
    List<Set<PlayingCard>> k3 = threes.keys.toList(), k4 = fours.keys.toList();
    List<Set<PlayingCard>> curr = [];

    for( int a = 0; a < k4.length; a++ ) {
      curr.add(k4[a]);

      for( int i = 0; i < k3.length; i++ ) {
        if( !curr.any( (card) => card.any( k3[i].contains ) ) ) {
          curr.add( k3[i] );

          for( int j = i + 1; j < k3.length; j++ ) {
            if( !curr.any( (card) => card.any( k3[j].contains ) ) ) {
              curr.add( k3[j] );

              for( int k = j + 1; k < k3.length; k++ ) {
                if( !curr.any( (card) => card.any( k3[k].contains ) ) ) {
                  curr.add( k3[k] );
                  if( curr.any( (card) => ( threes[card] ?? false ) ||
                                          ( fours[card] ?? false ) ) ) {
                    return true;
                  }
                  curr.remove( k3[k] );
                }
              }
              curr.remove( k3[j] );
            }
          }
          curr.remove( k3[i] );
        }
      }
      curr.remove(k4[a]);
    }

    return false;
  }

  void resetGame() {
    setState(() {
      cardsUsed = 13;
      deck.shuffle();
      hand = deck.sublist(0, handSize);
      sortedByRank ? sortByRank() : sortBySuit();
      selected = null;
      validHand = isHandValid();
    });
  }

  void sortByRank() {
    setState(() {
      hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
      sortedByRank = true;
    });
  }

  void sortBySuit() {
    setState(() {
      hand.sort((a, b) => a.rank.index.compareTo(b.rank.index));
      hand.sort((a, b) => a.suit.index.compareTo(b.suit.index));
      sortedByRank = false;
    });
  }

  @override
  void initState() {
    super.initState();

    deck.shuffle();
    hand = deck.sublist(0, handSize);
    sortByRank();
    validHand = isHandValid();
  }

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Settings(
                  audioPlayer: widget.audioPlayer 
                )
              )
            ),
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
              GestureDetector(
                onTap: () {
                  if( cardsUsed == 52 ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction( label: "OK", onPressed: () {} ),
                        behavior: SnackBarBehavior.floating,
                        content: Text( "No more cards remaining in deck" )
                      )
                    );
                  } else {
                    setState( () => cardsUsed++ );
                  }
                },
                child: Image.network(
                  "assets/cardBackRed.png",
                  width: MediaQuery.of(context).size.width / (handSize + 1)
                ),
              ),
              Text( "Cards remaining: ${deckSize - cardsUsed}/52" ),
              GestureDetector(
                onTap: () {
                  if( selected == null || cardsUsed == 52 ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction( label: "OK", onPressed: () {} ),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                            selected == null ?
                            "Please select a card to discard" :
                            "No more cards remaining in deck"
                          )
                      )
                    );
                  } else {
                    setState(() {
                      hand.remove(selected);
                      hand.add( deck[cardsUsed] );
                      cardsUsed++;
                      sortedByRank ? sortByRank() : sortBySuit();
                      selected = null;
                      validHand = isHandValid();
                    });
                  }
                },
                child: Image.network(
                  cardsUsed == 52 ? "assets/cardBackRed.png" : deck[cardsUsed].face,
                  width: MediaQuery.of(context).size.width / (handSize + 1)
                ),
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: hand.map(
              (card) => GestureDetector(
                onTap: () => setState( () =>
                  card == selected ?
                  selected = null :
                  selected = card
                ),
                child: Stack(
                  children: [
                    Image.network(
                      card.face,
                      width: MediaQuery.of(context).size.width / (handSize + 1)
                    ),
                    if( selected == card )
                      Positioned.fill(
                        child: Container(
                          color: Colors.blue.withAlpha(100)
                        )
                      )
                  ]
                )
              )
            ).toList()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if( validHand ) {
                    showDialog(
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              resetGame();
                            },
                            child: Text( "New Game" )
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text( "Main Menu" )
                          )
                        ],
                        title: Text( "You win!" ),
                      ),
                      context: context
                    );
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
                onPressed: () => resetGame(),
                child: Text( "Reset" )
              ),
              TextButton(
                onPressed: () => sortByRank(),
                child: Text( "Sort by rank" )
              ),
              TextButton(
                onPressed: () => sortBySuit(),
                child: Text( "Sort by suit" )
              )
            ]
          )
        ]
      )
    );
  }
}