import 'package:demo_flutter/bloc/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    // final counter = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cubit Demo')),
      floatingActionButton: Column(
        mainAxisAlignment: .end,
        spacing: 8,
        children: [
          FloatingActionButton(onPressed: () => context.read<CounterCubit>().increment(), //counter.increment(),
            child: Icon(Icons.add),),
          FloatingActionButton(onPressed: () => context.read<CounterCubit>().decrement(),//counter.decrement(),
            child: Icon(Icons.horizontal_rule),),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CounterCubit,int>(
          builder: (context, count) {
            return Center(child: Text('counter $count'));
          },
        ),
      ),
    );
  }
}
