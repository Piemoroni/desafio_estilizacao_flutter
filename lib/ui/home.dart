import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List funcionarios = [];
  int index = 0;
  String filtroCargo = "Todos";

  @override
  void initState() {
    super.initState();
    carregarJson();
  }

  Future<void> carregarJson() async {
    String data = await rootBundle.loadString('assets/mockup/funcionarios.json');
    setState(() {
      funcionarios = json.decode(data);
    });
  }

  List get listaFiltrada {
    if (filtroCargo == "Todos") return funcionarios;
    return funcionarios.where((f) => f["cargo"] == filtroCargo).toList();
  }

  @override
  Widget build(BuildContext context) {

    if (funcionarios.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var lista = listaFiltrada;
    var f = lista[index % lista.length];

    List cargos = ["Todos", ...{for (var f in funcionarios) f["cargo"]}];

    return Scaffold(
      appBar: AppBar(title: const Text("Funcionários")),

      body: Column(
        children: [

          const SizedBox(height: 10),

          DropdownButton(
            value: filtroCargo,
            items: cargos.map<DropdownMenuItem<String>>((c) {
              return DropdownMenuItem(value: c, child: Text(c));
            }).toList(),
            onChanged: (value) {
              setState(() {
                filtroCargo = value!;
                index = 0;
              });
            },
          ),

          Expanded(
            child: Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(blurRadius: 8, color: Colors.black12)
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(f["avatar"]),
                    ),

                    const SizedBox(height: 10),

                    Text(f["nome"],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),

                    Text(f["cargo"]),
                    Text("R\$ ${f["salario"]}"),
                    Text("Admissão: ${f["dataContratacao"]}"),
                  ],
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    index--;
                  });
                },
                child: const Text("Anterior"),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    index++;
                  });
                },
                child: const Text("Próximo"),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}