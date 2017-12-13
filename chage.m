clc,clear
npersons=8;%number of person is 40
global imgrow;
global imgcol;
%global edit2
imgrow=250;% image row pixel
imgcol=250;% image column pixel
disp('read data');


%set(edit2,'string','Read training data...')
%drawnow
disp('Read training data......')
disp('.................................................')
f_matrix=violajone(npersons,0);%read training data
nfaces=size(f_matrix,1);%number of sample faces
disp('end')
