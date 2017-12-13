function [f_matrix,realclass] = violajone(npersons,flag)
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

m=100;
n=30;

realclass=zeros(npersons*n,1);
if flag==0
    f_matrix=zeros(npersons*m,imgrow*imgcol);
end

if flag==1
    f_matrix=zeros(npersons*n,imgrow*imgcol);
end
for i=8:npersons
    facepath='cacd/s';
    facepath=strcat(facepath,num2str(i));
    facepath=strcat(facepath,'/');
    cachepath=facepath;
    if flag==0
        for j=1:m
            facepath=cachepath; 
            facepath=strcat(facepath,num2str(j));
         %input the testing samples
         
            facepath=strcat(facepath,'.jpg');
            img1=imread(facepath);
            realclass((i-1)*m+j)=i;
       % img2=gray_comp(img1);
%         figure
%         imshow(img)
        if(size(img1)<3)
            dbstop error 
        end
        FaceDetector=buildDetector();
        [bbox,~,~,~] = detectFaceParts(FaceDetector,img1,2);     
        recFace.x=bbox(1,1);
        recFace.y=bbox(1,2);
        recFace.width=120;
        recFace.height=120;
        ptFaceCenter.x    = recFace.x + recFace.width / 2;
        ptFaceCenter.y    = recFace.y + recFace.height / 2;
        recFace.x         = ptFaceCenter.x - recFace.width * 0.4;
        recFace.y         = ptFaceCenter.y - recFace.height * 0.35;
        recFace.width     = recFace.width * 0.8 ;
        recFace.height    = recFace.height * 0.8 ;
        mFaceResult       = uint8(imcrop(img1,[recFace.x,recFace.y,recFace.width,recFace.height]));
        name=strcat(num2str(j),'.jpg');
        path=strcat('new/s',num2str(i));
        pat=strcat(path,'/');
        out=rgb2gray(mFaceResult);
        imwrite(out,[pat,name]);
        end 
    end
end
end
