import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zataca/bloc/registers/cubit/registers_cubit.dart';
import 'package:flutter_zataca/main.dart';
import 'package:flutter_zataca/models/myRegister.dart';
import 'package:flutter_zataca/services/petitions.dart';

class DataListScreen extends StatelessWidget {
   
  DataListScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text('Prueba nivel flutter Zataca',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0.2,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                Text('Listado de post', style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )),
                const Text('Vamos a mostrar los primeros 20 resultados que nos devuelve la petición:\nhttps://jsonplaceholder.typicode.com/posts?_start=0&_limit=20'),
                const Divider(color: Colors.grey,),
                BlocBuilder<RegistersCubit, RegistersState>(
                  
                  builder: ( _ , state) {
                    if (state is RegistersLoaded){
                      return _RegistersList(myRegisters: state.myRegisters);
                    } else{
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
               ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegistersList extends StatelessWidget {
  final Future<List<MyRegister>?> myRegisters;
  
  const _RegistersList({required this.myRegisters});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<MyRegister>?>(
          future: myRegisters,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text('Ha ocurrido un error'),);
            } else if (snapshot.hasData){
                return _RegisterRow(listRegister: snapshot.data!);
            }else{
              return const Center(child: CircularProgressIndicator());
            }

          },
        )
      ],
    );
  }
}

class _RegisterRow extends StatelessWidget {
  final List<MyRegister> listRegister;
  const _RegisterRow({required this.listRegister,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listRegister.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listRegister[index].id.toString() + " " + listRegister[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Text(listRegister[index].body),
              const SizedBox(height: 15),

            ],
          );
        },
      );
    
  }
}