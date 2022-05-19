function Initialise_PCA( obj )
%INITIALISE Prepares the structure for sampling
% Exact behaviour depends on initialisation mode
%
% James Lloyd, June 2012
  
  %%%% TODO - replace this with a case statement - e.g. run simple model,
  %%%% take external input, sequential initialisation
  
  %%%% Do the above!
  
  obj.Init_U_Rand;
  
  obj.Init_pp_T;
  
  % Create bulky memory items etc
  
  obj.Init_Cache;

end

