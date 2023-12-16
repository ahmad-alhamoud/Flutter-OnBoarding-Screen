import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final pageController = PageController();

  final selectedIndex = ValueNotifier(0);

  final illustrations = [
    'assets/Animation1.json',
    'assets/Animation2.json',
    'assets/Animation3.json',
  ];

  final titles = [
    'Easy Market Search',
    'Professional Reviewer',
    'Find ideal Idea',
  ];
  final descs = [
    'Search for new markets and hungry for new  ideas, opportunity and excitement.',
    'try our services we will provide you our best analysis research for free',
    '20 years of experience with this ',
  ];

  @override
  Widget build(BuildContext context) {
    print("WE ARE BUILDING HERE");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) {
                    selectedIndex.value = value;
                  },
                  itemCount: illustrations.length,
                  itemBuilder: (context, index) {
                    return _PageLayout(
                        illustration: illustrations[index],
                        title: titles[index],
                        desc: descs[index]);
                  }),
            ),
            ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, index, child) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 32,
                    ),
                    child: Wrap(
                      spacing: 8,
                      children:
                          List.generate(illustrations.length, (indexIndicator) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 8,
                          width: indexIndicator == index ? 34 : 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: indexIndicator == index
                                  ? Colors.green
                                  : Colors.green.withOpacity(0.5)),
                        );
                      }),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ValueListenableBuilder(
                  valueListenable: selectedIndex,
                  builder: (context, index, child) {
                    if (index == illustrations.length - 1) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Get Started",
                          ),
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          pageController.jumpToPage(illustrations.length-1) ;
                        },
                            child: const  Text(
                                'Skip' ,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                            ),
                            )
                        ) ,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            final nextPage = selectedIndex.value + 1 ;
                            pageController.animateToPage(
                                nextPage,
                                duration: const Duration(milliseconds: 200),
                             curve: Curves.ease
                            );
                          },
                          child: const Text(
                            "Next",
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _PageLayout extends StatelessWidget {
  final String illustration;
  final String title;
  final String desc;

  const _PageLayout(
      {Key? key,
      required this.illustration,
      required this.title,
      required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset(illustration, fit: BoxFit.contain),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            desc,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
