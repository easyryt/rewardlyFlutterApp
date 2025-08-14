import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/model/get_analytics_model.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainApplicationController mainApplicationController = Get.find();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        title: const Text("Analytics",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        actions: const [
          SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        final data = mainApplicationController.getAnalyticsModel.value;
        if (mainApplicationController.isAnalyticsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (data == null) {
          return const Center(child: Text("No Data"));
        }

        final earnings = data.earnings;
        final activity = data.activity;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Earnings Card
              _sectionTitle("Earnings"),
              Card(
                color: whiteColor,
                surfaceTintColor: whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _earningRow("Total Earnings", earnings?.totalEarnings),
                      const Divider(),
                      _earningRow("Self Wallet", earnings?.selfWallet),
                      _earningRow("Referral Wallet", earnings?.referralWallet),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Activity Section
              _sectionTitle("Activity"),
              Row(
                children: [
                  Expanded(
                    child: _activityCard(
                      "Installs",
                      activity?.cpi,
                      Colors.teal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _activityCard(
                      "Review",
                      activity?.review,
                      Colors.deepOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Referral Breakdown
              if ((earnings?.referralBreakdown ?? []).isNotEmpty) ...[
                _sectionTitle("Referral Breakdown"),
                ...earnings!.referralBreakdown!
                    .map((e) => Card(
                          color: whiteColor,
                          surfaceTintColor: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.people_alt),
                            title: Text(e.toString()),
                          ),
                        ))
                    .toList(),
              ],
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _earningRow(String label, int? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            "₹${value ?? 0}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityCard(String title, Cpi? cpi, Color color) {
    return Card(
      color: whiteColor,
      surfaceTintColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: color, fontSize: 16)),
            const SizedBox(height: 8),
            _activityStat("Approved", cpi?.approved),
            _activityStat("Rejected", cpi?.rejected),
            _activityStat("Submitted", cpi?.submitted),
            _activityStat("Pending", cpi?.pending),
          ],
        ),
      ),
    );
  }

  Widget _activityStat(String label, int? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value?.toString() ?? "0",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// Example Controller
class AnalyticsController extends GetxController {
  Rx<GetAnalyticsModel?> getAnalyticsModel = Rx<GetAnalyticsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAnalytics();
  }

  void fetchAnalytics() {
    // TODO: replace with API call
    getAnalyticsModel.value = GetAnalyticsModel(
      earnings: Earnings(
        selfWallet: 1200,
        referralWallet: 800,
        totalEarnings: 2000,
        referralBreakdown: ["John - ₹500", "Jane - ₹300"],
      ),
      activity: Activity(
        cpi: Cpi(approved: 5, rejected: 1, submitted: 7, pending: 2),
        review: Cpi(approved: 3, rejected: 0, submitted: 5, pending: 1),
      ),
    );
  }
}
