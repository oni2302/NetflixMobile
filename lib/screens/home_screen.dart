import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:netflix_mobile/cubits/cubits.dart';
import 'package:netflix_mobile/data/data.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
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
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        floatingActionButton: !Responsive.isDesktop(context)
            ? FloatingActionButton(
                onPressed: () => print('cast'),
                child: const Icon(
                  Icons.cast,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey[700],
              )
            : null,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50.0),
          child: BlocBuilder<AppBarCubit, double>(
            builder: (context, scrollOffset) {
              return CustomAppBar(
                scrollOffset: scrollOffset,
              );
            },
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
                child: ContentHeader(
              featuredContent: sintelContent,
            )),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              sliver: SliverToBoxAdapter(
                  key: PageStorageKey('previews'),
                  child: Preview(
                    title: "Previews",
                    contentList: previews,
                  )),
            ),
            SliverToBoxAdapter(
              key: PageStorageKey('liked'),
              child: ContentList(
                title: 'Yêu thích',
                contentList: myList,
              ),
            ),
            SliverToBoxAdapter(
              key: PageStorageKey('originals'),
              child: ContentList(
                title: 'Netflix Originals',
                contentList: myList,
                isOriginal: true,
              ),
            ),
            SliverPadding(
              key: PageStorageKey('trending'),
              padding: const EdgeInsets.only(bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: ContentList(
                  title: 'Thịnh hành',
                  contentList: myList,
                ),
              ),
            ),
          ],
        ));
  }
}
