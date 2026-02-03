import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Portfolio/model/portfolio_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePortfolioController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final portfolioItems = <PortfolioModel>[
    PortfolioModel(
      title: "Balayage & Color Work",
      description:
          "A stunning balayage look with soft, natural highlights and precision color blending.",
      imageUrls: [
        "https://images.unsplash.com/photo-1560869713-7d0a29430803?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1562322140-8baeececf3df?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1595152772835-219674b2a8a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1620331317329-363f8f9509f6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      ],
    ),
    PortfolioModel(
      title: "Hair Styling Collection",
      description:
          "Creative styling for special occasions including weddings and events.",
      imageUrls: [
        "https://images.unsplash.com/photo-1522337660859-02fbefca4702?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1620331317329-363f8f9509f6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1595152772835-219674b2a8a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1560869713-7d0a29430803?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      ],
    ),
  ].obs;

  void addPortfolio(PortfolioModel item) {
    portfolioItems.add(item);
    portfolioItems.refresh();
  }

  Future<void> updatePortfolioImage(int itemIndex, int imageIndex) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      portfolioItems[itemIndex].imageUrls[imageIndex] = image.path;
      portfolioItems.refresh();
    }
  }

  void updatePortfolioText(int itemIndex, String title, String description) {
    portfolioItems[itemIndex].title = title;
    portfolioItems[itemIndex].description = description;
    portfolioItems.refresh();
  }
}
