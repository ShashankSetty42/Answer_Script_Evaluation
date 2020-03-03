clc;
clear;
% close all;
I=imread('2.jpeg');
I1=I;
I=imresize(I,[512 512]);
% figure,imshow(I)
G=rgb2gray(I);
bw=im2bw(G,0.4);
bw=~bw;
for i=1:40
    bw(:,i)=0;
end
% figure,imshow(bw)
bw=~bw;
ocrResults=ocr(I1);
recognizedText = ocrResults.Text;
C = strsplit(recognizedText);
C{1,1}=[];
C{1,2}=[];
for i=1:length(C)
ss=isletter(C{1,i});
if sum(ss)>=1
    C{1,i}=[];
end
end
C1=C(~cellfun('isempty',C));
find(C1{1,1}=='*');

C2=C1{1,1};
C3=eval(C2);

k=1;
k1=1;
for i=2:length(C1)
    ss=str2num(C1{1,i});
    if ss==C3
        disp(' option is');
         i1=i;    
         i2=i-1
         k=k+1;
    
    end
     
    mm(k1,:)=ss;
    k1=k1+1;
 %       
end

C5=num2str(C3);
nn=strcmp(C1,C5);
if nn==0
    disp('not found');
end


% mm1=length(mm);
% for i=1:length(mm1)
%     if mm(i)==C3
%        mm(i)=[];
%     end
% end
% 
% 
% if length(mm)==length(mm1)
%     disp('found');
% else
%     disp('none of above');
% end
%         
        %         

  
% A1 = istrprop(C2, 'digit'); 