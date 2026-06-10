import 'package:flutter/material.dart';

class SearchSample extends StatelessWidget {
  final String query;
  final String result;

  const SearchSample({
    super.key,
    required this.query,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1F24).withAlpha(175),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withAlpha(112),
            ),
          ),

          child: Row(
            children: [

              const Icon(
                Icons.search_rounded,
                color: Colors.white70,
                size: 22,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  query,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.white70,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),

          decoration: BoxDecoration(
            color: const Color(0xFF0B2515),
            borderRadius: BorderRadius.circular(20),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Icon(
                Icons.check_circle,
                color: Color(0xFF00C853),
                size: 14,
              ),

              const SizedBox(width: 6),

              Text(
                result,
                style: const TextStyle(
                  color: Color(0xFF00E676),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}