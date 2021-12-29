# 15 Minutes
# 29th of December 2022 - B
# Waves
# Keep different tracks and join them in DaVinci Resolve
# With this approach I may overcome the amp issues between themes

ns_low = (scale :a2, :major_pentatonic, num_octaves: 3)

use_synth :tech_saws
with_fx :reverb, mix: 0.7 do
  live_loop :choir0 do
    n = rrand_i(0, 7)
    cue 'base', n
    rate = 8
    puts ns_low[n]
    play ns_low[n],
      attack: 1,
      release: 8,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: 9
    sleep 10
  end
  
  
  live_loop :choir1 do
    n = sync 'base'
    rate = 4
    sleep 1
    puts ns_low[n[0]+5]
    play ns_low[n[0]+5],
      attack: 1,
      release: 4,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: 5
  end
  
  
  live_loop :choir2 do
    n = sync 'base'
    sleep 3
    puts ns_low[n[0]+9]
    play ns_low[n[0]+9],
      attack: 1,
      release: 3,
      pan: (ring -0.5, 0, 0.5).choose,
      pan_slide: 4
    
  end
end

