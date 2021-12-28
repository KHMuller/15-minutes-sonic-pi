# 15 Minutes
# Tuesday 28th of December 2021
# Issue with keeping the volume of a loop? Solved by playing it within a loop?


ns_low = (scale :a3, :minor_pentatonic, num_octaves: 1)
use_debug false

with_fx(:hpf, pre_amp: 40, cutoff: 40) do
  with_fx(:lpf, pre_amp: 40, cutoff: 90)  do
    live_loop :beat do
      sample :bd_tek, amp: 0.4, release: 0.125 if (spread 1, 4).tick
      sleep 0.125
    end
    
    live_loop :x do
      sync :beat
      use_synth :fm
      w = rrand(1, 5)
      play ns_low.choose, divisor: rrand_i(0, 8), depth: rrand_i(0, 8), attack: 0.1, release: w, amp: 0.1
      sleep w
    end
  end
end


r = range(1000,0,-1).ramp
puts r

with_fx(:hpf, pre_amp: 40, cutoff: 40) do
  with_fx(:lpf, pre_amp: 40, cutoff: 90)  do
    use_synth :mod_saw
    live_loop :whatsup do
      sync :beat
      if one_in(r.tick)
        4.times do
          n = rrand_i(4, 16)
          n.times do
            play (chord ns_low.choose, 'minor'), amp: 2, attack: (ring 0.01, 0.12).choose, release: 0.05
            sleep 0.0625
          end
          sleep rrand_i(1, 4)
        end
      end
      sleep 1
    end
  end
end

