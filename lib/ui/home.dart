import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> funcionarios = [];
  int indice = 0;

  @override
  void initState() {
    super.initState();
    carregarMockupJSON();
  }

  Future<void> carregarMockupJSON() async {
    String dados =
        await rootBundle.loadString('assets/mockup/funcionarios.json');

    setState(() {
      funcionarios = json.decode(dados);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Funcionários")),

      body: funcionarios.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF008080),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF20B2AA),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<dynamic>(
                      borderRadius: BorderRadius.circular(8),
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      value: funcionarios[indice],
                      items: funcionarios
                          .map(
                            (f) => DropdownMenuItem<dynamic>(
                              value: f,
                              child: Text(f['nome']),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          indice = funcionarios.indexOf(value);
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    funcionarios[indice]['nome'],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF20B2AA),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                funcionarios[indice]['avatar'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(funcionarios[indice]['cargo']),

                          const SizedBox(height: 10),

                          Text(
                            "R\$ ${funcionarios[indice]['salario'].toStringAsFixed(2).replaceAll('.', ',')}",
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Admissão: ${funcionarios[indice]['dataContratacao']}",
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: indice > 0
                            ? () => setState(() {
                                  indice--;
                                })
                            : null,
                        child: const Text("Anterior"),
                      ),
                      ElevatedButton(
                        onPressed: indice < funcionarios.length - 1
                            ? () => setState(() {
                                  indice++;
                                })
                            : null,
                        child: const Text("Próximo"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}