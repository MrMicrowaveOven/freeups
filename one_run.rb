require_relative 'run'

NUM_RUNS = 1_000_000

def do_runs(num_runs)
    skips = []
    waves = []
    num_runs.times do |i|
        run = Run.new
        data = run.do_run
        skips << data[:skips]
        waves << data[:waves]
    end
    # p skips
    # p waves
    skips = skips.inject{ |sum, el| sum + el }.to_f / skips.size
    waves = waves.inject{ |sum, el| sum + el }.to_f / waves.size
    p "skips: #{skips.round}, waves: #{waves.round}"
    # p "waves: #{waves}"
end
5.times do |i|
    do_runs(1000)
end
# do_runs(1)