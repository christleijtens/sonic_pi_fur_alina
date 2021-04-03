use_debug false
set_volume! 4

home_dir = "/Users/christleijtens/project/private/Sonic Pi experiments/sonic_pi_fur_alina/"
samps_dir = home_dir + "samps/"

base_bpm = 120
use_bpm base_bpm

define :rhythm do |volume, n|
  
  with_fx :pan, pan: 0, amp: volume do
    
    #sample :ambi_drone, pitch: -12
    sample :bd_boom, pan: -1
    sleep 1
    
    (n - 1).times do
      sample :bd_klub, pan: 1
      sleep 1
    end
    
  end
  
end

print ""
print "  > Für Alina by Arvo Pärt a Sonic Pi version..."
print ""

define :ambient_tropical_sea do
  
  in_thread(name: :background) do
    
    in_thread do
      loop do
        sample :ambi_haunted_hum, amp: 0.5
        #sample :vinyl_hiss, amp: 1
        sleep 4
      end
    end
    
    #in_thread do
    #  loop do
    #    sample samps_dir + "gulfwaves.wav", amp: 0.1, pan: -1 # length 62 seconds
    #    sleep ( current_bpm / 60 ) * 62
    #  end
    #end
    
    #in_thread do
    #  loop do
    #    sample samps_dir + "tropical-forrest.wav", amp: 0.1, pan: 1 # length 154 seconds
    #    sleep ( current_bpm / 60 ) * 154
    #  end
    #end
    
  end
  
end # define :ambient_tropical_sea



define :fur_alina do
  
  fur_alina_score = [
    [:Cs5, :B4], [:D5, :B4], # bar 2
    [:E5, :D5], [:Fs5, :D5], [:Fs5, :D5], # bar 3
    [:E5, :D5], [:D5, :B4], [:Cs5, :B4], # bar 4
    [:B4, :Fs4], # bar 5
    [:Fs5, :D5], [:E5, :D5], [:Fs5, :D5], [:D5, :B4], # bar 6
    [:E5, :D5], # bar 7
    [:D5, :B4], [:Fs5, :D5], [:B5, :Fs5], [:Cs6, :B5], [:B5, :Fs5], # bar 8
    [:D5, :B4], # bar 9
    [:E5, :D5], [:D5, :B4], [:B4, :Fs4], [:D5, :B4], [:Fs5, :D5], [:D5, :B4], # bar 10
    [:E5, :D5], # bar 11
    [:Fs5, :D5], [:D6, :B5], [:Cs6, :B5], [:B5, :Fs5], # bar 12
    [:B4, :Fs4], [:Fs5, :D5], [:G5, :Fs5], # bar 13
    [:A5, :Fs5], # bar 14
    [:D5, :B4], [:E5, :D5], [:B4, :Fs4], [:Cs5, :B4], [:D5, :B4], [:Cs5, :B4], # bar 15
    [:B4, :Fs4], # bar 16
    [:A5, :Fs5], [:G5, :Fs5], [:A5, :Fs5], [:B4, :Fs4], [:Cs5, :B4], # bar 17
    [:Fs5, :D5], # bar 18
    [:G5, :Fs5], [:D5, :B4], [:E5, :D5], [:Fs5, :D5], # bar 19
    [:Fs5, :Cs5], # bar 20
    [:D5, :B4], [:Cs5, :Fs4], [:D4, :B3], # bar 21
    [:E4, :D4], # bar 22
    [:B3, :Fs3], [:Fs4, :D4], [:D5, :B4], # bar 23
    [:B4, :Fs4], [:D4, :B3], # bar 24
    [:B4, :Fs4], [:Cs5, :B4], [:B4, :Fs4] # bar 25
  ]
  
  # total 111 beats
  fur_alina_timings = [
    1, 4, # 5 beats
    1, 1, 4, # 6 beats
    1, 1, 1, # 3 beats
    4, # 4 beats
    1, 1, 1, 1, # 4 beats
    4, # 4 beats
    1, 1, 1, 1, 1, # 5 beats
    4, # 4 beats
    1, 1, 1, 1, 1, 1, # 6 beats
    4, # 4 beats
    1, 1, 1, 1, # 4 beats
    1, 1, 1, # 3 beats
    4, # 4 beats
    1, 1, 1, 1, 1, 1, # 6 beats
    4, # 4 beats
    1, 1, 1, 1, 1, # 5 beats
    4, # 4 beats
    1, 1, 1, 1, # 4 beats
    4, # 4 beats
    1, 1, 1, # 3 beats
    4, # 4 beats
    1, 1, 4, # 6 beats
    1, 4, # 5 beats
    1, 1, 4 # 6 beats
  ]
  
  in_thread(name: :melody) do
    
    with_synth :piano do
      with_fx :reverb, mix: 1.0, room: 1 do
        play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1, sustain: 20
        sleep 4
      end
    end
    
    with_synth :dark_ambience do
      with_fx :reverb, mix: 1.0, room: 0.5 do
        #with_fx :panslicer, wave: 1, mix: 1 do
        play_pattern_timed fur_alina_score, fur_alina_timings, amp: 2, attack_level: 3, attack: 0.5, sustain: 4
        #end
      end
    end
    
    with_synth :piano do
      with_fx :reverb, mix: 1.0, room: 1 do
        play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1, sustain: 20
        sleep 4
      end
    end
    
    with_synth :hollow do
      with_fx :reverb, mix: 1, room: 0.5 do
        with_fx :panslicer, wave: 1, mix: 1 do
          play_pattern_timed fur_alina_score, fur_alina_timings, amp: 1, attack_level: 1, attack: 0.5, sustain: 4
        end
      end
    end
    
  end
  
end # define :fur_alina

define :drums_line do
  
  fur_alina_drums_timings = [
    5, 6, 3, 4, 4, 4, 5, 4, 6, 4, 4, 3, 4, 6, 4, 5, 4, 4, 4, 3, 4, 6, 5, 6
  ]
  
  sleep 0.3
  in_thread(name: :drum) do
    
    loop do
      
      sleep 4
      
      tick_reset
      
      fur_alina_drums_timings.each do
        rhythm 2, fur_alina_drums_timings[tick]
      end
      
    end
    
  end
  
end

#
# Main program.
#

# Start the ambient background sound before the melody.
ambient_tropical_sea

# Sleep 8 beats before playing the melody.
sleep 8

# Play the melody.
fur_alina

drums_line