function Init_U_MAP( obj )
%INIT_U_Rand Heuristic to improve current U
% Write a description of all variables here
%
% James Lloyd, June 2012

  for i = 1:size(obj.U, 1)
    i
    for j = 1:size(obj.U, 1)
      % Try moving U_i to U_j - is it better?
      llh = obj.Cond_llh_U(i, []);
      U_i = obj.U(i, :);
      obj.U(i, :) = obj.U(j, :);
      if obj.Cond_llh_U(i, []) <= llh
        % Not better - reset i.e. don't update
        obj.U(i, :) = U_i;
        % Call llh to update cache
        obj.Cond_llh_U(i, []);
      end
    end
  end
end

