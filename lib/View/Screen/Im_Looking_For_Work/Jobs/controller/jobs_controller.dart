import 'package:geolocator/geolocator.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

class JobsController extends GetxController {
  var jobList = <JobModel>[].obs;
  var isLoadingLocation = true.obs;
  var userLatitude = 23.8103.obs; // Default Dhaka
  var userLongitude = 90.4125.obs;

  @override
  void onInit() {
    super.onInit();
    // Use Dhaka as default, but try to get real location.
    // If real location is found, the map will move there.
    // But the jobs are hardcoded to Dhaka as requested.
    _initLocationAndJobs();
  }

  Future<void> _initLocationAndJobs() async {
    try {
      Position position = await _determinePosition();
      userLatitude.value = position.latitude;
      userLongitude.value = position.longitude;
      // We ignore the user's real location for generating jobs,
      // forcing them to be in Dhaka as requested.
      loadJobs();
    } catch (e) {
      print("Location error: $e");
      // Fallback/Default is already Dhaka
      loadJobs();
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  void loadJobs() {
    jobList.clear();

    // Fixed Dhaka Locations covering various distances
    // Center approx: 23.8103, 90.4125

    jobList.addAll([
      // JobModel(
      //   id: '1',
      //   title: 'Senior Hair Stylist',
      //   companyName: 'Glow Beauty Salon',
      //   location: 'Gulshan 1, Dhaka',
      //   jobType: 'Full-time',
      //   salary: 'BDT 25,000 - 35,000/Month',
      //   logoUrl:
      //       'https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
      //   postedTime: '2 day ago',
      //   workingHours: 'Tuesday - Saturday',
      //   workSystem: 'On-site',
      //   skills: ['Level 3 Diploma', 'Advanced Color'],
      //   companyDescription:
      //       "Luxury salon in Gulshan looking for experienced stylists.",
      //   businessPhotos: [
      //     'https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
      //   ],
      //   requirements: ['Experience required'],
      //   benefits: ['Commission'],
      //   latitude: 23.7925,
      //   longitude: 90.4078, // Gulshan (~2km)
      // ),

      JobModel(
        id: '1',
        title: 'Senior Hair Stylist',
        companyName: 'Glow Beauty Salon',
        location: 'Gulshan 1, Dhaka',
        jobType: 'Full-time',
        salary: '£28,000 - £35,000/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
        postedTime: '2 day ago',
        workingHours: 'Tuesday - Saturday',
        workSystem: 'On-site',
        skills: [
          'Level 3 Diploma',
          '5+ years of',
          'Knowledge of current',
          'Advanced color and',
          'Excellent customer service',
        ],
        companyDescription:
            "We're looking for an experienced stylist to join our growing team in a luxury salon environment. You'll work with high-end clients and have access to ongoing training.\n\nProfessional salon environment with a focus on quality service and team development. We value our staff and provide ongoing training and career growth opportunities.",
        businessPhotos: [
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
          'https://images.unsplash.com/photo-1595476106812-c4058d8c289f?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
          'https://images.unsplash.com/photo-1595476106812-c4058d8c289f?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
        ],
        requirements: [
          'Level 3 Diploma in Hairdressing or equivalent',
          '5+ years of professional experience',
          'Advanced color and cutting skills',
          'Excellent customer service abilities',
          'Knowledge of current trends and techniques',
        ],
        benefits: [
          'Commission on retail',
          'Staff discount',
          'Training opportunities',
          'Pension scheme',
        ],

        latitude: 23.7925,
        longitude: 90.4078, // Gulshan (~2km)
      ),

      JobModel(
        id: '2',
        title: 'Junior Hair Stylist',
        companyName: 'Urban Cuts',
        location: 'Banani, Dhaka',
        jobType: 'Full-time',
        salary: 'BDT 15,000 - 20,000/Month',
        logoUrl:
            'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=200&q=80',
        postedTime: '1 day ago',
        workingHours: 'Monday - Friday',
        workSystem: 'On-site',
        skills: ['Basic cutting', 'Customer handling'],
        companyDescription: 'Trendy salon in Banani.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Basic skills'],
        benefits: ['Training'],
        latitude: 23.7940,
        longitude: 90.4043, // Banani (~2km)
      ),

      JobModel(
        id: '3',
        title: 'Barber',
        companyName: 'Kings Barber Shop',
        location: 'Dhanmondi, Dhaka',
        jobType: 'Full-time',
        salary: 'BDT 18,000 - 25,000/Month',
        logoUrl:
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=200&q=80',
        postedTime: '3 days ago',
        workingHours: 'Monday - Saturday',
        workSystem: 'On-site',
        skills: ['Fade cutting', 'Beard styling'],
        companyDescription: 'Popular barber shop in Dhanmondi.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Barber experience'],
        benefits: ['Tips'],
        latitude: 23.7461,
        longitude: 90.3742, // Dhanmondi (~10km)
      ),

      JobModel(
        id: '4',
        title: 'Hair Color Specialist',
        companyName: 'Luxe Hair Studio',
        location: 'Uttara, Dhaka',
        jobType: 'Part-time',
        salary: 'BDT 500/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=200&q=80',
        postedTime: '5 days ago',
        workingHours: 'Flexible',
        workSystem: 'On-site',
        skills: ['Color correction'],
        companyDescription: 'Premium color studio.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Certification'],
        benefits: ['Flexible hours'],
        latitude: 23.8759,
        longitude: 90.3795, // Uttara (~8km)
      ),

      JobModel(
        id: '5',
        title: 'Salon Manager',
        companyName: 'Elite Beauty Lounge',
        location: 'Mirpur 10, Dhaka',
        jobType: 'Full-time',
        salary: 'BDT 40,000/Month',
        logoUrl:
            'https://images.unsplash.com/photo-1559599101-f09722fb4948?auto=format&fit=crop&w=200&q=80',
        postedTime: '1 week ago',
        workingHours: 'Sunday - Thursday',
        workSystem: 'On-site',
        skills: ['Management'],
        companyDescription: 'Large salon in Mirpur.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Managerial Exp'],
        benefits: ['Bonuses'],
        latitude: 23.8042,
        longitude: 90.3667, // Mirpur (~6km)
      ),

      JobModel(
        id: '6',
        title: 'Nail Technician',
        companyName: 'Polish & Glow',
        location: 'Bashundhara R/A, Dhaka',
        jobType: 'Full-time',
        salary: 'BDT 20,000/Month',
        logoUrl:
            'https://images.unsplash.com/photo-1600948836101-f9ffda59d250?auto=format&fit=crop&w=200&q=80',
        postedTime: '2 days ago',
        workingHours: 'Monday - Friday',
        workSystem: 'On-site',
        skills: ['Nail Art'],
        companyDescription: 'Nail studio in Bashundhara.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1600948836101-f9ffda59d250?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Experience'],
        benefits: ['Commission'],
        latitude: 23.8191,
        longitude: 90.4526, // Bashundhara (~4km)
      ),

