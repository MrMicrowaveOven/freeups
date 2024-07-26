# The Tower Idle Upgrade Simulator

This is a simulator for the mobile game Tower Idle.  I'll start with a brief introduction on the game and what upgrades are, and then explain the data this is building.

# The Game

In the game you have a _Tower_ that you are trying to defend from enemies.  You can build MANY upgrades to attack the _enemies_ that approach the tower.  None of these really matter to this simulator.  The only important thing is that enemies get stronger every _wave_.

Once your Tower is overrun, you have completed a _run_.  When the run is over, you can upgrade the Tower outside of the run and then attempt another run at greater strength.

## Upgrades

One of the upgrades is the chance to get a free _upgrade_ every wave.  This saves on money, and makes it easy to max out the upgrades on the Tower.  We'll call this __free_upgrade_chance__.  This is important so that the Tower can be maxed out quickly.  Mine starts at `67.58%`, meaning at the beginning of the run, each wave has a `67.58%` chance to give me a free upgrade.

## Enemy Level Skip

Another of the upgrades is the ability for enemies to not gain a level on a wave (__enemy_level_skip__, or __ELS__).  So if you're on Wave 10 and 1 level was skipped, enemies will be the strength of level 9.  On level 20, they will be the strength of level 19, and so on.  You want a lot of these.  Mine starts at `19%`, and maxes out at `42%`, with each upgrade increasing my probability by `%0.05%`.  These get very expensive during the run, so the only way to max them out is with Free Upgrades.

You also want these maxed out as soon as possible during a run, so that more waves will be skipped throughout the run.  Maxing out ELS at `42%` on Wave 1000 will cause a lot more enemy levels to be skipped than maxing it out on Wave 2000.

We're almost done.  Now let's talk about __Perks__

## Perks

During a run, on certain waves, the player can choose one of 4 randomly-selected Perks.  There are many of these, and they have a large impact on a run.  At my level, I can select a Perk every 187 waves.  At wave 187 I can select my first perk, at wave 374 my second perk, and so on.

The only two relevant Perks to this simulation are __free_upgrade_chance_perk__ and __perk_wave_requirement_decrease__.

__free_upgrade_chance_perk__ increases your chances of a free upgrade each wave by `6.25%`.  This perk is the single most important perk to maxing out __ELS__ early, since you'll get more free upgrades sooner.  You can get 5 of them in a run, which eventually increases my Free Upgrade Chance to `98.84%`.

__perk_wave_requirement_decrease__ decreases the wave requirement for perks by `25%`.  In other words, while I can generally pick my second perk at Wave 374, if I've picked perk_wave_requirement_decrease as my first perk my second perk will come at (1 - .25) * 374 = 285.5, or Wave 285.  This can be great for getting Perks early during a run, and it generally pays for itself quickly.

You can get 3 perk_wave_requirement_decrease Perks during a run, which maxes out at decreasing the wave requirement for perks by 75%.

Finally, I can choose a Perk to always appear on my list of selectable perks as my FIRST Perk.  Meaning I can choose what my first Perk will be every run.  After that it is entirely random.

So the question is, if my primary goal is to max out __ELS__ as early as possible, is it more strategic for my first Perk choice to be __free_upgrade_chance_perk__ (more free upgrades to max it out sooner), or for my first Perk choice to be __perk_wave_requirement_decrease__ (more perks, hence more free upgrades to max it out sooner).

EVERYONE says __perk_wave_requirement_decrease__ is the way to go.  However, since my __ELS__ maxes out so soon (around wave 1500), it's possible that __perk_wave_requirement_decrease__ doesn't have enough time to "pay for itself" to benefit me more than just picking __free_upgrade_chance_perk__ first.

So that's what this simulator will try to figure out.  Which First Perk choice allows me to max out my __ELS__ sooner?

For the sake of this simulation, we'll take both scenarios to Wave 3000 and calculate how many enemy_level_wave_skips were achieved by then.  More enemy_level_wave_skips makes it the better choice.

# The Simulation

We will simulate a _run_ many times.  First we will simulate with `free_upgrade_chance` set as our first upgrade, then we will simulate with `perk_wave_requirement` as our first upgrade.  The general consensus is that `perk_wave_requirement` is the better choice for the Second Perk, but we can play with that afterwards.

A _run_ will step through, wave by wave, and have a chance of upgrading ELS each time.  One the waves where I would get a Perk, 4 Perks will be selected and the prioritized Perk will be selected.  In the case of the First Perk, the chosen Perk will simply be chosen (since that is guaranteed).

In addition, every wave will also have a chance to skip enemy level, based on the ELS at the time.  The total number of skips in the run will be recorded, and will be the primary calculation for the best strategy.

For completionist's sake, we'll also display how many Free Upgrade Perks each run gets depending on the situation.

## run.rb

This class defines a single run.  Each run it sets the base upgrade_chance, els_bask_skip_chance, creates all the Perks (`perk.rb`) at Level 0, and sets all counters to 0 for the run.  When `do_run` is called, it moves wave-by-wave and calculates each of the upgrades and enemy_level_skips.  When the time comes for a Perk, it calls `select_perk` on Perk which randomly selects 4 Perks and picks the preferred Perk (or picks the First Perk choice in the case of the First Perk).

This runs until Wave 3000.  Once ELS is maxed, it stops upgrading but continues to calculate skips.  The strategy with the most skips wins.

## perk.rb

Each Perk represents a single type of perk.  One will be created for each type of perk at the beginning of a run, all at Level 0.  When the time comes for a perk to be selected, this class will decide which perks will be randomly chosen and selected.

All perk data (names of perks, perk preference) is stored as constants in `perk_constants.rb`.

## do_runs.rb

This is called to simulate multiple runs.  I generally do 5 rounds of 1000 runs each, just to see that the conclusions are consistent.  After the runs are complete, the following data will be displayed:

__skips__: How many enemy levels were skipped during the run.  This is averaged over all 1000 runs.

__waves__: The wave the run was completed on.  Since we're running to Wave 3000, this will be consistent.  However, other calculations might call for the simulator to run until ELS is maxed, so the wave could be a variable in certain situations.  This is averaged over all 1000 runs.

__num_upgrade_perks__: This displays how many free_upgrade_chance_perks were acquired up until ELS was maxed.  It's an array showing how many runs reached how many perks (starting at 0).  So for example, an array of `[5, 3, 6, 2, 1, 0]` means that 5 runs acquired 0 free_upgrade_chance_perks, 3 runs acquired 1 free_upgrade_chance_perks, 6 acquired 2, 2 acquired 3, 1 run acquired 4, and 0 runs acquired all 5 free_upgrade_chance_perks.

__total__: This is the total of all runs, `17` in the above example.

# Results

(coming soon)