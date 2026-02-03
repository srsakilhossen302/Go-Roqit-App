import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

class JobsController extends GetxController {
  var jobList = <JobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadJobs();
  }

  void loadJobs() {
    // Mock data matching the design
    jobList.addAll([
      JobModel(
        id: '1',
        title: 'Senior Hair Stylist',
        companyName: 'Glow Beauty Salon',
        location: 'Kensington, London',
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
      ),
      JobModel(
        id: '2',
        title: 'Master Barber',
        companyName: 'The Grooming Room',
        location: 'Shoreditch, London',
        jobType: 'Full-time',
        salary: '£28,000 - £35,000/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
        postedTime: '1 day ago',
        workingHours: 'Monday - Friday',
        workSystem: 'On-site',
        skills: ['Barbering', 'Shaving', 'Styling'],
        companyDescription: 'A classic barbershop in the heart of London.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['3+ years experience', 'Portfolio required'],
        benefits: ['Tips', 'Flexible hours'],
      ),
      JobModel(
        id: '3',
        title: 'Nail Technician',
        companyName: 'Luxe Nails & Spa',
        location: 'Manchester City Centre',
        jobType: 'Part-time',
        salary: '£28,000 - £35,000/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1604654894610-df63bc536371?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
        postedTime: '5 hours ago',
        workingHours: 'Weekends',
        workSystem: 'On-site',
        skills: ['Manicure', 'Pedicure', 'Nail Art'],
        companyDescription:
            'Premium nail salon providing high quality services.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1604654894610-df63bc536371?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Qualified Nail Tech', 'Creativity'],
        benefits: ['Employee discount'],
      ),
    ]);
  }
}
