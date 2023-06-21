import 'package:batubara/source/service/Auth/cubit/auth_cubit.dart';
import 'package:batubara/source/service/Auth/cubit/change_pass_cubit.dart';
import 'package:batubara/source/service/Auth/cubit/profile_cubit.dart';
import 'package:batubara/source/service/Batubara/cubit/batubara_cubit.dart';
import 'package:batubara/source/service/Batubara/cubit/history_cubit.dart';
import 'package:batubara/source/service/Batubara/cubit/insert_cubit.dart';
import 'package:batubara/source/network/network.dart';
import 'package:batubara/source/repository/repository.dart';
import 'package:batubara/source/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp(router: RouterNavigation(), myRepository: MyRepository(myNetwork: MyNetwork())));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  const MyApp({super.key, this.router, this.myRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => ChangePassCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => BatubaraCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => InsertCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => HistoryCubit(myRepository: myRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}
