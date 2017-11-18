function p=perc_create(n)
  # weights
  p=rand(1, n+1);

  # threshold
  p(n+1) = p(n+1)*-1;
end