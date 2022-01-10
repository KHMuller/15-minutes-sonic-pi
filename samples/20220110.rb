
# 15 Minutes
# 10th of January 2022
# Search - Looking for a new sound
# Pausing cello for a while ;)

all_s = (ring :beep,
         :blade,
         :bnoise,
         :chipbass,
         :chiplead,
         :chipnoise,
         :cnoise,
         :dark_ambience,
         :dpulse,
         :dsaw,
         :dtri,
         :dull_bell,
         :fm,
         :gnoise,
         :growl,
         :hollow,
         :hoover,
         :kalimba,
         :mod_beep,
         :mod_dsaw,
         :mod_fm,
         :mod_pulse,
         :mod_saw,
         :mod_sine,
         :mod_tri,
         :noise,
         :piano,
         :pluck,
         :pnoise,
         :pretty_bell,
         :prophet,
         :pulse,
         :rodeo,
         :saw,
         :sine,
         :square,
         :subpulse,
         :supersaw,
         :tb303,
         :tech_saws,
         :tri,
         :zawa)

with_fx :reverb, room: 0.5, mix: 0.7 do
  live_loop :choir do
    tick
    tick_set :slow,look/8 #tick(:slow) at 1/8th rate
    s= all_s.look(:slow)
    use_synth s
    n = rrand_i(40, 80)
    
    play n, cutoff: n+1, release: rrand(0.125, 0.2), amp: 0.5
    sleep 0.25
  end
end
