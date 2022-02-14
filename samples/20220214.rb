# 15 Minutes
# 14th of February
# A new start

use_debug false
use_bpm 90
use_random_seed 1000
sleep 1

live_loop :foo do
  with_fx :reverb, kill_delay: 0.2, room: 0.3 do
    use_synth :fm
    4.times do
      use_random_seed 900
      8.times do
        sleep 0.25
        play chord(:e3, :m7).choose, release: 0.1, pan: rrand(-1, 1, res: 0.9), amp: 1
      end
    end
  end
end

live_loop :baz, auto_cue: false do
  tick
  sleep 0.25
  cue :beat, count: look
  sample :bd_haus, amp: factor?(look, 8) ? 2 : 1, cutoff: 80
  sleep 0.25
  use_synth :fm
  play :e2, release: 1, amp: 1 if factor?(look, 4)
  synth :bnoise, release: 0.051, amp: 0.5, cutoff: 60
end

notes = (scale :e3, :minor)

with_fx :reverb do
  live_loop :repeating_melody do
    use_random_seed 200
    use_synth :pretty_bell
    8.times do
      sleep 0.25
      play notes.choose, release: 0.1 if (spread 3, 4).tick(:aticker)
    end
  end
end
