function c = perc_recall(p,x)
  [x_rows, x_cols] = size(x);
  [p_rows, p_cols] = size(p);
  
  # extend x for threshold
  if (x_rows < p_cols) 
    x=[x',1]';
  end
  
  # hard-limiting function
  c=(dot(p',x) >= 0);
end  