## BUFFER3 - MIDI SAMPLE CONTROLLER ##

live_loop :midi_sample_controller do
  use_real_time
  
  note, vel = sync "/midi*/note_on"
  
  controller_mode = get(:controller_mode) || 0
  
  if controller_mode == 2
    
    case note
    
    when 60
      set :sample_event, :impact
      
    when 62
      set :sample_event, :reverse
      
    when 64
      set :sample_event, :noise
      
    end
    
  end
  
end

live_loop :midi_fx_knob do
  use_real_time
  
  cc, val = sync "/midi*/control_change"
  
  controller_mode = get(:controller_mode) || 0
  
  if controller_mode == 2 && cc == 1
    
    fx = val / 127.0
    set :sample_fx, fx
    
    print "FX:", fx
    
  end
  
end