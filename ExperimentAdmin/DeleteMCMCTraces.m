function DeleteMCMCTraces( folder_name )
%DELETEMCMCTRACES Strips anything not called performance from all mat files
% Detailed explanation goes here
%
% James Lloyd, July 2012
  FileCell = getAllFiles(folder_name);
  for i = 1:length(FileCell)
    fprintf('Stripping %s\n', FileCell{i});
    load(FileCell{i});
    save(FileCell{i}, 'Performance');
    clear RFM
    clear MCMC
    clear Performance
  end
end

