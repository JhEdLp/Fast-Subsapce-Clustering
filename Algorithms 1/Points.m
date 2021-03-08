function pts = Points(M,N,I,F,A)
Ps=[I:A:F];
pts=unique(round(M*N./Ps));
end