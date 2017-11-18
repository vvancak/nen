function pn = perc_learn(p,x,c,lam,maxit)
  [p_rows, p_cols] = size(p);
  [x_rows, x_cols] = size(x);
  
  # extend x for threshold
  if (x_rows < p_cols)
    x = [x', ones(x_cols,1)]';
  end
  
  for i = 1:maxit
    if (perc_err(p,x,c) == 0) 
      break;
    end
    
    p = perc_update(p,x,c,lam);  
  end
  pn=p;
end