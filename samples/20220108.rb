# 15 Minutes
# 8th of January 2022
# Cello/Violin Impro
# Switching On/Off Stuff
# Listen to it on https://muuuh.com/sounds/


ns_low = (scale :a2, :minor, num_octaves: 3)
coff = 85

use_synth :blade
with_fx :reverb, room: 0.5, mix: 0.7 do
  
  
  live_loop :violin do
    n = sync 'master2violin'
    note = n[0]
    length = n[1]
    the_pan = (ring -0.5).choose
    the_amp = n[2]
    the_att = 0.05
    # coff 85 sounds like horns
    coff = 110
    play note + 12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 37,
      mod_range: 0,
      amp: the_amp
    play note + 24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 37,
      mod_range: 0,
      amp: the_amp/2
    play note + 36,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 37,
      mod_range: 0,
      amp: the_amp/4
  end
  
  live_loop :cello do
    n = sync 'master2cello'
    note = n[0]
    length = n[1]
    the_pan = (ring 0.5).choose
    the_amp = n[2]
    the_att = 0.5
    coff = note + 24 + 1
    play note,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 13,
      mod_range: 0,
      amp: the_amp
    play note + 12,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 25,
      mod_range: 0,
      amp: the_amp/2
    play note+24,
      attack: the_att,
      release: length-the_att,
      pan: the_pan,
      cutoff: note + 37,
      mod_range: 0,
      amp: the_amp/4
  end
end

# values in motif ring must sum up to 1, 0 counts as 0.125
motifs = (ring
          (ring 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125),
          ##(ring 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.0625, 0.0625, 0.125),
          ##(ring 0.25, 0.125, 0.125, 0.25, 0.125, 0.125),
          )

live_loop :violinwithmotifs do
  tick_set :motif, 0
  tick_set :shift, 0
  shift = (ring 3)
  shift = (ring 3, 7)
  shift = (ring 3, 7, 10)
  shift = (ring 0, 3, 7, 10, 12)
  shift = (ring 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
  n = sync :violinmotif, n
  
  
  total = 0
  n[1].times do
    motif = motifs.choose
    total = 0
    while (total < 1)
      l =  motif.tick(:motif)
      if l > 0 then
        total = total + l
        cue 'master2violin', n[0] + shift.tick(:shift), l, n[2]
        ##cue 'master2violin', n[0] + shift.choose, l, n[2]
      else
        total = total + 0.125
        sleep 0.125
      end
      sleep l
    end
  end
end



live_loop :drums do
  ##sample :bd_tek, amp: 0.4, release: 0.125, pitch: 0
  sleep 0.5
end

turnon = (ramp *range(0.5, 1, 0.05))
turnoff = (ramp *range(1, 0, 0.05))

live_loop :master do
  # select length and base note
  ##| tick_set :basemotif, 0
  ##| tick_set :basescale, 0
  ns_low = (scale :c3, :minor, num_octaves: 1).mirror
  l = (ring 1, 1, 1, 1, 4, 1, 1, 1, 1, 4).tick(:basemotif)
  n = ns_low.tick(:basescale)
  ##n = ns_low.choose
  cue 'master2cello', n, l, 1
  cue 'violinmotif', n, l, 0
  ##cue 'violinmotif', n, l, turnon.tick(:turnonviolin)
  ##cue 'violinmotif', n, l, turnoff.tick(:turnoffviolin)
  sleep l
end
