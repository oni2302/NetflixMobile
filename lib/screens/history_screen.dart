import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_mobile/cubits/appbar/app_bar_cubit.dart';
import 'package:netflix_mobile/data/api.dart';
import 'package:netflix_mobile/models/content_model.dart';
import 'package:netflix_mobile/models/user_singleton.dart';
import 'package:netflix_mobile/widgets/content_list.dart';
import 'package:netflix_mobile/widgets/history_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late ScrollController _scrollController;
  late int id;
  @override
  void initState() {
    id = CurrentUser().getInstance.get('user')!.id;
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              key: PageStorageKey('history'),
              child: FutureBuilder<List<Content>>(
                future: API.getHistory(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final list = snapshot.data;
                    return HistoryList(
                      title: 'Lịch sử',
                      contentList: list!,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
