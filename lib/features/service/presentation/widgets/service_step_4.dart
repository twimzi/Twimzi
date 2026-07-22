import 'package:flutter/material.dart';

class ServiceStep4 extends StatefulWidget {
  const ServiceStep4({super.key});

  @override
  State<ServiceStep4> createState() => _ServiceStep4State();
}

class _ServiceStep4State extends State<ServiceStep4> {
  bool _appointmentRequired = true;
  bool _homeService = false;
  bool _onSiteService = true;
  bool _featured = false;
  bool _active = true;

  final Set<String> _selectedDays = {
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  };

  TimeOfDay _openingTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _closingTime = const TimeOfDay(hour: 18, minute: 0);

  final List<String> _days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  Future<void> _pickOpeningTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _openingTime,
    );

    if (time != null) {
      setState(() {
        _openingTime = time;
      });
    }
  }

  Future<void> _pickClosingTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _closingTime,
    );

    if (time != null) {
      setState(() {
        _closingTime = time;
      });
    }
  }

  String _format(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod;

    final minute =
    time.minute.toString().padLeft(2, '0');

    final period =
    time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Working Days',
            style:
            Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _days.map((day) {
              final selected =
              _selectedDays.contains(day);

              return FilterChip(
                label: Text(day),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedDays.add(day);
                    } else {
                      _selectedDays.remove(day);
                    }
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          Text(
            'Working Hours',
            style:
            Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickOpeningTime,
                  icon: const Icon(Icons.login),
                  label: Text(
                    _format(_openingTime),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickClosingTime,
                  icon: const Icon(Icons.logout),
                  label: Text(
                    _format(_closingTime),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          SwitchListTile(
            title: const Text(
              'Appointment Required',
            ),
            subtitle: const Text(
              'Customers must book before visiting.',
            ),
            value: _appointmentRequired,
            onChanged: (value) {
              setState(() {
                _appointmentRequired = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text(
              'Home Service',
            ),
            subtitle: const Text(
              'Service is provided at customer location.',
            ),
            value: _homeService,
            onChanged: (value) {
              setState(() {
                _homeService = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text(
              'On-site Service',
            ),
            subtitle: const Text(
              'Customers visit your business.',
            ),
            value: _onSiteService,
            onChanged: (value) {
              setState(() {
                _onSiteService = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text(
              'Featured Service',
            ),
            subtitle: const Text(
              'Highlight this service.',
            ),
            value: _featured,
            onChanged: (value) {
              setState(() {
                _featured = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text(
              'Active',
            ),
            subtitle: const Text(
              'Visible to customers.',
            ),
            value: _active,
            onChanged: (value) {
              setState(() {
                _active = value;
              });
            },
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Configure when customers can book this service and how it will be offered. You can change these settings anytime later.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}