function E = Err(Name,NameL,Par,Tr,DTr,Ts,DTs)
  # train
  learned = feval(Name, Tr, DTr, Par);
  
  [test_rows, test_cols] = size(DTs);
  total_error = 0;
  
  # compute error
  for i = 1:test_cols;
    real = feval(NameL, learned, Ts(:,i));
    expected = DTs(i);
    
    if (real != expected)
      ++ total_error;
    end  
  end
  
  E = total_error/test_cols;
end