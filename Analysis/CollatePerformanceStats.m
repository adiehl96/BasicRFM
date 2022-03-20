function CollatePerformanceStats( params, folder )
%COLLATEPERFORMANCESTATS Summary of this function goes here
% Detailed explanation goes here
%
% James Lloyd, July 2012
  if nargin == 0
    params = [];
  end
  if nargin < 2
    folder = 'SavedExperiments';
  end
  error_stat = value_or_default(params, 'error_stat', 'AUC');
  data_matrix = value_or_default(params, 'data_matrix', 'UU');
  filters = value_or_default(params, 'filters', cell(0));
  row_filters = value_or_default(params, 'row_filters', cell(0));
  col_filters = value_or_default(params, 'col_filters', cell(0));
  
  files = dir(folder);
  table_sum = zeros(length(row_filters), length(col_filters));
  table_count = zeros(length(row_filters), length(col_filters));

  % Loop through files - assumes they are ordered
  sum_stats = 0;
  sum_files = 0;
  last_name = '';
  
  for i = 1:length(files)
    matches_filter = true;
    for j = 1:length(filters)
      if isempty(strfind(files(i).name, filters{j}))
        matches_filter = false;
      end
    end
    % Check that we have a file matching the filter
    if matches_filter && (~files(i).isdir)
      % Extract text
      name  = files(i).name(1:end-9);
%       fold  = files(i).name(end-8);
%       folds = files(i).name(end-5);
      % Do we have a new file - or have we finished?
      if (~strcmp(last_name, name)) || (i == length(files))
        % Finished processing a file - output
        fprintf ('%s : %s : %0.4f\n', last_name, error_stat, sum_stats / sum_files);
        % Reset counts
        sum_stats = 0;
        sum_files = 0;
        last_name = name;
      end
      % Still have same file - increment counts
      sum_files = sum_files + 1;
      vars = load([folder '/' files(i).name], 'Performance'); %#ok<NASGU>
      %%%% TODO - expand this section considerably
      eval(['statistic = vars.Performance.' data_matrix '{1}.' error_stat ';'])
      sum_stats = sum_stats + statistic;
      % Now add to the table if we have a matching entry
      matches_row = false;
      matches_col = false;
      row_index = 0;
      col_index = 0;
      for j = 1:length(row_filters)
        if ~isempty(strfind(files(i).name, row_filters{j}))
          matches_row = true;
          row_index = j;
        end
      end
      for j = 1:length(col_filters)
        if ~isempty(strfind(files(i).name, col_filters{j}))
          matches_col = true;
          col_index = j;
        end
      end
      if matches_row && matches_col
        table_sum(row_index, col_index)   = table_sum(row_index, col_index)   + statistic;
        table_count(row_index, col_index) = table_count(row_index, col_index) + 1;
      end
    end
  end
  % Now display the table
  %%%% TODO - output LaTeX
  fprintf('\nFilters:\n');
  for i = 1:length(filters)
    fprintf('%s ', filters{i});
  end
  fprintf('\nError statistic:\n');
  fprintf('%s', error_stat);
  fprintf('\n           ');
  for i = 1:length(col_filters)
    fprintf(' %10s', col_filters{i}(1:min(end,10)));
  end
  for i = 1:length(row_filters)
    fprintf('\n %10s', row_filters{i}(1:min(end,10)));
    for j = 1:length(col_filters)
      if table_count(i, j) > 0
        fprintf('     %0.4f', table_sum(i, j) / table_count(i, j));
      else
        fprintf('    No data');
      end
    end
  end
  fprintf('\n');
  
  imagesc(table_sum ./ table_count);
  
end

