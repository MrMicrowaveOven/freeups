require_relative 'perk_constants'
require_relative 'perk'

BASE_UPGRADE_CHANCE = 0.6758
PERK_ADDITION = 0.0625
ELS_BASE_SKIP_CHANCE = 0.30
# ELS_BASE_SKIP_CHANCE = 0.0
MAX_ELS_BASE_SKIP_CHANCE = 0.40
ELS_CHANCE_INCREASE = 0.0005

PERK_WAVE = 187

class Run
    def initialize
        @wave = 1
        @upgrade_chance = BASE_UPGRADE_CHANCE
        @elas_skip_chance = ELS_BASE_SKIP_CHANCE
        @elhs_skip_chance = ELS_BASE_SKIP_CHANCE
        @num_attack_skips = 0
        @num_health_skips = 0
        @perks = make_perks
        do_run
    end

    def make_perks
        perks = []
        SINGLE_PERK_NAMES.each do |perk_name|
            perks << Perk.new(perk_name, 1)
        end
        DOUBLE_PERK_NAMES.each do |perk_name|
            perks << Perk.new(perk_name, 2)
        end
        TRIPLE_PERK_NAMES.each do |perk_name|
            perks << Perk.new(perk_name, 3)
        end
        QUINTUPLE_PERK_NAMES.each do |perk_name|
            perks << Perk.new(perk_name, 5)
        end
        perks
    end

    def free_upgrade_check
        if rand < @upgrade_chance
            if @elas_skip_chance < MAX_ELS_BASE_SKIP_CHANCE && @elas_skip_chance < MAX_ELS_BASE_SKIP_CHANCE
                if rand < 0.5
                    @elas_skip_chance += ELS_CHANCE_INCREASE
                    @elas_skip_chance = round(@elas_skip_chance)
                else
                    @elhs_skip_chance += ELS_CHANCE_INCREASE
                    @elhs_skip_chance = round(@elhs_skip_chance)
                end
            elsif @elas_skip_chance < MAX_ELS_BASE_SKIP_CHANCE
                @elas_skip_chance += ELS_CHANCE_INCREASE
                @elas_skip_chance = round(@elas_skip_chance)
            elsif @elhs_skip_chance < MAX_ELS_BASE_SKIP_CHANCE
                @elhs_skip_chance += ELS_CHANCE_INCREASE
                @elhs_skip_chance = round(@elhs_skip_chance)
            end
        end
    end

    def els_check
        if rand < @elas_skip_chance
            @num_attack_skips += 1
        end
        if rand < @elhs_skip_chance
            @num_health_skips += 1
        end
    end

    def one_wave
        # p "Wave #{@wave}"
        # p "ELAS Chance #{@elas_skip_chance}"
        # p "ELHS Chance #{@elhs_skip_chance}"
        els_check
        free_upgrade_check
        @wave += 1
    end

    def do_run
        until (@elas_skip_chance >= MAX_ELS_BASE_SKIP_CHANCE && @elhs_skip_chance >= MAX_ELS_BASE_SKIP_CHANCE)
            one_wave
        end
        # p "Num Attack Skips:"
        # p @num_attack_skips
        # p "Num Health Skips:"
        # p @num_health_skips
        # p "run done!"
        {
            skips: @num_attack_skips + @num_health_skips,
            waves: @wave
        }
    end
end

def round(number)
    number = (number * 10000.0).round/10000.0
end