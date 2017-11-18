function P = HowManyPercent(TargetGrade,StudentResults, Boundaries, MaxPoints,PointsWeight,MaxExamScore)
  if (nargin < 6) 
    MaxExamScore=45;
  end;
  if (nargin < 5)
    PointsWeight = 35;
  end
  if (nargin < 4)
    MaxPoints=75;
  end
  if (nargin < 3)
    Boundaries=[86,71,56];
  end   
  
  # Just fourth "imaginary" boundary
  Boundaries = [Boundaries,0];
  
  # Compute total points gained so far (i.e. assuming student got 0 from the final test)
  getPointsWithoutTest = @(score) ComputePoints([cell2mat(score)(1),cell2mat(score)(2),0],MaxPoints, PointsWeight);
  pointsWithoutTest = arrayfun(getPointsWithoutTest, StudentResults);
  
  # For each of the values compute difference from the desired grade  
  remainingPoints = pointsWithoutTest;
  for i=1:length(pointsWithoutTest)
    remainingPoints(i) = Boundaries(TargetGrade(i))-pointsWithoutTest(i);
    
    # Student is under the limit (i.e. wants 4 and has some points)
    if (remainingPoints(i)< 0) 
      remainingPoints(i)=0;
    end  
    
    # Student is over the limit (i.e. has too few points)
    if (remainingPoints(i) > MaxExamScore)
      remainingPoints(i)=NaN;
    end  
  end  
  
  # return
  P=remainingPoints;
end  