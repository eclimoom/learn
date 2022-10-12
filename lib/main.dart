import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "M2",
        theme: ThemeData(
            primarySwatch: Colors.blue, splashColor: Colors.transparent),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('index'),
        ),
        body: const HomeContent());
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: StarRating(rating: 3));
  }
}

class StarRating extends StatefulWidget {
  final double rating;
  final double maxRating;
  final double size;
  final int count;
  final Color selectedColor;
  final Color unSelectedColor;

  const StarRating(
      {super.key,
      this.rating = 0,
      this.maxRating = 10,
      this.selectedColor = Colors.yellow,
      this.unSelectedColor = Colors.grey,
      this.size = 50,
      this.count = 5});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min, children: buildUnselectedStar(),
        ),
        Row(mainAxisSize: MainAxisSize.min, children: buildSelectedStar()),
      ],
    );
  }

  List<Widget> buildSelectedStar() {
    List<Widget> stars = [];
    // 1. create star
    final star =
        Icon(Icons.star, color: widget.selectedColor, size: widget.size);
    double oneValue = widget.maxRating / widget.count;
    // 2. 选中star
    int filled = (widget.rating / oneValue).floor();
    for (var i = 0; i < filled; i++) {
      stars.add(star);
    }
    // 3. part star
    final double partWidth = widget.rating % oneValue / oneValue * widget.size;
    final partStar = ClipRect(
      clipper: StarClipper(partWidth),
      child: star,
    );
    stars.add(partStar);

    return stars;
  }

  List<Widget> buildUnselectedStar() {
    return List.generate(
        widget.count,
        (index) => Icon(Icons.star_border,
            color: widget.unSelectedColor, size: widget.size));
  }
}


class StarClipper extends CustomClipper<Rect> {
  double width;
  StarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0,  width, size.height);
  }

  @override
  bool shouldReclip(StarClipper oldClipper) {
    // throw UnimplementedError();
    return oldClipper.width != width;
  }

}