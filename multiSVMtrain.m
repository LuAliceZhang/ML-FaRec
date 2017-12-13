function [ multiSVMstruct ] =multiSVMtrain( traindata,nclass,gamma,c)
%多类别的SVM训练器
%   Detailed explanation goes here
global m;
m=70;
for i=1:nclass-1
    for j=i+1:nclass
        X=[traindata(m*(i-1)+1:m*i,:);traindata(m*(j-1)+1:m*j,:)];
        Y=[ones(m,1);zeros(m,1)];
        multiSVMstruct{i}{j}=svmtrain(X,Y,'Kernel_Function',@(X,Y) kfun_rbf(X,Y,gamma),'boxconstraint',c);
    end
end
end

