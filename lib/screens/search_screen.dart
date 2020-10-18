import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/blocs/city_bloc.dart';
import 'package:olife/events/city_event.dart';
import 'package:olife/states/city_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: _textEditingController,
            )),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //Navigator.pop(context, _textEditingController.text);
                BlocProvider.of<CityBloc>(context).add(
                  CityRequest(city: _textEditingController.text)
                );
              },
            ),
            BlocBuilder<CityBloc, CityState>(
              builder: (context, cityState) {
                if(cityState is CityStateSuccess) {
                  print(cityState.cities);
                } else {
                  print('City Error');
                }
                return Text('');
              },
            )
          ],
        ),
      ),
    );
  }
}
