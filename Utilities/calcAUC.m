function [AUC,TPR,FPR]=calcAUC(P, O, A, Probs, Links)
% Calculates the Area Under Curve (AUC) of the Receiver Operating
% Characteristic (ROC)
%
% Usage:
%   [AUC,TPR,FPR] = calcAUC(P,O,A)
%     OR
%   [AUC,TPR,FPR] = calcAUC([],[],[],Probs,Links)
%   
% Input: 
%   P: Graph(s) of estimated probabilities of generating links in the graph
%      for entries treated as missing
%   O: Graph(s) of test point locations     
%   A: True graph(s)
%
%   %%% OR %%%
%   
%   Probs: Row vector of estimated probabilities
%   Links: Row vector of presence of links booleans
%
% Output:
%   AUC: The area under the ROC curve
%   TPR: True Positive Rate
%   FPR: False Positive Rate
%
% Written by Morten M�rup
%
% Modified by James Lloyd May 2012
%
% Modifications include
%  - Allowing different input types
%  - Explicit test locations
%  - Misc changes for readability / coding stlye

if nargin < 4
  %Probs and Links not given, construct them...

  if ~iscell(P)
    temp = cell(1);
    temp{1} = P;
    P = temp;
  end  
  if ~iscell(O)
    temp = cell(1);
    temp{1} = O;
    O = temp;
  end  
  if ~iscell(A)
    temp = cell(1);
    temp{1} = A;
    A = temp;
  end  

  Probs = []; % List of probabilities
  Links = []; % Link presence booleans at test locations
  for dd=1:length(A)
    Probs = [Probs; P{dd}(O{dd}(:))];
    Links = [Links; A{dd}(O{dd}(:))];
  end
end

if isempty (Probs)
  AUC = -1;
  TPR = -1;
  FPR = -1;
  return
end
  
% Sort vector of probabilities and links
[Probs, perm] = sort(Probs(:),'ascend');
Links = Links(perm);

% Denominators for FNR and TNR and initialise
N0 = sum(1-Links);
N1 = sum(Links);
FNR=[zeros(length(Links),1); 1];
TNR=[zeros(length(Links),1); 1];

% Calculate FNR and TNR
for k=2:length(Links)
  ii = find(Probs < Probs (k));    
  FNR(k) = sum(Links(ii)) / N1;
  TNR(k) = sum(1-Links(ii)) / N0;
end

% Calculate AUC by calculatig area under trapezoid
TPR = 1-FNR;
FPR = 1-TNR;
AUC = -trapz(FPR,TPR);


