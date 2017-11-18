function [delta,s] = CrossVal(Name1,Name1L,Par1,Name2,Name2L,Par2,Pat,DOut,k,NoShuffle)
  [pat_rows pat_cols] = size(Pat);
  
  # generate permutation in which the patterns will be split
  if (nargin < 10)
    shuffle_pattern = randperm(pat_cols);
    Pat = Pat(:, shuffle_pattern);
    DOut = DOut(:, shuffle_pattern);
  end
  
  # folds sizes
  folds = {};
  folds_exp = {};
  
  fold_size = fix(pat_cols/k);
  fold_sizes_list = ones(1,k) .* fold_size;
  
  fold_size_border = k - mod(pat_cols,k) + 1;
  fold_sizes_list(fold_size_border:k) =  fold_sizes_list(fold_size_border:k).+ 1;
  
  # split into folds
  index = 0;
  for i=1:k
    current_fold = [];
    current_fold_exp = [];
    
    for j=1:fold_sizes_list(i)
      ++index;
      current_fold = [current_fold, Pat(:,index)];
      current_fold_exp = [current_fold_exp, DOut(index)];
    end  
    
    folds{i} = current_fold;
    folds_exp{i} = current_fold_exp;
  end
  
  # cross-validation
  error_deltas = [];
  for i = 1:k
    # i-th fold is testing set
    testing = folds{i};
    testing_exp = folds_exp{i};
    
    # rest are training sets  
    training = [];
    training_exp = [];
    for j = 1:k
      if (j==i) 
        continue
      end
      training = [training,folds{j}];
      training_exp = [training_exp, folds_exp{j}];
    end
    
    # compute errors
    first_error =  Err(Name1,Name1L,Par1,training,training_exp,testing,testing_exp);
    second_error =  Err(Name2,Name2L,Par2,training,training_exp,testing,testing_exp);
    error_deltas = [error_deltas, first_error - second_error];
  end  
    
  ex = mean(error_deltas);
  x_ex = arrayfun(@(x) (x-ex)^2, error_deltas);
  
  delta = ex;
  s = sqrt(1/(k-1) * mean(x_ex));
end