require_relative 'run'

NUM_RUNS = 1_000_000

def do_runs(num_runs)
    skips = []
    waves = []
    upgrade_perks = []
    num_maxed = 0
    num_runs.times do |i|
        run = Run.new
        data = run.do_run
        skips << data[:skips]
        waves << data[:waves]
        upgrade_perks << data[:upgrade_perks]
        num_maxed += 1 if data[:is_maxed]
    end
    skips = skips.inject{ |sum, el| sum + el }.to_f / skips.size
    waves = waves.inject{ |sum, el| sum + el }.to_f / waves.size
    num_upgrade_perks = []
    6.times do |i|
        num_upgrade_perks[i] = upgrade_perks.select {|num| num == i}.length
    end
    p "skips: #{skips.round}, waves: #{waves.round}, num_upgrade_perks: #{num_upgrade_perks}, runs: #{num_upgrade_perks.sum}"
    # , num_runs_maxed: #{num_maxed}"
end
p "============================================================="
p "First Perk: #{FIRST_PERK}"
p "Preference: #{PERK_PREFERENCE[0]}, then #{PERK_PREFERENCE[1]}"
5.times do |i|
    do_runs(1000)
end
# do_runs(1)