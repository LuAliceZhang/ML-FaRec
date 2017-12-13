function [f_matrix,realclass] = read73(npersons,flag)
%get the data from ORL database to matlab
%%Input:
%nperson---total number of person of samples
%num_train---the number of images for everyone
%num_test---the number of images for everyone
%imgrow --- the row pixel of image
%imgcol --- the column pixel of image
%imgrow=112; imgcol=92;
global imgrow;
global imgcol;
global m;
global n;

m=70;
n=30;

realclass=zeros(npersons*n,1);
if flag==0
    f_matrix=zeros(npersons*m,imgrow*imgcol,'uint8');
end

if flag==1
    f_matrix=zeros(npersons*n,imgrow*imgcol,'uint8');
end
for i=1:npersons
    facepath='new/s';
    facepath=strcat(facepath,num2str(i));
    facepath=strcat(facepath,'/');
    cachepath=facepath;
    if flag==0
        for j=1:m
            facepath=cachepath; 
            facepath=strcat(facepath,num2str(j));
         %input the testing samples
         
            facepath=strcat(facepath,'.jpg');
            img0=imread(facepath);
           % img1=rgb2gray(img0);
            realclass((i-1)*m+j)=i;
            f_matrix((i-1)*m+j,:)=img0(:);
 %      img2=rgb2gray(img1);
%         figure
%         imshow(img)
      %  img=rgb2gray(img1);
            disp(j);
        
        end 
    end
    if flag==1
        for j=1:n
            facepath=cachepath;
         %input the testing samples
            facepath=strcat(facepath,num2str(m+j));
            realclass((i-1)*n+j)=i;
   
        facepath=strcat(facepath,'.jpg');
        img0=imread(facepath);
            %img1=rgb2gray(img0);
%      img2=rgb2gray(img1);
%         figure
%         imshow(img)
        f_matrix((i-1)*n+j,:)=img0(:)';
        end
    end     
end
end