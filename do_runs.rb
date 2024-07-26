require_relative 'run'

NUM_RUNS = 1_000_000

def do_runs(num_runs)
    skips = []
    waves = []
    upgrade_perks = []
    num_runs.times do |i|
        run = Run.new
        data = run.do_run
        skips << data[:skips]
        waves << data[:waves]
        upgrade_perks << data[:upgrade_perks]
    end
    # p skips
    # p waves
    skips = skips.inject{ |sum, el| sum + el }.to_f / skips.size
    waves = waves.inject{ |sum, el| sum + el }.to_f / waves.size
    num_upgrade_perks = []
    6.times do |i|
        num_upgrade_perks[i] = upgrade_perks.select {|num| num == i}.length
    end
    # num_zero = upgrade_perks.select {|num| num == 0}
    # num_zero = upgrade_perks.select {|num| num == 0}
    # num_zero = upgrade_perks.select {|num| num == 0}
    # num_zero = upgrade_perks.select {|num| num == 0}
    # num_zero = upgrade_perks.select {|num| num == 0}
    # num_zero = upgrade_perks.select {|num| num == 0}
    # num_upgrade_perks = upgrade_perks.inject{ |sum, el| sum + el }.to_f / upgrade_perks.size
    p "skips: #{skips.round}, waves: #{waves.round}, num_upgrade_perks: #{num_upgrade_perks}, total: #{num_upgrade_perks.sum}"
    # p "waves: #{waves}"
end
5.times do |i|
    do_runs(1000)
end
# do_runs(1)