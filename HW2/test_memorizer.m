function tm = test_memorizer()
  In2 = csvread('In2.csv');
  c2 = csvread('c2.csv');
  % in order to obtain the same answers from MemorizerRecall,
  % we reset random numbers generator
  rand("seed", "reset")
  
  % perceptron with 50 epochs
  Par = {perc_create(4), 1, 50};
  
  # run 6-fold cross-validation
  k=6;
  perc = 95;
  [d,s] = CrossVal('PLearn','PRecall',Par,'Memorizer','MemorizerRecall', Par,In2,c2,k, "NoShuffle");
  
  # evaluate results
  T = tinv((perc+100)/200,k-1);
  printf("interval: ")
  printf("<%f,%f>\n", (d-T*s) ,(d+T*s))
  
  printf("error difference: %f\n", d)
  printf("standard deviation: %f\n", s)
end