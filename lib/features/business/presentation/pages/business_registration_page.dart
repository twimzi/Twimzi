import 'package:flutter/material.dart';

import '../widgets/business_step_1.dart';
import '../widgets/business_step_2.dart';
import '../widgets/business_step_3.dart';
import '../widgets/business_step_4.dart';
import '../widgets/business_step_5.dart';

class BusinessRegistrationPage extends StatefulWidget {
  const BusinessRegistrationPage({super.key});

  @override
  State<BusinessRegistrationPage> createState() =>
      _BusinessRegistrationPageState();
}

class _BusinessRegistrationPageState
    extends State<BusinessRegistrationPage> {
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
        return 'Business Information';

      case 1:
        return 'Location';

      case 2:
        return 'Contact';

      case 3:
        return 'Branding';

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
        title: const Text('Register Business'),
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
                BusinessStep1(),
                BusinessStep2(),
                BusinessStep3(),
                BusinessStep4(),
                BusinessStep5(),
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
                      // TODO:
                      // Submit Business
                    }
                        : _nextStep,
                    child: Text(
                      _currentStep == 4
                          ? 'Submit'
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