import 'package:flutter/material.dart';

enum Rank { two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace }

enum Suit { club, diamond, heart, spade }

@immutable
class PlayingCard {
  final String face;
  final Rank rank;
  final Suit suit;
  final int val;

  const PlayingCard( this.face, this.rank, this.suit, this.val );

  @override
  toString() {
    return "Card( $rank, $suit )";
  }
}