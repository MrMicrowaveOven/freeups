require_relative '../perk.rb'

describe 'self.is_perk_wave' do
    it "works without PWR" do
        expect(Perk.is_perk_wave(187, 0, 0)).to eq(true)
        expect(Perk.is_perk_wave(186, 0, 0)).to eq(false)
    end
    it "works with PWR" do
        expect(Perk.is_perk_wave(420, 2, 1)).to eq(true)
        expect(Perk.is_perk_wave(421, 2, 1)).to eq(false)
    end
end

describe 'self.select_perk' do
    it 'selects the correct first perk' do
        stub_const("FIRST_PERK", "free_upgrade_chance")
        perks = []
        perks << Perk.new('cash_bonus', 5)
        perks << Perk.new('health_regen', 5)
        perks << Perk.new('coins_bonus', 5)
        first_perk = Perk.new('free_upgrade_chance', 5)
        perks << first_perk
        perks << Perk.new('land_mine_damage', 5)
        perks << Perk.new('damage', 5)
        Perk.select_perk(perks)
        expect(first_perk.perk_level).to eq(1)
    end
    it 'follows priority for the later perks' do
        stub_const("FIRST_PERK", "free_upgrade_chance")
        perks = []
        perks << Perk.new('cash_bonus', 5)
        # perks << Perk.new('health_regen', 5)
        perks << Perk.new('coins_bonus', 5)
        first_perk = Perk.new('free_upgrade_chance', 5)
        perks << first_perk
        first_perk.level_up
        # perks << Perk.new('land_mine_damage', 5)
        # perks << Perk.new('damage', 5)
        expect(first_perk.perk_level).to eq(1)

        Perk.select_perk(perks)
        expect(first_perk.perk_level).to eq(2)
    end
end