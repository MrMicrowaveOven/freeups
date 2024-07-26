SINGLE_PERK_NAMES = %w(
    max_game_speed
    swamp_radius
    death_wave
    golden_tower_bonus
    chain_lightning_damage
    chrono_field_duration
    black_hole_duration
    spotlight_damage_bonus
    damage_for_boss_health
    coins_for_health
    damage_for_damage
    wave_cash_for_kills_cash
    boss_health_for_boss_speed
    lifesteal_for_knockback
)
    # enemy_health_for_lifesteal
    # range_for_damage
    # enemy_speed_for_enemy_damage
    # regen_for_health
DOUBLE_PERK_NAMES = %w(
    orbs
    random_ultimate_weapon
)
TRIPLE_PERK_NAMES = %w(
    bounce_shot
    perk_wave_requirement
)
QUINTUPLE_PERK_NAMES = %w(
    max_health
    damage
    health_regen
    coins_bonus
    # interest
    land_mine_damage
    cash_bonus
    defense_absolute
    defense_percent
    free_upgrade_chance
)

PERK_PREFERENCE = [
    "perk_wave_requirement",
    "free_upgrade_chance",
] + SINGLE_PERK_NAMES + DOUBLE_PERK_NAMES + TRIPLE_PERK_NAMES + QUINTUPLE_PERK_NAMES