%彩色图像直方图匹配matlab
clear
I=imread('car.jpg');%读取图像
Imatch=imread('starsky.jpg');%读取匹配图像
R=I(:,:,1);%获取原图像R通道
G=I(:,:,2);%获取原图像G通道
B=I(:,:,3);%获取原图像B通道
R_hist=imhist(R);%获取原图像R通道直方图
G_hist=imhist(G);%获取原图像G通道直方图
B_hist=imhist(B);%获取原图像B通道直方图
Rmatch=Imatch(:,:,1);%获取匹配图像R通道
Gmatch=Imatch(:,:,2);%获取匹配图像G通道
Bmatch=Imatch(:,:,3);%获取匹配图像B通道
Rmatch_hist=imhist(Rmatch);%获取匹配图像R通道直方图
Gmatch_hist=imhist(Gmatch);%获取匹配图像G通道直方图
Bmatch_hist=imhist(Bmatch);%获取匹配图像B通道直方图

cdf= cumsum(R_hist) / numel(R); 
cdfRef= cumsum(Rmatch_hist) / numel(Rmatch);
% Compute the mapping
M   = zeros(1,256);
for idx = 1 : 256
    [tmp,ind] = min(abs(cdf(idx) - cdfRef));
    M(idx) = ind-1;
end
Rout = M(double(R)+1);

cdf= cumsum(G_hist) / numel(G); 
cdfRef= cumsum(Gmatch_hist) / numel(Gmatch);
% Compute the mapping
M   = zeros(1,256);
for idx = 1 : 256
    [tmp,ind] = min(abs(cdf(idx) - cdfRef));
    M(idx) = ind-1;
end
Gout = M(double(G)+1);

cdf= cumsum(B_hist) / numel(B); 
cdfRef= cumsum(Bmatch_hist) / numel(Bmatch);
% Compute the mapping
M   = zeros(1,256);
for idx = 1 : 256
    [tmp,ind] = min(abs(cdf(idx) - cdfRef));
    M(idx)= ind-1;
end
Bout = M(double(B)+1);

J(:,:,1)=Rout;
J(:,:,2)=Gout;
J(:,:,3)=Bout;
figure;%显示原图像、匹配图像和匹配后的图像
subplot(1,3,1),imshow(I);title('原图像');
subplot(1,3,2),imshow(Imatch);title('匹配图像');
subplot(1,3,3),imshow(J);title('匹配之后图像');
figure;%显示原图像、匹配图像和匹配后图像的直方图
subplot(3,3,1),imhist(R,64);ylabel('原图像R通道直方图');
subplot(3,3,2),imhist(G,64);ylabel('原图像G通道直方图');
subplot(3,3,3),imhist(B,64);ylabel('原图像B通道直方图');

subplot(3,3,4),imhist(Rmatch,64);ylabel('匹配图像R通道直方图');
subplot(3,3,5),imhist(Gmatch,64);ylabel('匹配图像G通道直方图');
subplot(3,3,6),imhist(Bmatch,64);ylabel('匹配图像B通道直方图');
 
subplot(3,3,7),imhist(Rout,64);ylabel('匹配之后图像R通道直方图');
subplot(3,3,8),imhist(Gout,64);ylabel('匹配之后图像G通道直方图');
subplot(3,3,9),imhist(Bout,64);ylabel('匹配之后图像B通道直方图');
