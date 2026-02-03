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
      "image":
          "https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80",
    },
    {
      "role": "Master Barber",
      "company": "The Grooming Room",
      "tags": ["Full-time", "Tuesday - Sunday", "Tips"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image":
          "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80",
    },
    {
      "role": "Nail Technician",
      "company": "Luxe Nails & Spa",
      "tags": ["Part-time", "Saturday & Sunday", "Tips"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image":
          "https://images.unsplash.com/photo-1604654894610-df63bc536371?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80",
    },
    {
      "role": "Lead Makeup Artist",
      "company": "Bella Beauty Studio",
      "tags": ["Full-time", "Event-based", "High-end clientele"],
      "location": "Kensington, London",
      "level": "Entry Level",
      "posted": "2 days ago",
      "image":
          "https://images.unsplash.com/photo-1487412947132-26c244971044?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80",
    },
  ].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
