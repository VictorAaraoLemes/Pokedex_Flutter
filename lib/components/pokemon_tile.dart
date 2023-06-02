import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/routes/app_routes.dart';
import 'package:pokedex/views/pokemon_show.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTile(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(image: NetworkImage(pokemon.imageUrl)),
      title: Text(pokemon.name),
      subtitle: Text(pokemon.type),
      trailing: Text(pokemon.power.toString()),
      onTap: () => Navigator.pushNamed(
        context, 
        AppRoutes.SHOW, 
        arguments: PokemonShowArguments(pokemon)
      ),
    );
  }
}