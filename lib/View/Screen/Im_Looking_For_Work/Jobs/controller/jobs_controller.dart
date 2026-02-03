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
      ),
    ]);
  }
}
