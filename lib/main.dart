import 'package:flutter/material.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/routes/app_routes.dart';
import 'package:pokedex/views/pokemon_form.dart';
import 'package:pokedex/views/pokemon_show.dart';
import 'package:pokedex/views/pokemons_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Pokemons(),
        ),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xffDFA753),
            background: const Color(0xffD9D9D9),
          ),
          useMaterial3: true,
        ),
       debugShowCheckedModeBanner: false, // Adicionando o parâmetro aqui
        routes: {
          AppRoutes.HOME: (context) => const PokemonsList(),
          AppRoutes.SHOW: (context) => const PokemonShow(),
          AppRoutes.FORM: (context) => PokemonForm(),
        },
      ),
    );
  }
}
