import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_bloc.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_state.dart';

class GymMainWidget extends StatelessWidget{
  const GymMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceBloc,PlaceState>(

        listener: (context,state){
          return _gymWidgetBuilder();
        }
    );
  }

  void _gymWidgetBuilder() {}
  
}