clear;
RESOURCE=imread('E:\picture\test.png');
resource=rgb2gray(RESOURCE);
TEMPLATE=imread('E:\picture\template.png');
template=rgb2gray(TEMPLATE);

[m,n]=size(resource);
[m0,n0]=size(template);
%原图中白色灰度值为255黑色为0，计算出的最大值并不是想要的最大相关位置
%因此需要将图像进行反转
resource_inversion=255-resource;
template_inversion=255-template;

%滤波器移过图像并计算每个位置乘积之和，即求相关
result=Correlation(resource_inversion,template_inversion);
%找到最大相关位置坐标
[iMaxPos,jMaxPos]=find( result==max( result(:)));

figure,
subplot(121);imshow(TEMPLATE),title('匹配模板子图像');
subplot(122);imshow(RESOURCE),title('标记出匹配区域的原图');
hold on
plot(jMaxPos,iMaxPos,'*');%绘制最大相关点
%用矩形框标记出匹配区域，最大相关点为匹配区域右下角
plot([jMaxPos,jMaxPos-n0+1],[iMaxPos,iMaxPos]);
plot([jMaxPos-n0+1,jMaxPos-n0+1],[iMaxPos,iMaxPos-m0+1]);
plot([jMaxPos,jMaxPos-n0+1],[iMaxPos-m0+1,iMaxPos-m0+1]);
plot([jMaxPos,jMaxPos],[iMaxPos,iMaxPos-m0+1]);
