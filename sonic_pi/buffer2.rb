## BUFFER2 - MIDI LOOP CONTROLLER ##

live_loop :midi_loop_controller do
  use_real_time
  
  note, vel = sync "/midi*/note_on"
  
  controller_mode = get(:controller_mode) || 0
  
  if controller_mode == 1
    
    bass_bank   = get(:bass_bank)   || []
    kick_bank   = get(:kick_bank)   || []
    melody_bank = get(:melody_bank) || []
    
    case note
    
    ## BOTAO 1 — BASS MODE
    when 60
      
      if bass_bank.length > 0
        mode = ((get(:bass_mode) || 0) + 1) % bass_bank.length
        set :bass_mode, mode
        print "Bass mode:", mode
      end
      
      ## BOTAO 2 — GROOVE MODE
    when 62
      
      if kick_bank.length > 0
        mode = ((get(:groove_mode) || 0) + 1) % kick_bank.length
        set :groove_mode, mode
        print "Groove mode:", mode
      end
      
      ## BOTAO 3 — MELODY MODE
    when 64
      
      if melody_bank.length > 0
        mode = ((get(:melody_mode) || 0) + 1) % melody_bank.length
        set :melody_mode, mode
        print "Melody mode:", mode
      end
      
    end
    
  end
  
end


live_loop :midi_bpm_knob do
  use_real_time
  
  cc, val = sync "/midi*/control_change"
  
  controller_mode = get(:controller_mode) || 0
  
  ## MODO LOOP PLAYER → controla BPM
  
  if controller_mode == 1 && cc == 1
    
    min = get(:bpm_min)
    max = get(:bpm_max)
    
    bpm = min + (val / 127.0) * (max - min)
    
    set :bpm, bpm.round
    
    print "BPM:", bpm.round
    
    
    
  end
  
end