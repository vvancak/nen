function S = Score(StudentResults,MaxPoints,PointsWeight)
  if (nargin < 3) 
    MaxPoints = 75;
  end;
  if (nargin < 2)
    PointsWeight = 35;
  end
  # For each element of the array, remove cell & compute points
  S = arrayfun(@(score) ComputePoints(cell2mat(score),MaxPoints, PointsWeight), StudentResults);
end