      JobModel(
        id: '7',
        title: 'Makeup Artist',
        companyName: 'Glam Studio',
        location: 'Savar, Dhaka',
        jobType: 'Freelance',
        salary: 'BDT 5,000/Day',
        logoUrl:
            'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=200&q=80',
        postedTime: '4 days ago',
        workingHours: 'Event-based',
        workSystem: 'On-site',
        skills: ['Bridal'],
        companyDescription: 'Freelance makeup gigs.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Portfolio'],
        benefits: ['High Pay'],
        latitude: 23.8407,
        longitude: 90.2575, // Savar (~18km)
      ),

      JobModel(
        id: '8',
        title: 'Spa Therapist',
        companyName: 'Calm Retreat',
        location: 'Gazipur',
        jobType: 'Full-time',
        salary: 'BDT 22,000/Month',
        logoUrl:
            'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=200&q=80',
        postedTime: '6 days ago',
        workingHours: 'Shift',
        workSystem: 'On-site',
        skills: ['Massage'],
        companyDescription: 'Resort spa in Gazipur.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Certificate'],
        benefits: ['Accommodation'],
        latitude: 23.9999,
        longitude: 90.4203, // Gazipur (~25km)
      ),

      JobModel(
        id: '9',
        title: 'Receptionist',
        companyName: 'Style Hub',
        location: 'Narayanganj',
        jobType: 'Full-time',
        salary: 'BDT 15,000/Month',
        logoUrl:
            'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=200&q=80',
        postedTime: 'Today',
        workingHours: '9-5',
        workSystem: 'On-site',
        skills: ['Communication'],
        companyDescription: 'Salon in Narayanganj.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['HSC Pass'],
        benefits: ['Lunch'],
        latitude: 23.6238,
        longitude: 90.5000, // Narayanganj (~22km)
      ),

      JobModel(
        id: '10',
        title: 'Beauty Trainer',
        companyName: 'Pure Beauty',
        location: 'Comilla',
        jobType: 'Contract',
        salary: 'BDT 50,000/Course',
        logoUrl:
            'https://images.unsplash.com/photo-1600948836451-3cfa7b5d24dd?auto=format&fit=crop&w=200&q=80',
        postedTime: '3 days ago',
        workingHours: 'Daytime',
        workSystem: 'On-site',
        skills: ['Teaching'],
        companyDescription: 'Beauty academy in Comilla.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1600948836451-3cfa7b5d24dd?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['5yr Exp'],
        benefits: ['Travel Allowance'],
        latitude: 23.4607,
        longitude: 91.1809, // Comilla (Distance > 80km)
      ),
    ]);
  }
}
