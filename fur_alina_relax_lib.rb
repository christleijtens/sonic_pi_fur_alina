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



define :fur_alina_relax_melody do | instrument, volume, volume_drums |
  
  fur_alina_score = get[:fur_alina_score]
  fur_alina_timings = get[:fur_alina_timings]
  fur_alina_drums_timings = get[:fur_alina_drums_timings]
  
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
        
        fur_alina_score.each do
          puts "Note right hand: " + fur_alina_score[tick][1].to_s
          
          clitc_playwavnote instrument["wav"],             # samp
            instrument["note"],                            # samp_pitch
            fur_alina_score[look][1],                      # pitch
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
        
        fur_alina_score.each do
          
          puts "Note left hand: " + fur_alina_score[tick][0].to_s
          
          clitc_playwavnote instrument["wav"],             # samp
            instrument["note"],                            # samp_pitch
            fur_alina_score[look][0],                      # pitch
            fur_alina_timings[look],                       # time
            0.0,                                           # cents
            instrument["vol"],                             # amp
            -0.8                                           # pan
          
        end # fur_alina_left_hand.each
      end # with_fx :reverb
      
    end # in_thread :left
    
    in_thread(name: clitc_thread_prefix + "rhythm") do
            
      tick_reset
      fur_alina_drums_timings.each do
        
        fur_alina_relax_rhythm volume_drums, fur_alina_drums_timings[tick]
        
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
    
    instruments = get[:fur_alina_instruments]
    instrument = Hash.new.merge(instruments[far_config["instrument"]].to_h)
    instrument["wav"] = far_config["samps_dir"] + instrument["wav"]
    fur_alina_relax_melody instrument, far_config["volume"], far_config["volume_drums"]
    
  end
  
  sleep ( 111 + far_config["delay"] )
  
end # define :fur_alina_relax


