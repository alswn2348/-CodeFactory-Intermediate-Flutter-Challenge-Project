import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

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
    return Column(
      children: [
        Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Body(content: content),
        if (images.isNotEmpty)
          Images(
            images: images,
          ),
      ],
    );
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
  final String content;

  const Body({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        content,
        style: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class Images extends StatelessWidget {
  final List<Image> images;

  const Images({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        children: images
            .mapIndexed(
              (index, e) => Padding(
                padding: EdgeInsets.only(
                  right: index == images.length - 1 ? 0 : 16.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: e,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
