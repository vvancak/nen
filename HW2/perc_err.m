function e = perc_err(p,x,c)
  [p_rows, p_cols] = size(p);
  [x_rows, x_cols] = size(x);
  
  # extend x for threshold
  if (x_rows < p_cols)
    x = [x', ones(x_cols,1)]';
  end
  
  e=zeros(1,x_cols);
  for i=1:x_cols
    # squaring the difference unifies +1 and -1 (both count as one wrong output)
    e(i) = (perc_recall(p,x(:,i)) - c(i))^2;
  end  

  # sum the wrong outputs
  e = sum(e);
end  