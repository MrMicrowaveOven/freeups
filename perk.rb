PERK_WAVE = 187
FIRST_PERK = "free_upgrade_chance"
# FIRST_PERK = "perk_wave_requirement"

class Perk
    attr_reader :perk_name, :perk_level
    def self.is_perk_wave(wave_number, num_perks, num_pwr_perks)
        waves_required = (PERK_WAVE * (1 - (num_pwr_perks * 0.25)) * (num_perks + 1)).floor
        wave_number === waves_required
    end

    def self.select_perk(perks)
        num_perks = perks.map {|perk| perk.perk_level}.sum
        if num_perks == 0
            perk = perks.find{|perk| perk.perk_name == FIRST_PERK}
            perk.level_up
            return
        end
        levelable_perks = perks.select {|perk| !perk.maxed}
        perks_presented = levelable_perks.sample(4)
        PERK_PREFERENCE.each do |preferred_perk|
            if perk = perks_presented.find{|perk| perk.perk_name == preferred_perk}
                perk.level_up
                break
            end
        end
    end

    # def self.num_perks
    #     perk_levels = Perk.all.map {|perk| perk.perk_level}
    #     perk_levels.sum
    # end

    def initialize(perk_name, max_perk_level = 1)
        @perk_name = perk_name
        @max_perk_level = max_perk_level
        @perk_level = 0
    end

    def maxed
        @perk_level == @max_perk_level
    end

    def level_up
        if @perk_level < @max_perk_level
            @perk_level += 1
        else
            raise "Cannot increase level of #{perk_name} any further"
        end
    end
end