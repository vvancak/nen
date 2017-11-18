function tw = test_perceptron()
  % at first we read training patterns; this should a matrix of size 2x600
  In1 = csvread("In1.csv");
  
  % then we read desired outputs for the training patterns (0/1 row vector of size 600)
  c1 = csvread("c1.csv");
  
  % a column In1(:,i) is the i-th training vector with the desired output c(i)
  % we prepare two sets (cell arrays) of the learning parameters
  % for the perceptron learning algorithm consisting of:
  % an extended weight vector,
  % a learning rate, and
  % a maximal number of epochs
  Par1 = {[1 1 -1], 1, 10};
  Par2 = {[1 1 -1], 1, 100};
  
  # run 5-fold cross-validation
  k=5;
  perc = 95;
  [d,s] = CrossVal('PLearn','PRecall',Par1,'PLearn','PRecall', Par2,In1,c1,k, "NoShuffle");
  
  # evaluate results
  T = tinv((perc+100)/200,k-1);
  printf("interval: ")
  printf("<%f,%f>\n", (d-T*s) ,(d+T*s))
  
  printf("error difference: %f\n", d)
  printf("standard deviation: %f\n", s)
end
