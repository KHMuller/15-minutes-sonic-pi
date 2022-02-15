# 15 Minutes
# 15th of February
# Minimal Progress

use_debug false
use_bpm 90
use_random_seed 1000
sleep 1

notes = (scale :d4, :minor_pentatonic)
notes_low = chord(:d2, :m7)

live_loop :foo do
  with_fx :reverb, kill_delay: 0.2, room: 0.3 do
    use_synth :fm
    4.times do
      use_random_seed 813
      8.times do
        sleep 0.25
        play notes_low.choose, release: 0.1, pan: rrand(-1, 1, res: 0.9), amp: 1
      end
    end
  end
end

live_loop :baz, auto_cue: false do
  tick
  cue :beat, count: look
  sample :bd_haus, amp: factor?(look, 8) ? 2 : 1, cutoff: 80
  sleep 0.25
  use_synth :fm
  play notes_low[0], release: 1, amp: 1 if factor?(look, 4)
  synth :bnoise, release: 0.051, amp: 0.5, cutoff: 60
  sleep 0.25
end

live_loop :repeating_melody do
  with_fx :reverb, kill_delay: 0.2, room: 0.3 do
    use_synth :pretty_bell
    n = [4, 4, 4, 4, 8, 8, 16].tick(:a2ticker)
    use_random_seed 700
    n.times do
      sleep 0.25
      play notes.choose, release: 0.1 if (spread 15, 16).tick(:aticker)
    end
    
  end
end
