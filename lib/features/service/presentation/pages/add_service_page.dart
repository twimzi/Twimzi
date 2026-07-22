import 'package:flutter/material.dart';

import '../widgets/service_step_1.dart';
import '../widgets/service_step_2.dart';
import '../widgets/service_step_3.dart';
import '../widgets/service_step_4.dart';
import '../widgets/service_step_5.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  int _currentStep = 0;

  final PageController _pageController = PageController();

  void _nextStep() {
    if (_currentStep == 4) return;

    setState(() {
      _currentStep++;
    });

    _pageController.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousStep() {
    if (_currentStep == 0) return;

    setState(() {
      _currentStep--;
    });

    _pageController.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String get _title {
    switch (_currentStep) {
      case 0:
        return 'Service Information';

      case 1:
        return 'Pricing';

      case 2:
        return 'Gallery';

      case 3:
        return 'Availability';

      case 4:
        return 'Review';

      default:
        return '';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Service'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentStep + 1) / 5,
                ),

                const SizedBox(height: 10),

                Text(
                  'Step ${_currentStep + 1} of 5',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const SizedBox(height: 8),

                Text(
                  _title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ServiceStep1(),
                ServiceStep2(),
                ServiceStep3(),
                ServiceStep4(),
                ServiceStep5(),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (_currentStep != 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      child: const Text(
                        'Previous',
                      ),
                    ),
                  ),

                if (_currentStep != 0)
                  const SizedBox(width: 12),

                Expanded(
                  child: FilledButton(
                    onPressed: _currentStep == 4
                        ? () {
                      // TODO: Create Service
                    }
                        : _nextStep,
                    child: Text(
                      _currentStep == 4
                          ? 'Create Service'
                          : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}