import 'package:flutter/material.dart';

import 'objects/cards.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int curr = 13;
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
  ];
  int deckSize = 52;
  late List<PlayingCard> hand;
  final handSize = 13;
  final offset = -50.0;
  int round = 1;
  int score = 0;
  Set<PlayingCard> selected = {};

  @override
  void initState() {
    deck.shuffle();
    hand = deck.sublist(0, handSize);
    
    super.initState();
  }

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text( "Cards remaining: ${deck.length - curr}/52" ),
                Text( "Round: $round" ),
                Text( "Score: $score" ),
              ]
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Transform.translate(
                        offset: Offset( 0, selected.contains(card) ? offset : 0 ),
                        child: Image.network( card.face, fit: BoxFit.contain )
                      )
                    )
                  )
                ).toList()
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => setState(() {
                      if( deckSize - curr < selected.length ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            action: SnackBarAction( label: "OK", onPressed: () {} ),
                            content: Text( "Not enough cards remaining in deck" )
                          )
                        );
                      } else {
                        for( PlayingCard card in selected ) {
                          hand.remove(card);
                        }
                        while( hand.length < handSize ) {
                          hand.add( deck[curr] );
                          curr++;
                        }
                        selected.clear();
                      }
                    }),
                    child: Text( "Discard" )
                  ),
                  TextButton(
                    onPressed: () => setState(() => hand.sort((a, b) => a.rank.compareTo(b.rank))),
                    child: Text( "Sort by rank" )
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      hand.sort((a, b) => a.rank.compareTo(b.rank));
                      hand.sort((a, b) => a.suit.index.compareTo(b.suit.index));
                    }),
                    child: Text( "Sort by suit" )
                  )
                ]
              )
            ],
          )
        ],
      )
    );
  }
}