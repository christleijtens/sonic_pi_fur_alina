use_debug false
set_volume! 4

home_dir = "/Users/christleijtens/project/private/Sonic Pi experiments/sonic_pi_fur_alina/"
samps_dir = home_dir + "samps/"



define :far_start_background_sample do | samp_hash |
  
  puts "num_beats_total = " + samp_hash["num_beats_total"].to_s
  
  samp_hash["sounds"].each do | samp_name, samp_ref |
    
    if samp_ref["samp"].class.to_s == "String" then
      samp = samp_hash["samps_dir"] + samp_ref["samp"]
    else
      samp = samp_ref["samp"]
    end
    
    puts ""
    puts "samp = " + samp.to_s
    
    num_beats_sample = sample_duration(samp)
    
    puts "num_beats_sample = " + num_beats_sample.to_s
    puts "delay = " + samp_ref["delay"].to_s
    
    num_beats_sample -= samp_ref["delay"]
    
    if num_beats_sample > samp_hash["num_beats_total"] then
      puts "num_beats_sample > num_beats_total"
      n_finish = ( samp_hash["num_beats_total"] / num_beats_sample )
      n_repeat = 0
    else
      n_div = samp_hash["num_beats_total"] / num_beats_sample
      puts "n_div = " + n_div.to_s
      n_repeat = n_div.floor
      n_finish = n_div - n_repeat
    end
    
    puts "n_repeat = " + n_repeat.to_s
    puts "n_finish = " + n_finish.to_s
    
    in_thread(name: "far_background_sound_" + samp_name) do
      
      sleep samp_ref["delay"]
      
      n_repeat.times do
        
        sample samp, amp: samp_ref["amp"], pan: samp_ref["pan"]
        sleep num_beats_sample
        
      end # n_repeat.times
      
      sample samp, finish: n_finish, release: samp_hash["fadeout"], amp: samp_ref["amp"], pan: samp_ref["pan"]
      
    end # in_thread
    
  end # samp_hash.each
  
end # define :far_start_background_sample



define :fur_alina_relax_background_sound do | num_beats_total |
  
  samp_hash = {
    
    "num_beats_total" => num_beats_total,
    "fadeout" => 2,
    "samps_dir" => samps_dir,
    "sounds" => {
      
      "haunted" => {
        "samp" => :ambi_haunted_hum,
        "amp" => 0.2,
        "pan" => 0.0,
        "delay" => 0
      },
      "waves" => {
        "samp" => "gulfwaves.wav",
        "amp" => 0.2,
        "pan" => 0.0,
        "delay" => 4
      },
      "tropical" => {
        "samp" => "tropical-forrest.wav",
        "amp" => 0.2,
        "pan" => 0.0,
        "delay" => 4
      }
    }
  }
  
  far_start_background_sample samp_hash
  
end # define :fur_alina_relax_background_sound



define :fur_alina_relax_rhythm do |volume, num_beats|
  
  with_fx :pan, pan: 0, amp: volume do
    
    sample :ambi_drone, pitch: -12
    sample :bd_tek, pan: -1
    sleep 1
    
    (num_beats - 1).times do
      sample :bd_haus, pan: 1
      sleep 1
    end
    
  end
  
end # define :fur_alina_relax_rhythm



define :fur_alina_relax_melody do | instrument |
  
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
    4, 5, 6, 3, 4, 4, 4, 5, 4, 6, 4, 4, 3, 4, 6, 4, 5, 4, 4, 4, 3, 4, 6, 5, 6 # 111 beats
  ]
  
  puts "WAV: " + samps_dir + "/" + instrument["wav"]
  puts "note: " + instrument["note"].to_s
  puts "volume: " + instrument["vol"].to_s
  
  in_thread(name: :melody) do
    
    in_thread(name: :bass) do
      with_synth :piano do
        with_fx :reverb, mix: 1.0, room: 1.0 do
          play [:B0, :B1], amp: 5, attack_level: 5, attack: 0.01, pan: -1
        end
      end
    end
    
    in_thread(name: :right) do
      
      with_fx :reverb, mix: 1.0, room: 0.8, amp: 2.0 do
        
        tick_reset
        
        fur_alina_right_hand.each do
          puts "Note right hand: " + fur_alina_right_hand[tick].to_s
          
          playwavnote samps_dir + "/" + instrument["wav"], # samp
            instrument["note"],                            # samp_pitch
            fur_alina_right_hand[look],                    # pitch
            fur_alina_timings[look],                       # time
            0.0,                                           # cents
            instrument["vol"],                             # amp
            0.8                                            # pan
          
        end # fur_alina_right_hand.each
      end # with_fx :reverb
      
    end # in_thread :right
    
    in_thread(name: :left) do
      
      with_fx :reverb, mix: 1.0, room: 0.8, amp: 2.0 do
        
        tick_reset
        
        fur_alina_left_hand.each do
          
          puts "Note left hand: " + fur_alina_left_hand[tick].to_s
          
          playwavnote samps_dir + "/" + instrument["wav"], # samp
            instrument["note"],                            # samp_pitch
            fur_alina_left_hand[look],                     # pitch
            fur_alina_timings[look],                       # time
            0.0,                                           # cents
            instrument["vol"],                             # amp
            -0.8                                           # pan
          
        end # fur_alina_left_hand.each
      end # with_fx :reverb
      
    end # in_treah :left
    
  end # in_thread :melody
  
end # define :fur_alina_relax_melody



define :fur_alina_relax do | far_sleep = 8, instrument_name = "celesta_hard" |
  
  instruments_hash = {
    "celesta_hard" => {
      "wav" => "celesta-e5-hard-PB.wav",
      "note" => :E5,
      "vol" => 0.3
    },
    "cello_sustain" => {
      "wav" => "cello-sustain-4_Db-PB-loop.wav",
      "note" => :Db4,
      "vol" => 0.1
    },
    "tubularbells" => {
      "wav" => "tubularbells-4_Eb_p.wav",
      "note" => :Eb4,
      "vol" => 0.4
    },
    "cello_vibrato" => {
      "wav" => "cello-vibrato-4_Bb-PB.wav",
      "note" => :Bb4,
      "vol" => 0.1
    },
    "cello_tremulo" => {
      "wav" => "cello-tremulo-4_D_t-PB-loop.wav",
      "note" => :D4,
      "vol" => 0.5
    },
    "cor_anglais" => {
      "wav" => "cor-anglais-f4-PB-loop.wav",
      "note" => :F4,
      "vol" => 0.5
    }
  }
  
  use_bpm 80
  
  puts "Instrument name: " + instrument_name
  
  in_thread(name: :far_background) do
    
    fur_alina_relax_background_sound ( 111 + far_sleep )
    
  end
  
  sleep far_sleep
  
  in_thread(name: :far_melody) do
    
    fur_alina_relax_melody instruments_hash[instrument_name]
    
  end
  
end # define :fur_alina_relax


fur_alina_relax 4, "cor_anglais"
tick_reset_all
fur_alina_relax 8, "celesta_hard"

