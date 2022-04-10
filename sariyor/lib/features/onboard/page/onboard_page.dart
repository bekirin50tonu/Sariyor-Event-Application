import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardPage extends StatefulWidget {
  OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final PageController _pageController = PageController();

  int selected_page = 0;

  int max_page_count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0x884E5559),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                selected_page = index;
                setState(() {});
              },
              children: [
                buildOnBoardWidget(
                    context: context,
                    title: "deneme",
                    description: 'bu bir denemedir',
                    image: Image.network(
                        'https://th.bing.com/th/id/R.42a29273028ae415497c84dc190b493d?rik=CMn4NrId59NoqQ&pid=ImgRaw&r=0'),
                    buttonText: 'İleri'),
                buildOnBoardWidget(
                    context: context,
                    title: "deneme",
                    description: 'bu bir denemedir',
                    image: Image.network(
                        'https://th.bing.com/th/id/R.42a29273028ae415497c84dc190b493d?rik=CMn4NrId59NoqQ&pid=ImgRaw&r=0'),
                    buttonText: 'İleri'),
                buildOnBoardWidget(
                    context: context,
                    title: "deneme",
                    description: 'bu bir denemedir',
                    image: Image.network(
                        'https://th.bing.com/th/id/R.42a29273028ae415497c84dc190b493d?rik=CMn4NrId59NoqQ&pid=ImgRaw&r=0'),
                    buttonText: 'İleri'),
                buildOnBoardWidget(
                    context: context,
                    title: "deneme",
                    description: 'bu bir denemedir',
                    image: Image.network(
                        'https://th.bing.com/th/id/R.42a29273028ae415497c84dc190b493d?rik=CMn4NrId59NoqQ&pid=ImgRaw&r=0'),
                    buttonText: 'İleri'),
                buildOnBoardWidget(
                    context: context,
                    title: "deneme",
                    description: 'bu bir denemedir',
                    image: Image.network(
                        'https://th.bing.com/th/id/R.42a29273028ae415497c84dc190b493d?rik=CMn4NrId59NoqQ&pid=ImgRaw&r=0'),
                    buttonText: 'Hesap Oluştur'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffff00ff),
                        ),
                        onPressed: () {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        },
                        child: const Text("Geri")),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: SmoothPageIndicator(
                        controller: _pageController,
                        count: max_page_count,
                        effect: const WormEffect(),
                        onDotClicked: (index) => _pageController.animateTo(
                            index.toDouble(),
                            duration: const Duration(microseconds: 500),
                            curve: Curves.bounceOut),
                      )),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffff00ff),
                        ),
                        onPressed: () {
                          if (selected_page == max_page_count - 1) {
                          } else {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                            log(selected_page.toString());
                          }
                        },
                        child: selected_page == max_page_count - 1
                            ? const Text("Başlayalım")
                            : const Text('İleri')),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardWidget(
      {required BuildContext context,
      required Image image,
      required String title,
      required String description,
      required String buttonText,
      Function? callback}) {
    return Column(children: [
      const Spacer(
        flex: 1,
      ),
      Expanded(
        child: image,
        flex: 5,
      ),
      const Spacer(
        flex: 1,
      ),
      Center(
        child: Text(
          title,
          style: TextStyle(
              color: const Color(0xffC2CACE),
              fontSize: Theme.of(context).textTheme.headline4!.fontSize),
        ),
      ),
      const Spacer(
        flex: 1,
      ),
      Flexible(
          child: Text(
        description,
        style: TextStyle(
            color: const Color(0xffC2CACE),
            fontSize: Theme.of(context).textTheme.headline6!.fontSize),
      )),
      const Spacer(
        flex: 2,
      ),
    ]);
  }
}
