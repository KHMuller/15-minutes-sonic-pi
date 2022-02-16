# 15 Minutes
# 16th of February
# Sawing ... Hurting?

speed = 30

use_debug false
use_bpm speed
use_random_seed 1000
sleep 1

bn = :d2
notes = (scale bn + 24, :minor_pentatonic)
notes_low = chord(bn, :m7)

live_loop :foo do
  with_fx :reverb, kill_delay: 0.2, room: 0.3 do
    use_synth :mod_dsaw
    4.times do
      use_random_seed [500, 800, 700, 900].choose
      8.times do
        sleep 0.25
        play notes_low.choose, attack: 0.05, release: 0.245, pan: rrand(-0.5, 0.5), amp: 0.5
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
  #play notes_low[0], attack: 0.05, release: 1.95, amp: 2 if factor?(look, 4)
  #synth :bnoise, release: 0.051, amp: 0.5, cutoff: 60
  sleep 0.25
end




live_loop :repeating_melody1 do
  use_bpm speed*4
  with_fx :reverb, kill_delay: 0.2, room: 0.3 do
    use_synth :dsaw
    m = [4, 4, 4, 4, 8, 8, 16].tick(:rm1ticker)
    use_random_seed [500, 400, 300, 200, 100].choose
    (m*2).times do
      sleep 0.25
      l = rrand(0.1,0.25) / 2
      play notes.choose-12, attack: l, release: l, cutoff: rrand_i(80, 100), amp: factor?(look, 4) ? 1 : 0.5 if (spread 15, 16).tick(:aticker)
    end
  end
end

live_loop :repeating_melody do
  use_bpm speed*4
  with_fx :reverb, kill_delay: 0.2, room: 0.3 do
    use_synth :dsaw
    n = [4, 4, 4, 4, 8, 8, 16].tick(:rm0ticker)
    use_random_seed [700, 500, 800, 1100].choose
    (n*2).times do
      sleep 0.25
      l = rrand(0.1,0.25) / 2
      play notes.choose, attack: l, release: l, cutoff: rrand_i(80, 100), amp: factor?(look, 4) ? 1 : 0.5 if (spread 15, 16).tick(:aticker)
    end
  end
end
