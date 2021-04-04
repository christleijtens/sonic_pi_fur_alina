#
# A library of usefull functions to be used when developing music with Sonic Pi.
#

#
# This defines a function which takes a hash with background
# sounds configurations as input and plays them in different threads.
# Each sound sample's lenght is calculated against the total number of
# beats requested for the background sounds to last.
# It then repleats full length samples and finishes with a partial sample
# play to full up the amount of beats requested where it fades out at
# the end.
#
define :clitc_play_background_sounds do | samp_hash |
  
  puts ""
  puts ">>> :far_start_background_sounds"
  puts ""
  puts "  - num_beats_total = " + samp_hash["num_beats_total"].to_s
  
  samp_hash["sounds"].each do | samp_name, samp_ref |
    
    if samp_ref["samp"].class.to_s == "String" then
      samp = samp_hash["samps_dir"] + samp_ref["samp"]
    else
      samp = samp_ref["samp"]
    end
    
    puts ""
    puts "   - samp = " + samp.to_s
    
    num_beats_sample = sample_duration(samp)
    
    puts "   - num_beats_sample = " + num_beats_sample.to_s
    puts "   - delay = " + samp_ref["delay"].to_s
    
    num_beats_sample -= samp_ref["delay"]
    
    if num_beats_sample > samp_hash["num_beats_total"] then
      puts "   - num_beats_sample > num_beats_total"
      n_finish = ( samp_hash["num_beats_total"] / num_beats_sample )
      n_repeat = 0
    else
      n_div = samp_hash["num_beats_total"] / num_beats_sample
      puts "   - n_div = " + n_div.to_s
      n_repeat = n_div.floor
      n_finish = n_div - n_repeat
    end
    
    puts "   - n_repeat = " + n_repeat.to_s
    puts "   - n_finish = " + n_finish.to_s
    
    in_thread(name: clitc_thread_prefix + "far_background_sound_" + samp_name) do
      
      sleep samp_ref["delay"]
      
      n_repeat.times do
        
        sample samp, amp: samp_ref["amp"], pan: samp_ref["pan"]
        sleep num_beats_sample
        
      end # n_repeat.times
      
      sample samp, finish: n_finish, release: samp_hash["fadeout"], amp: samp_ref["amp"], pan: samp_ref["pan"]
      
    end # in_thread
    
  end # samp_hash.each
  
  puts "<<<"
  
end # define :clitc_play_background_sounds


#
# This function just takes date and time to generate a prefix to be used with named thread
# so that they get a unique value. This is required when playing the same code within an
# already loaded thread.
#
define :clitc_thread_prefix do
  
  return Time.now.strftime("%Y%m%d_%H-%M-%S_")
  
end # :clitc_thread_prefix

#
# playwavnote:
#
# Below code (:playwavnote) is from Joe McCarty.
#   (https://in-thread.sonic-pi.net/u/joemac/summary)
#
# It takes a whole lot of parameters to tweak how a single note is played based
# on an external WAV sample.
#

halftone = Math.log(2.0) / 12.0
octtone = Math.log(2.0)
centtone = halftone / 100.0
tempo = 1.0

define :clitc_playwavnote do |samp, samp_pitch, pitch, time, cents = 0.0, amp = 1.0, pan = 0.0|
  
  a = note samp_pitch
  if a != nil
    
    b = note pitch
    
    if b != nil
      
      r = Math.exp( (b - a) * halftone + cents * centtone)
      sample samp, rate: r, attack: 0.1,
        sustain: tempo * time * 1,
        release: tempo * time * 2.0 / 3.0, amp: amp , pan: pan
      
    end
  end
  
  sleep tempo * time
  
end # define :playwavenote
