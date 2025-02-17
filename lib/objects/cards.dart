import 'package:flutter/material.dart';

enum Rank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace
}

enum Suit {
  club,
  diamond,
  heart,
  spade
}

@immutable
class PlayingCard {
  final String face;
  final Rank rank;
  final Suit suit;

  const PlayingCard( this.face, this.rank, this.suit );

  factory PlayingCard.fromMap( Map<String, dynamic> data ) {
    return PlayingCard( data["face"], data["rank"], data["suit"] );
  }

  Map<String, dynamic> toMap() {
    return { "face": face, "rank": rank, "suit": suit };
  }

  @override
  toString() {
    return "Card( $rank, $suit )";
  }
}