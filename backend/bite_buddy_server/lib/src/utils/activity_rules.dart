// How steps and sleep from Apple Health or Health Connect boost the pet. The
// phone reports the numbers, so each day's boost is capped: faking them can't
// earn more than a real active day.

const int stepsPerEnergy = 1000;
const int maxActivityEnergyPerDay = 10;
const int sleepGoalMinutes = 7 * 60;
const int sleepHealth = 5;
// Anything above these is a bad reading, not a real day
const int maxStepsPerDay = 100000;
const int maxSleepMinutes = 16 * 60;

// The full boost a day with this much activity earns
({int energy, int health}) activityAwards(int steps, int sleepMinutes) {
  final energy = steps.clamp(0, maxStepsPerDay) ~/ stepsPerEnergy;
  return (
    energy: energy > maxActivityEnergyPerDay ? maxActivityEnergyPerDay : energy,
    health: sleepMinutes >= sleepGoalMinutes ? sleepHealth : 0,
  );
}
