import 'package:flutter/material.dart';
import 'package:pokedex/components/pokemon_tile.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/routes/app_routes.dart';
import 'package:provider/provider.dart';

class PokemonsList extends StatelessWidget {
  const PokemonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pokemons pokemons = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Image.asset(
                "../Assets/pokebola.png",
                width: 40,
              ),
            ),
            Text(
              'Pokedex',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16), // Distância vertical entre os containers
        child: ListView.separated(
          itemCount: pokemons.count,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(index),
            ),
            child: PokemonTile(pokemons.getByIndex(index)),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 8),
        ),
      ),
      floatingActionButton: ClipOval( // Adicionando o widget ClipOval para deixar o botão redondo
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.FORM,
          ),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 233, 174, 85), // Altere a cor aqui
        ),
      ),
    );
  }

  Color _getBackgroundColor(int index) {
    List<Color> colors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
    return colors[index % colors.length];
  }
}
