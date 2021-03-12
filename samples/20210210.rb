# Library and Samples
# 10th of February 2021
# No Title

set :bpm, 100 #change requires restart command+s > command+r


##| kick_cutoffs = range(40, 80, 0.5).mirror
##| live_loop :kick do
##|   if (spread 1, 4).tick then
##|     sample :bd_tek, amp: master.look * 1, cutoff: kick_cutoffs.look
##|   end
##|   sleep 0.25 # 16th note heartbeat
##| end



live_loop :synth do
  stop # fade out a loop comment out if start
  sync :kick
  use_synth :hoover
  with_fx :reverb, mix: 0.7, amp: 0.1 do
    if (spread 3, 8).tick then
      play chord(:a2, :minor, num_octaves: 4), attack: 0.1, decay: 0.6, release: 0.3
      sleep 1
    end
    
  end
end

# Hollow sound randome around minor pentatonic a1
# Syncs with :kick
live_loop :mood do
  sync :kick
  use_synth :hollow
  ns = (scale :a1, :minor_pentatonic, num_octaves: 2)
  with_fx :reverb, mix: 0.7 do
    synth :hollow,
      note: ns.choose,
      attack: 3,
      release: 17,
      amp: 5
    sleep 20
  end
end


# Simple Piano beat
live_loop :my_piano do
  stop
  sync :kick
  use_synth :piano
  with_fx :reverb, mix: 0.7 do
    play :a3, attack: 0.01, decay: 0.2, release: 0.25, amp: (ring 0.25, 0.5).choose
    sleep 0.25
  end
end

##| live_loop :mood2 do
##|   sync :kick
##|   use_synth :bnoise
##|   with_fx :reverb, mix: 0.7 do
##|     sleep 3
##|     play choose([:e3,:f3]), attack: 1, decay: 1.9, release: 0.1, amp: (ring 0.1, 0.25).choose
##|   end
##| end


live_loop :riff do
  
  sync :kick
  use_synth :piano
  with_fx :reverb, mix: 0.2 do
    with_fx :ixi_techno do
      4.times do
        4.times do
          play :a4, release: 0.4, cutoff: 70, amp: 1
          sleep 0.5
          play :a4, release: 0.4, cutoff: 70, amp: 1
          sleep 0.5
          play :c5, release: 0.4, cutoff: 70, amp: 1
          sleep 0.5
          play :c4, release: 0.4, cutoff: 70, amp: 1
        end
        play :a3, release: 12, cutoff: 70, wave: 1, phase: 0.33, amp: 1
        sleep 14
      end
    end
  end
end

live_loop :mood3 do
  sync :kick
  use_synth :hollow
  with_fx :reverb, mix: 0.7 do
    sleep 6
    play choose([:c3,:e3]), attack: 1, decay: 1, release: 1, amp: 1
    sleep 1
  end
end

live_loop :mood4 do
  sync :kick
  use_synth :hollow
  with_fx :reverb, mix: 0.7 do
    sleep 6
    play choose([:e4,:g4]), attack: 1, decay: 1, release: 1, amp: 1
    sleep 1
  end
end


# Simple beat :kick
live_loop :kick do
  use_bpm get(:bpm)
  sample :bd_tek, amp: 0.3, release: 0.1
  sleep 0.9
end

