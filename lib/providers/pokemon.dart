import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokedex/data/dummy_pokemons.dart';
import 'package:pokedex/models/pokemon.dart';

class Pokemons extends ChangeNotifier {
  final Map<String, Pokemon> _items = {...DUMMY_POKEMONS};

  List<Pokemon> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Pokemon getByIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Pokemon pokemon) {
    final id = count.toString();

    if (pokemon.id.trim().isNotEmpty && _items.containsKey(pokemon.id)) {
      _items.update(pokemon.id, 
        (_) => Pokemon(
          id: pokemon.id,
          name: pokemon.name,
          description: pokemon.description,
          type: pokemon.type,
          imageUrl: pokemon.imageUrl,
          power: pokemon.power,
        )
      );
    } else {
      _items.putIfAbsent(id,
        () => Pokemon(
          id: id,
          name: pokemon.name,
          description: pokemon.description,
          type: pokemon.type,
          imageUrl: pokemon.imageUrl,
          power: pokemon.power,
        )
      );
    }

    notifyListeners();
  }

  void remove(Pokemon pokemon) {
    if (pokemon.id.trim().isNotEmpty) {
      _items.remove(pokemon.id);
      sleep(const Duration(milliseconds: 500));
      notifyListeners();
    }
  }
}