function C = ComputePoints(student_result, max_points, assign_weight)
   
  # remove cells
  assignments_pts = cell2mat(student_result(1));
  tests_perc = cell2mat(student_result(2));
  exam_perc = cell2mat(student_result(3));
  
  # compute percent from assignments (do not exceed 100%)
  assign_total = sum(assignments_pts);
  if (assign_total > max_points)
    assign_perc = 1;
  else
    assign_perc = (assign_total/max_points);
  end
  
  # return
  C = (assign_perc * assign_weight) + sum(tests_perc) + (exam_perc);
end;  