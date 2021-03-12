# It's Monday
# 15th of February 2021
# Random

# https://sonic-pi.net/tutorial
# https://sonic-pi.mehackit.org/exercises/en/01-introduction/01-introduction.html

i = 0

use_bpm 60
ns = (scale :a3, :minor_pentatonic, num_octaves: 3)

series = (ring 5, 3, 6, 0)

live_loop :random do
  i += 1
  i = 0 if i > (ring 3, 5, 7, 9).choose
  
  use_synth :sine
  with_fx :reverb, room: 1 do
    with_fx :ixi_techno do
      a_note = ns.choose
      play ns.choose, amp: 0.00
      #play ns[i], amp: 0.05
      #play ns[i+3], amp: 0.05
      #play ns[i+12]+1, amp: 0.05
      #play ns[i+15]+1, amp: 0.05
    end
  end
  
  
  use_synth :dsaw
  with_fx :reverb, room: 0.5 do
    play chord(:a2 + series.tick, :minor7, num_octaves: 3),
      attack: 0.01, release: rrand(0.15, 0.25),
      pan: rrand(0.5, 0.5), #check pan values!
      amp: rrand(0.01, 0.01)
    sleep 0.25
  end
end

noises = [:pnoise, :bnoise, :cnoise]

live_loop :bg do
  stop
  with_fx :echo, mix: 0.2 do
    with_fx :wobble, mix: 0.5 do
      use_synth :blade
      play ns.choose, amp: 0.12, attack: 0.01, sustain: 9, release: 0, cutoff: 80
      sleep 9
    end
  end
end






