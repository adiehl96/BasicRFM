function [ cell_x ] = MakeCell( x )
%MAKECELL Converts x to a cell if necessary
%   If cell
%     cell_x = x
%   else
%     cell_x{1} = x

  if ~iscell(x)
    cell_x = cell(1);
    cell_x{1} = x;
  else
    cell_x = x;
  end
  
end

