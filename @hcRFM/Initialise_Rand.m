function Initialise_Rand( obj )
%INITIALISE Prepares the structure for sampling
% Exact behaviour depends on initialisation mode
%
% James Lloyd, June 2012
  
  %%%% TODO - replace this with a case statement - e.g. run simple model,
  %%%% take external input, sequential initialisation
  
  obj.Init_U_Rand
  obj.Init_V_Rand
  obj.Init_pp_T;
  
  % Create bulky memory items etc
  
  obj.Init_Cache;

end

