function pn = perc_update(p, x, c, lam) 
  [p_rows p_cols] = size(p);
  [x_rows x_cols] = size(x);
  
  # extend x for threshold
  if (x_rows < p_cols)
    x = [x', ones(x_cols,1)]';
  end
  
  for i=1:x_cols
    
    # real & expected output
    real_out = perc_recall(p,x(:,i));
    exp_out = c(i);

    # update weights    
    diff = exp_out - real_out;
    p = p .+ (lam * diff * x(:,i))';
  end
  pn = p;
end