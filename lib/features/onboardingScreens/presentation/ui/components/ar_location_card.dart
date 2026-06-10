import 'package:flutter/material.dart';

class ArLocationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double rating;
  final String distance;
  final Color iconColor;

  const ArLocationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.rating,
    required this.distance,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xAA1B1D23),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(.20), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 10,
                        color: index < rating.floor()
                            ? Colors.amber
                            : Colors.white24,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      distance,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
