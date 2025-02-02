import 'package:flutter/material.dart';

@immutable
class Power {
  final String description;
  final Function function;
  final String name;

  const Power( this.description, this.function, this.name );

  @override
  toString() {
    return "Booster( $name, $description )";
  }
}