function compute_step()
  % initialization
  w_i_hb = [ 1.4 0.4 0.0; -2.0 0.8 -0.6 ];
  w_h_ob = [ 2.1 -1.0 0.4; 1.0 1.1 -0.3 ];
  p =[-1;1];
  d = [0.3;0.3];
  
  alfa = 1.5;
  lambda = 2.0;
  
  % extend input for bias
  p = [p;1];
  
  % Outputs from the hidden layer
  hidden_inputs = [0;0];
  hidden_outputs = [0;0];
  for i = 1:2
    hidden_inputs(i) = dot(w_i_hb(i,:),p);
    hidden_outputs(i) = 1/(1+exp(-lambda * hidden_inputs(i)));
  end
  hidden_outputs = [hidden_outputs; 1];

  % Outputs from the output layer
  output_inputs = [0;0];
  output_outputs = [0;0];
  for i = 1:2
    output_inputs(i) = dot(w_h_ob(i,:), hidden_outputs);
    output_outputs(i) = 1/(1+exp(-lambda * output_inputs(i)));
  end
  
  % Deltas from the output layer
  deltas_output = [0;0];
  for i = 1:2
    y = output_outputs(i);
    deltas_output(i) = (d(i) - y) * lambda * y * (1-y);
  end
  
  % Deltas from the hidden layer
  deltas_hidden = [0;0];
  for i = 1:2
    y = hidden_outputs(i);
    deltas_hidden(i) = dot(deltas_output, w_h_ob(:,i)) * lambda * y * (1-y);
  end
  
  % Adjustments in the output_layer
  new_w_h_ob = w_h_ob;
  for i = 1:2
    for j = 1:3
      new_w_h_ob(i,j) += (alfa * deltas_output(i) * hidden_outputs(j));
    end  
  end
  
  % Adjustments in the hidden layer
  new_w_i_hb = w_i_hb;
  for i = 1:2
    for j = 1:3
      new_w_i_hb(i,j) += (alfa * deltas_hidden(i) * p(j));
    end
  end    
  
  printf('New weights input->hidden layer\n')
  new_w_i_hb
  
  printf('New weights hidden->output layer\n')
  new_w_h_ob
end