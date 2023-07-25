import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Area do Aluno',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Center(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              // Swipe to the right
              _cardKey.currentState!.toggleCard();
            } else if (details.delta.dx < 0) {
              // Swipe to the left
              _cardKey.currentState!.toggleCard();
            }
          },
          child: FlipCard(
            key: _cardKey,
            direction: FlipDirection.HORIZONTAL,
            front: const CardFront(),
            back: const CardBack(),
          ),
        ),
      ),
    );
  }
}

class CardFront extends StatelessWidget {
  const CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Front Side',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Back Side',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
