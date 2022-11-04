import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zataca/bloc/liked/liked_cubit.dart';
import 'package:flutter_zataca/bloc/registers/cubit/registers_cubit.dart';
import 'package:flutter_zataca/screens/data_list_screen.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final likedCubit = context.read<LikedCubit>();
    final registersCubit = context.read<RegistersCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba nivel flutter Zataca',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16
          ),
        ),
        actions: [ 
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4)
            ),
            
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    height: 256,
                    child: ListView(
                      padding: const EdgeInsets.only(top: 30),
                      children: [
                        ListTile(
                          leading: const Icon(Icons.folder),
                          title: const Text('Opción 1'),
                          onTap:() {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text('Opción 2'),
                          onTap:() {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.remove_circle_outline),
                          title: const Text('Opción 3'),
                          onTap:() {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.priority_high),
                          title: const Text('Opción 4'),
                          onTap:() {},
                        ),
                      ],
                    ),
                  );
                },
              );
              },
              icon: const Icon(Icons.settings),
            ),
        ),
          )],
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            const Image(
              image: AssetImage('assets/lake.jpg'),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocBuilder<LikedCubit, LikedState>(
                  builder: ( _ , state) {
                    return changeButton(likedCubit);
                  },
                ),
                const SizedBox(width: 20),
                const Text('Me gusta')
              ]
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(
                    color: Colors.grey,                
                  ),
                  Row(
                    children: [
                      Text('Primera parte', style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),

                  const Text('Vamos a mostrar dos tabs, que a su vez mostrarán información diferente en su interior'),

                  const SizedBox(height: 15),

                  const MyTabs(),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Text('Segunda parte', style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text('Aquí vamos a mostrar una tabla. Debes de intentar dejarlo lo mas parecido posible, al igual que hacerla dinámica.'),
                  const SizedBox(height: 15),
                  MyTable(),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      registersCubit.loadRegisters();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DataListScreen()));
                    },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return Colors.blue;
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      return Colors.white;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                    )
                   ),
                    child: const Text('Ir a la siguiente vista'),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  Row changeButton(LikedCubit likedCubit) {
    return Row(
      children: [
        IconButton(
          onPressed: (){
            likedCubit.changeState();
          },
          icon: likedCubit.icon,
        ),
        Text(likedCubit.count)
      ],
    );
  }
}

class MyTable extends StatelessWidget {
  MyTable({
    Key? key,
  }) : super(key: key);

  final List<Map<String, String>> myList = [

    {"Tipo": "Consumos",  "Fecha": "23/10/2020 13:21", "Estado": "Available"},
    {"Tipo": "Consumos",  "Fecha": "19/10/2020 10:20", "Estado": "Available"},
    {"Tipo": "Potencias", "Fecha": "05/02/2020 20:35", "Estado": "Unavailable"},
    {"Tipo": "Datos",     "Fecha": "23/10/2020 23:40", "Estado": "Available"},
    {"Tipo": "Consumos",  "Fecha": "23/10/2020 08:23", "Estado": "Unavailable"},
    {"Tipo": "Potencias", "Fecha": "23/10/2020 08:23", "Estado": "Available"},
    {"Tipo": "Potencias", "Fecha": "23/10/2020 08:23", "Estado": "Available"},


  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headingRowColor: MaterialStateProperty.resolveWith((states) {
        return Theme.of(context).primaryColor;
      }),
      dataRowColor: MaterialStateProperty.resolveWith((states) {
        return Colors.grey[200];
      }),
      columns:  const [
        DataColumn(label: Text('Tipo')),
        DataColumn(label: Text('Fecha')),
        DataColumn(label: Text('Estado')),
      ],
      rows: myList.map(
        ((e) => DataRow(
          cells: <DataCell>[
            DataCell(Text(e["Tipo"]!)),
            DataCell(Text(e["Fecha"]!)),
            e["Estado"] == "Available"
            ? DataCell(Container(height: 14, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),))
            : DataCell(Container(height: 14, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),))             
          ]
        )),
      ).toList()
    );
  }
}

class MyTabs extends StatelessWidget {
  const MyTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  color:  Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                tabs: const [
                  Tab(text: 'Tab 1',),
                  Tab(text: 'Tab 2',)
                ]
              ),
            ),
            const SizedBox(height: 15),
                Container(
                  height: 121,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TabBarView(children: [
                    Text('Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese.\nAlps. Situated 1,578 meters above sea level, it is one of the.\nLarger Alpine Lakes. A gondola ride from Kandersteg, followed by a.'),
                    Text('Vestibulum eu quam nec neque pellentesque efficitur id eget nisl. Proin porta est convallis lacus blandit pretium sed non enim. Maecenas lacinia non orci at aliquam. '),
                ]),
                  ),
                ),
                

          ],
        ),
      );
  }
}