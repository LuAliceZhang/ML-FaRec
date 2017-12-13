clc,clear
npersons=10;%number of person is 40
global imgrow;
global imgcol;
%global edit2
global accuracy;
accuracy=zeros(1,10);
imgrow=97;% 97image row pixel
imgcol=97;% 97image column pixel

%set(edit2,'string','Read training data...')
%drawnow
disp('Read training data......')
disp('.................................................')
[f_matrix,trainclass]=read73(npersons,0);%read training data
nfaces=size(f_matrix,1);%number of sample faces

%set(edit2,'string','Training data PCA feature extraction ...')
disp('Training data feature extraction...')
disp('.................................................')
%drawnow
mA0=mean(f_matrix);
mA=uint8(mA0);
k=10;%reducing dimensionality to k
[pcaface,V]=fastPCA(f_matrix,k,mA);%feature extraction using PCA

%set(edit2,'string','Training feature data normalization...')
disp('Training feature data normalizaition......')
disp('.................................................')
%drawnow
lowvec=min(pcaface);
upvec=max(pcaface);
scaledface = scaling( pcaface,lowvec,upvec);






%disp('SVMsamples training......')
%disp('.................................................')
%%set(edit2,'string','SVM sample training......')
%%drawnow
%gamma=0.0078;%best parameters
%c=20;
%multiSVMstruct=multiSVMtrain( scaledface,npersons,gamma,c);
%save('recognize.mat','multiSVMstruct','npersons','k','mA','V','lowvec','upvec');





disp('read test data......')
disp('.................................................')
%set(edit2,'string','Read test data......')
%drawnow
[testface,realclass]=read73(npersons,1);
%testface=ReadFace(npersons,1);

%set(edit2,'string','Test data reducing dimension......')
%drawnow
disp('Test data feature dimension reduction......')
disp('.................................................')
m=size(testface,1);
for i=1:m
    testface(i,:)=testface(i,:)-mA;
end
test=double(testface);
pcatestface=test*V;

%set(edit2,'string','Test feature data normalization......')
%drawnow
scaledtestface = scaling( pcatestface,lowvec,upvec);








disp('SVM sample classification...')
disp('.................................................')
%set(edit2,'string','SVM sample classify......')
%drawnow



x=zeros(20,1);
y=zeros(20,1);
for i = 1:20
    class = knnclassify(scaledtestface,scaledface,trainclass,i,'cosine','consensus');
    accuracy(i)=sum(class==realclass)/length(class);
    x(i) = i;
    y(i) = accuracy(i);
end
%set(edit2,'string','Accuracy:')


plot(x,y)
xlabel('K-number') % x-axis label
ylabel('Accuracy') % y-axis label


%{
class = knnclassify(scaledtestface,scaledface,trainclass,5,'euclidean','nearest');



accuracy=sum(class==realclass)/length(class);
msgbox(['Recognition Accuracy:',num2str(accuracy*100),'%'])
%}
