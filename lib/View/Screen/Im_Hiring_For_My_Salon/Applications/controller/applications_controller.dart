import 'package:get_x/get.dart';
import '../model/application_model.dart';
import '../view/application_details_view.dart';

class ApplicationsController extends GetxController {
  var applications = <ApplicationModel>[].obs;
  var filteredApplications = <ApplicationModel>[].obs;
  var selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadApplications();
  }

  void loadApplications() {
    var data = [
      ApplicationModel(
        id: '1',
        name: 'Sarah Mitchell',
        role: 'Senior Hair Stylist',
        status: 'Pending',
        location: 'London, United Kingdom',
        date: '15 Jan',
        skills: [
          'Balayage',
          'Color Correction',
          'Cutting',
          'Styling',
          'Hair Extensions',
          'Keratin Treatment',
        ],
        hasUnreadMessage: true,
        imageUrl: 'https://i.pravatar.cc/300?img=5',
        experienceYears: '5 Year experience',
        email: 'sarah.mitchell@example.com',
        phone: '+44 20 7946 0958',
        about:
            'Passionate hair stylist with 5+ years of experience specializing in balayage, color correction, and creative styling. I love making clients feel confident and beautiful. Committed to staying updated with the latest trends and techniques.',
        salaryExpectation: '£30,000 - £40,000/Year',
        availability: 'Immediate',
        resumeObj: 'Sarah_Resume.pdf',
        additionalNotes: 'Available for trial shifts and interview.',
        languages: ['English', 'Spanish'],
        workExperience: [
          WorkExperience(
            role: 'Senior Hair Stylist',
            company: 'Glow Beauty Salon',
            dateRange: '2020 - Present',
            type: 'Full Time',
            location: 'London, UK',
          ),
          WorkExperience(
            role: 'Junior Stylist',
            company: 'Bella Hair Studio',
            dateRange: '2018 - 2020',
            type: 'Full Time',
            location: 'London, UK',
          ),
        ],
        education: [
          Education(
            degree: 'Level 3 Diploma in Hairdressing',
            school: 'London College of Beauty Therapy',
            year: '2018',
          ),
          Education(
            degree: 'Advanced Color Techniques',
            school: 'Vidal Sassoon Academy',
            year: '2019',
          ),
        ],
        portfolio: [
          PortfolioItem(
            title: 'Balayage & Color Work',
            description:
                'A stunning balayage look with soft, natural highlights and precision color blending.',
            images: [
              'https://images.unsplash.com/photo-1560869713-7d0a29430803?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1562322140-8baeececf3df?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1634449571010-02389ed0f9b0?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1595476108010-b4d1f102b1b1?auto=format&fit=crop&w=300&q=80',
            ],
          ),
          PortfolioItem(
            title: 'Hair Styling Collection',
            description:
                'Creative styling for special occasions including weddings and events.',
            images: [
              'https://images.unsplash.com/photo-1596417466723-93cf2559cc5d?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1519699047748-de8e457a634e?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1582095133179-bfd08e2fc6b2?auto=format&fit=crop&w=300&q=80',
            ],
          ),
        ],
      ),
      ApplicationModel(
        id: '2',
        name: 'Marcus Reynolds',
        role: 'Barber',
        status: 'Shortlisted',
        location: 'Manchester, UK',
        date: '14 Jan',
        skills: [
          'Fades',
          'Beard Trimming',
          'Hot Towel Shave',
          'Scissors',
          'Razor',
          'Design',
        ],
        hasUnreadMessage: false,
        imageUrl: 'https://i.pravatar.cc/300?img=11',
        experienceYears: '4 Year experience',
        email: 'marcus.reynolds@example.com',
        phone: '+44 7700 900077',
        about:
            'Skilled Barber with strong attention to detail. I specialize in modern skin fades and traditional hot towel shaves. I strive to give every client a sharp look and a relaxing experience.',
        salaryExpectation: '£25,000 - £30,000/Year',
        availability: '2 Weeks Notice',
        resumeObj: 'Marcus_CV.pdf',
        additionalNotes:
            'Looking for a shop with good footfall and a friendly team.',
        languages: ['English'],
        workExperience: [
          WorkExperience(
            role: 'Senior Barber',
            company: 'The Gentleman\'s Grooming',
            dateRange: '2021 - Present',
            type: 'Full Time',
            location: 'Manchester, UK',
          ),
          WorkExperience(
            role: 'Barber',
            company: 'Trim & Cut',
            dateRange: '2018 - 2021',
            type: 'Full Time',
            location: 'Manchester, UK',
          ),
        ],
        education: [
          Education(
            degree: 'NVQ Level 2 Barbering',
            school: 'Manchester College',
            year: '2018',
          ),
        ],
        portfolio: [
          PortfolioItem(
            title: 'Fades & Cuts',
            description:
                'Showcasing precision fades and modern hairstyles for men.',
            images: [
              'https://images.unsplash.com/photo-1621605815971-fbc98d665033?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1534351590666-13e3e96b5017?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?auto=format&fit=crop&w=300&q=80',
            ],
          ),
          PortfolioItem(
            title: 'Beard Styling',
            description: 'Sharp beard trims and sculpting.',
            images: [
              'https://images.unsplash.com/photo-1621605815971-fbc98d665033?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1635273050727-2c1a2b163359?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1552697818-20839e4a36f5?auto=format&fit=crop&w=300&q=80',
            ],
          ),
        ],
      ),
      ApplicationModel(
        id: '3',
        name: 'Jessica Lee',
        role: 'Nail Technician',
        status: 'Pending',
        location: 'Birmingham, UK',
        date: '13 Jan',
        skills: [
          'Gel Nails',
          'Nail Art',
          'Manicure',
          'Pedicure',
          'Acrylics',
          'Polish',
        ],
        hasUnreadMessage: true,
        imageUrl: 'https://i.pravatar.cc/300?img=9',
        experienceYears: '4 Year experience',
        email: 'jessica.nails@example.com',
        phone: '+44 7700 901234',
        about:
            'Creative Nail Technician passionate about nail art and intricate designs. I enjoy keeping up with the latest nail trends and providing high-quality nail care.',
        salaryExpectation: '£22,000 - £26,000/Year',
        availability: 'Immediate',
        resumeObj: 'Jessica_CV.pdf',
        additionalNotes: 'I have my own kit of specialized brushes.',
        languages: ['English', 'Cantonese'],
        workExperience: [
          WorkExperience(
            role: 'Nail Technician',
            company: 'Polished Lounge',
            dateRange: '2022 - Present',
            type: 'Full Time',
            location: 'Birmingham, UK',
          ),
          WorkExperience(
            role: 'Junior Nail Tech',
            company: 'Beauty Box',
            dateRange: '2020 - 2022',
            type: 'Part Time',
            location: 'Birmingham, UK',
          ),
        ],
        education: [
          Education(
            degree: 'Nail Technology Diploma',
            school: 'Birmingham Beauty Academy',
            year: '2020',
          ),
        ],
        portfolio: [
          PortfolioItem(
            title: 'Nail Art Designs',
            description: 'Hand-painted nail art and 3D designs.',
            images: [
              'https://images.unsplash.com/photo-1604654894610-df63bc536371?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1632922267756-9b71242b1592?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1519014816548-bf5fe059e98b?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1600063532720-6d80ef7b812f?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?auto=format&fit=crop&w=300&q=80',
            ],
          ),
        ],
      ),
      ApplicationModel(
        id: '4',
        name: 'Amira Khan',
        role: 'Makeup Artist',
        status: 'Hired',
        location: 'London, UK',
        date: '12 Jan',
        skills: [
          'Bridal Makeup',
          'Editorial Makeup',
          'Special FX',
          'Contouring',
          'Eye Makeup',
          'Skin Prep',
        ],
        hasUnreadMessage: false,
        imageUrl: 'https://i.pravatar.cc/300?img=24',
        experienceYears: '6 Year experience',
        email: 'amira.mua@example.com',
        phone: '+44 7700 987654',
        about:
            'Professional Makeup Artist specializing in bridal lighting and long-lasting looks. I ensure every bride feels their best on their big day.',
        salaryExpectation: '£35,000/Year',
        availability: 'Unavailable',
        resumeObj: 'Amira_Portfolio.pdf',
        additionalNotes: 'Currently fully booked for weekends until March.',
        languages: ['English', 'Urdu', 'Hindi'],
        workExperience: [
          WorkExperience(
            role: 'Freelance MUA',
            company: 'Self Employed',
            dateRange: '2021 - Present',
            type: 'Freelance',
            location: 'London, UK',
          ),
          WorkExperience(
            role: 'Counter MUA',
            company: 'MAC Cosmetics',
            dateRange: '2018 - 2021',
            type: 'Full Time',
            location: 'London, UK',
          ),
        ],
        education: [
          Education(
            degree: 'Diploma in Professional Makeup',
            school: 'London School of Makeup',
            year: '2018',
          ),
        ],
        portfolio: [
          PortfolioItem(
            title: 'Bridal Looks',
            description: 'Traditional and modern bridal makeup.',
            images: [
              'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1596704017254-9b1b1c97a73f?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?auto=format&fit=crop&w=300&q=80',
            ],
          ),
          PortfolioItem(
            title: 'Editorial & Creative',
            description: 'High fashion and creative shoots.',
            images: [
              'https://images.unsplash.com/photo-1500917293891-ef795e70e1f6?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1616683693504-3ea7e9ad6fec?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1503236829514-234abb7f58ac?auto=format&fit=crop&w=300&q=80',
              'https://images.unsplash.com/photo-1457972729786-0411a3b2b626?auto=format&fit=crop&w=300&q=80',
            ],
          ),
        ],
      ),
    ];

    applications.assignAll(data);
    filterApplications('All');
  }

  void filterApplications(String status) {
    selectedFilter.value = status;
    if (status == 'All') {
      filteredApplications.assignAll(applications);
    } else {
      filteredApplications.assignAll(
        applications.where((app) => app.status == status).toList(),
      );
    }
  }

  int getCount(String status) {
    if (status == 'All') return applications.length;
    return applications.where((app) => app.status == status).length;
  }

  void viewApplicationDetails(ApplicationModel app) {
    Get.to(() => const ApplicationDetailsView(), arguments: app);
  }

  Future<void> refreshApplications() async {
    // Simulate network delay and reload
    await Future.delayed(const Duration(seconds: 1));
    loadApplications();
  }
}
