# It's Monday 27th of December

##| sample :ambi_choir
##| sample :ambi_piano
##| sample :ambi_haunted_hum
##| sample :ambi_glass_rub
##| sample :ambi_glass_hum
##| sample :ambi_drone


## c d e f g a b c d e f g a b c

ramp_up = (ramp 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)

with_fx :reverb do
  with_fx(:echo, delay: 0.5, decay: 4) do
    live_loop :chill do
      tick
      sp_name = (ring :ambi_haunted_hum, :ambi_glass_rub, :ambi_glass_hum, :ambi_drone).choose
      sample sp_name, cutoff: rrand(70, 130), rate: 1 * choose([0.5, 1]), pan: rrand(-1, 1), pan_slide: [1, 2].choose, amp: ramp_up.look
      sleep sample_duration sp_name
      puts sample_duration sp_name
      chord_name = [:a2, :e2, :d2, :c2, :a3, :b3].choose
      play chord(chord_name, :minor).choose, cutoff: rrand(40, 100), amp: ramp_up.look, attack: 0, release: rrand(1, 3), cutoff_max: 110
      sleep [0.25, 0.5, 0.5, 0.5, 1, 1].choose
    end
  end
end
