function [ value ] = value_or_default( options,label,default )
%VALUE_OR_DEFAULT Uses value in options or default
% if options.label exists then 
%   value = options.label
% else
%   value = default
%
% James Lloyd, June 2012

if isfield(options,label)
  if ~isempty(getfield(options,label))
    value = getfield(options,label);
  else
    value = default;
  end
else
  value = default;
end

end

