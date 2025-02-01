import 'package:flutter/material.dart';

enum Suit { club, diamond, heart, spade }

@immutable
class PlayingCard {
  final String face;
  final int rank;
  final Suit suit;

  const PlayingCard( this.face, this.rank, this.suit );
}