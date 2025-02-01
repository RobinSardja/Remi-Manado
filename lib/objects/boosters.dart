import 'package:flutter/material.dart';

enum Rarity { common, legendary, mythical, forbidden }

@immutable
class Booster {
  final int cost;
  final String description;
  final Function function;
  final String name;
  final Rarity rarity;

  const Booster( this.cost, this.description, this.function, this.name, this.rarity );

  @override
  toString() {
    return "Booster( $name, $description )";
  }
}