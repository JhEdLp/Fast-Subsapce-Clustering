function Ymember=Copy_of_New_main(F,Y,Xmember)

%% Normalization

F = F - mean(F(:));
F = F./std(F(:));

Y = Y - mean(Y(:));
Y = Y./std(Y(:));

%% Out-of-sample membership
Ymember = OutSample(F,Y,Xmember);
Ymember = Ymember';

end