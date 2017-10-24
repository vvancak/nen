function G = Grade(scores, boundaries)
  if (nargin < 2) 
    boundaries = [86,71,56];
  end;
  
  # For each score, find the first element of boundaries that is less or equal
  G = arrayfun(@(score) find([boundaries,0] <= score)(1), scores);
end  