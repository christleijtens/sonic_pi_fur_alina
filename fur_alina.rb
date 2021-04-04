use_debug false
set_volume! 4

home_dir = "/Users/christleijtens/project/private/Sonic Pi experiments/sonic_pi_fur_alina/"
samps_dir = home_dir + "samps/"

run_file home_dir + "clitc_sonic_pi_lib.rb"
run_file home_dir + "fur_alina_house_lib.rb"
run_file home_dir + "fur_alina_relax_lib.rb"

far_config = {
  
  "samps_dir" => samps_dir,
  "volume" => 2.0,
  "bpm" => 80,
  "delay" => 4,
  "instrument" => "celesta_hard",
  
  "instruments" => {
    
    "celesta_hard" => {
      "wav" => "celesta-e5-hard-PB.wav",
      "note" => :E5,
      "vol" => 0.4
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
  },
  
  "background_sounds" => {
    
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
        "delay" => 0
      },
      "tropical" => {
        "samp" => "tropical-forrest.wav",
        "amp" => 0.2,
        "pan" => 0.0,
        "delay" => 0
      }
    }
  }
  
} # far_config.



fah_config = {
  
  "synth" => :hollow,
  "bpm" => 120,
  "volume" => 2,
  "delay" => 8
}

puts ""
puts ">>> Für Alina by Arvo Pärt - Sonic Pi version by Christ Leijtens"
puts ""

fur_alina_house fah_config

fur_alina_relax far_config

far_config["instrument"] = "cor_anglais"
far_config["delay"] = 0
fur_alina_relax far_config

fah_config["synth"] = :dark_ambience
fah_config["delay"] = 0
fur_alina_house fah_config

puts ""
puts "<<< Thank your for listening."
puts ""

