class Perk
    def initialize(perk_name, max_perk_level = 1)
        @perk_name = perk_name
        @max_perk_level = max_perk_level
        @perk_level = 0
    end
    def add_perk
        if @perk_level < @max_perk_level
            @perk_level += 1
        else
            raise "Cannot increase level of #{@perk_name} any further"
        end
    end
end