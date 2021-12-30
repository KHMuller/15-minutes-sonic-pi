# 15 Minutes
# 29th of December 2021
# Waves
# Keep different tracks and join them in DaVinci Resolve
# With this approach I may overcome the amp issues between themes

n = rrand_i(1, 4)

n.times do
  live_loop :choir do
    rate = rrand_i(3, 6)
    sample :ambi_choir, beat_stretch: 5 * rate, pitch: 4 * rate,
      attack: 1 * rate, attack_level: 2,
      decay: 2 * rate, decay_level: 1,
      sustain: 1 * rate, sustain_level: 1.5,
      release: 1 * rate,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: 2 * rate
    sleep 5 * rate
  end
  
  
  live_loop :choir1 do
    rate = rrand_i(2, 5)
    sleep 2
    sample :ambi_choir, beat_stretch: 5 * rate, pitch: 4 * rate,
      attack: 1 * rate, attack_level: 2,
      decay: 2 * rate, decay_level: 1,
      sustain: 1 * rate, sustain_level: 0.4,
      release: 1 * rate,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: 2 * rate
    sleep 5 * rate - 2
  end
  
  
  live_loop :choir2 do
    rate = rrand_i(2, 4)
    sleep 4
    sample :ambi_choir, beat_stretch: 5 * rate, pitch: 4 * rate,
      attack: 1 * rate, attack_level: 2,
      decay: 2 * rate, decay_level: 1,
      sustain: 1 * rate, sustain_level: 1.5,
      release: 1 * rate,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: 2 * rate
    sleep 5 * rate - 4
  end
  sleep 1
  puts "cycle end"
end





