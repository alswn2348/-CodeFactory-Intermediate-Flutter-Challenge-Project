import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;

  final List<Image> images;

  final String email;

  final int rating;

  final String content;

  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.email,
    required this.rating,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Header(
        avatarImage: avatarImage,
        email: email,
        rating: rating,
      ),
      const Body(),
      const Images(),
    ]);
  }
}

class Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;
  const Header({
    super.key,
    required this.avatarImage,
    required this.email,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.0,
          backgroundImage: avatarImage,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        )
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
