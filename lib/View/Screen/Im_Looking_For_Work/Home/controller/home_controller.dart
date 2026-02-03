import 'package:flutter/material.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();

  // Mock Data for Job Recommendations
  final jobRecommendations = <Map<String, dynamic>>[
    {
      "role": "Senior Hair Stylist",
      "company": "Glow Beauty Salon",
      "tags": ["Full-time", "Tuesday - Saturday", "Commission on retail"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image": "assets/images/stylist.png", // Placeholder
    },
    {
      "role": "Master Barber",
      "company": "The Grooming Room",
      "tags": ["Full-time", "Tuesday - Sunday", "Tips"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image": "assets/images/barber.png",
    },
    {
      "role": "Nail Technician",
      "company": "Luxe Nails & Spa",
      "tags": ["Part-time", "Saturday & Sunday", "Tips"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image": "assets/images/nail.png",
    },
    {
      "role": "Lead Makeup Artist",
      "company": "Bella Beauty Studio",
      "tags": ["Full-time", "Event-based", "High-end clientele"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image": "assets/images/makeup.png",
    },
  ].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
