function [ cell_x ] = RepeatCell( x, dims )
%RepeatCell Creates a cell with size = dims and all entries = x
% 
%
% James Lloyd, July 2012

  cell_x = cell(dims);
  for i = 1:numel(cell_x)
    cell_x{i} = x;
  end
  
end

