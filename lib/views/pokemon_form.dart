import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/pokemon.dart';
import 'package:pokedex/views/pokemons_list.dart';
import 'package:provider/provider.dart';


class PokemonForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {
    'id': '',    
    'name': '',
    'description': '',
    'type': '',
    'power': '',
    'imageUrl': '',
  };

  PokemonForm({super.key});

  void _loadFormData(Pokemon pokemon) {
    _formData['id'] = pokemon.id;
    _formData['name'] = pokemon.name;
    _formData['description'] = pokemon.description;
    _formData['type'] = pokemon.type;
    _formData['power'] = pokemon.power;
    _formData['imageUrl'] = pokemon.imageUrl;
  }

  @override
  Widget build(BuildContext context) {    
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && (args as PokemonFormArguments).pokemon != null) {
      Pokemon pokemon = args.pokemon as Pokemon;
      _loadFormData(pokemon);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Pokedex"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'] as String,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido!';
                  }

                  if (value.trim().length <= 3) {
                    return 'Nome muito pequeno. Mínimo de 3 letras.';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value as Object,
              ),
              TextFormField(
                initialValue: _formData['description'] as String,
                decoration: const InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => _formData['description'] = value as Object,
              ),
              TextFormField(
                initialValue: _formData['type'] as String,
                decoration: const InputDecoration(labelText: 'Tipo'),
                onSaved: (value) => _formData['type'] = value as Object,
              ),
              TextFormField(
                initialValue: _formData['power'].toString(),
                decoration: const InputDecoration(labelText: 'Poder'),
                onSaved: (value) => _formData['power'] = value as Object,
              ),
              TextFormField(
                initialValue: _formData['imageUrl'] as String,
                decoration: const InputDecoration(labelText: 'Url da imagem'),
                onSaved: (value) => _formData['imageUrl'] = value as Object,
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: () => _hadleSubmit(context), child: const Text("Salvar"))
            ],
          ),
        ),
      )
    );
  }

  void _hadleSubmit(BuildContext context) {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      Provider.of<Pokemons>(context, listen: false).put(
        Pokemon(
          id: _formData['id'] as String,
          name: _formData['name'] as String,
          description: _formData['description'] as String,
          type: _formData['type'] as String,
          power: num.parse(_formData['power'].toString()),
          imageUrl: _formData['imageUrl'] as String,
        ),
      );
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PokemonsList(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}

class PokemonFormArguments {
  final Pokemon? pokemon;

  PokemonFormArguments(this.pokemon);
}