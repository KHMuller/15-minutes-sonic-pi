# 15 Minutes
# Monday 27th of December
# A bit more than 15 minutes ;) though

##| sample :ambi_choir
##| sample :ambi_piano
##| sample :ambi_haunted_hum
##| sample :ambi_glass_rub
##| sample :ambi_glass_hum
##| sample :ambi_drone

## 3 4 5 6 7 1 2 3 4 5 6 7 1 2 3
## c d e f g a b c d e f g a b c

## Added default :hpf and :lpf because having some artificial crackling and clicks on TV
## :ambi_haunted_hum, :ambi_glass_rub, :ambi_glass_hum,

with_fx(:hpf, pre_amp: 20, cutoff: 40) do
  with_fx(:lpf, pre_amp: 20, cutoff: 90)  do
    live_loop :beat do
      sample :bd_tek, amp: 1, attack: 0.05, release: 0.245 #if (spread 1, 4).tick
      sleep 4
    end
    with_fx :reverb do
      live_loop :chill do
        sync :beat
        sp_name = (ring :ambi_haunted_hum, :ambi_glass_hum, :ambi_drone).choose
        sample sp_name, cutoff: rrand(60, 90), rate: 1 * choose([0.5, 1, 1.5]), pan: rrand(-1, 1), pan_slide: [1, 2].choose, amp: [0.5, 0.6, 0.7, 0.8].choose
        puts sample_duration sp_name
      end
      
      live_loop :mychords do
        with_synth :fm do
          sync :beat
          chord_name = [:a2, :e3, :d3, :c3, :a3, :a2].tick
          play chord(chord_name, :minor).choose, cutoff: rrand(50, 90), amp: [0.3, 0.4, 0.5].choose, attack: 0.5, release: rrand(1, 4), cutoff_max: 90
          puts chord_name
        end
      end
    end
  end
end
