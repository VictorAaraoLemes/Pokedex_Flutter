import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/routes/app_routes.dart';
import 'package:pokedex/views/pokemon_form.dart';
import 'package:pokedex/views/pokemons_list.dart';
import 'package:provider/provider.dart';

class PokemonShow extends StatelessWidget {
  const PokemonShow({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PokemonShowArguments;
    Pokemon pokemon = args.pokemon;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Pokedex"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: NetworkImage(pokemon.imageUrl), width: 256, height: 256),
          const SizedBox(height: 8),
          Text(pokemon.name),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tipo: ${pokemon.type}"),
              const SizedBox(width: 32),
              Text("Poder: ${pokemon.power}"),
            ],
          ),
          const SizedBox(height: 12),
          Text(pokemon.description),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => _handleEditPokemon(context, pokemon), 
                child: const Text("Editar")
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: () => _handleDeletePokemon(context, pokemon), 
                child: const Text("Excluir")
              )            
            ],
          )
        ],
      ),
    );
  }

  void _handleEditPokemon(BuildContext context, Pokemon pokemon) {
    Navigator.pushNamed(
      context, 
      AppRoutes.FORM,
      arguments: PokemonFormArguments(pokemon)
    );
  }

  void _handleDeletePokemon(BuildContext context, Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Pokemon'),
        content: const Text('Tem certeza?'),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            child: const Text('Não'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Sim'),
            onPressed: () {
              Provider.of<Pokemons>(context, listen: false).remove(pokemon);
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const PokemonsList(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class PokemonShowArguments {
  final Pokemon pokemon;

  PokemonShowArguments(this.pokemon);
}