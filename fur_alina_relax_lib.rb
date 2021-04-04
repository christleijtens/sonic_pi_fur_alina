# Für Alina by Arvo Pärt - Sonic Pi - relax version

define :fur_alina_relax_background_sound do | samp_hash, beats_total |
  
  samp_hash["num_beats_total"] = beats_total
  clitc_play_background_sounds samp_hash
  
end # define :fur_alina_relax_background_sound



define :fur_alina_relax_rhythm do |volume, num_beats|
  
  #sample :ambi_drone, pitch: -12, amp: volume
  sample :bd_tek, pan: -1, amp: volume
  sleep 1
  
  (num_beats - 1).times do
    sample :bd_haus, pan: 1, amp: volume
    sleep 1
  end
  
end # define :fur_alina_relax_rhythm



define :fur_alina_relax_melody do | instrument, volume |
  
  fur_alina_right_hand = [
    :r,
    :Cs5, :D5,
    :E5, :Fs5, :Fs5,
    :E5, :D5, :Cs5,
    :B4,
    :Fs5, :E5, :Fs5, :D5,
    :E5,
    :D5, :Fs5, :B5, :Cs6, :B5,
    :D5,
    :E5, :D5, :B4, :D5, :Fs5, :D5,
    :E5,
    :Fs5, :D6, :Cs6, :B5,
    :B4, :Fs5, :G5,
    :A5,
    :D5, :E5, :B4, :Cs5, :D5, :Cs5,
    :B4,
    :A5, :G5, :A5, :B4, :Cs5,
    :Fs5,
    :G5, :D5, :E5, :Fs5,
    :Fs5,
    :D5, :Cs5, :D4,
    :E4,
    :B3, :Fs4, :D5,
    :B4, :D4,
    :B4, :Cs5, :B4
  ]
  
  fur_alina_left_hand = [
    :r,
    :B4, :B4,
    :D5, :D5, :D5,
    :D5, :B4, :B4,
    :Fs4,
    :D5, :D5, :D5, :B4,
    :D5,
    :B4, :D5, :Fs5, :B5, :Fs5,
    :B4,
    :D5, :B4, :Fs4, :B4, :D5, :B4,
    :D5,
    :D5, :B5, :B5, :Fs5,
    :Fs4, :D5, :Fs5,
    :Fs5,
    :B4, :D5, :Fs4, :B4, :B4, :B4,
    :Fs4,
    :fs5, :Fs5, :Fs5, :Fs4, :B4,
    :D5,
    :Fs5, :B4, :D5, :D5,
    :Cs5,
    :B4, :Fs4, :B3,
    :D4,
    :Fs3, :D4, :B4,
    :Fs4, :B3,
    :Fs4, :B4, :Fs4
  ]
  
  # total 111 beats
  fur_alina_timings = [
    4, # 4 beats
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
  
  fur_alina_drums_timings = [
    5, 6, 3, 4, 4, 4, 5, 4, 6, 4, 4, 3, 4, 6, 4, 5, 4, 4, 4, 3, 4, 6, 5, 6 # 111 beats
  ]
  
  puts "WAV: " + instrument["wav"]
  puts "note: " + instrument["note"].to_s
  puts "volume: " + instrument["vol"].to_s
  
  in_thread(name: clitc_thread_prefix + "melody") do
    
    in_thread(name: clitc_thread_prefix + "bass") do
      with_synth :piano do
        with_fx :reverb, mix: 1.0, room: 1.0 do
          play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1
        end
      end
    end
    
    in_thread(name: clitc_thread_prefix + "right") do
      
      with_fx :reverb, mix: 1.0, room: 0.8, amp: volume do
        
        tick_reset
        
        fur_alina_right_hand.each do
          puts "Note right hand: " + fur_alina_right_hand[tick].to_s
          
          clitc_playwavnote instrument["wav"],             # samp
            instrument["note"],                            # samp_pitch
            fur_alina_right_hand[look],                    # pitch
            fur_alina_timings[look],                       # time
            0.0,                                           # cents
            instrument["vol"],                             # amp
            0.8                                            # pan
          
        end # fur_alina_right_hand.each
      end # with_fx :reverb
      
    end # in_thread :right
    
    in_thread(name: clitc_thread_prefix + "left") do
      
      with_fx :reverb, mix: 1.0, room: 0.8, amp: volume do
        
        tick_reset
        
        fur_alina_left_hand.each do
          
          puts "Note left hand: " + fur_alina_left_hand[tick].to_s
          
          clitc_playwavnote instrument["wav"],             # samp
            instrument["note"],                            # samp_pitch
            fur_alina_left_hand[look],                     # pitch
            fur_alina_timings[look],                       # time
            0.0,                                           # cents
            instrument["vol"],                             # amp
            -0.8                                           # pan
          
        end # fur_alina_left_hand.each
      end # with_fx :reverb
      
    end # in_thread :left
    
    in_thread(name: clitc_thread_prefix + "rhythm") do
      
      sleep 4
      
      tick_reset
      fur_alina_drums_timings.each do
        
        fur_alina_relax_rhythm volume, fur_alina_drums_timings[tick]
        
      end
    end # in_thread :rhythm
    
  end # in_thread :melody
  
end # define :fur_alina_relax_melody



#define :fur_alina_relax do | far_sleep = 8, instrument_name = "celesta_hard" |
define :fur_alina_relax do | far_config |
  
  use_bpm far_config["bpm"]
  
  puts "Instrument name: " + far_config["instrument"]
  
  in_thread(name: clitc_thread_prefix + "far_background") do
    
    fur_alina_relax_background_sound far_config["background_sounds"], 111 + far_config["delay"]
    
  end
  
  sleep far_config["delay"]
  
  in_thread(name: clitc_thread_prefix + "far_melody") do
    
    instrument = far_config["instruments"][far_config["instrument"]]
    instrument["wav"] = far_config["samps_dir"] + instrument["wav"]
    
    fur_alina_relax_melody instrument, far_config["volume"]
    
  end
  
  sleep ( 111 + far_config["delay"] )
  
end # define :fur_alina_relax


