clear;                   
[A,map]=imread('E:\picture\test.jpg');                
X=rgb2gray(A);  
%画出原始图像  
subplot(2,2,1);imshow(X);
title('原始图像');  
%产生含噪图像  
x=imnoise(X ,'gaussian',0,0.03);
%画出含噪图像  
subplot(2,2,2);imshow(x);  
title('含噪声图像');  
%下面进行图像的去噪处理  
%用小波函数sym4对x进行2层小波分解  
[c,s]=wavedec2(x,2,'sym4');  
%提取小波分解中第一层的低频图像，即实现了低通滤波去噪  
a1=wrcoef2('a',c,s,'sym4');  % a1为 double 型数据；
%画出去噪后的图像  
subplot(2,2,3); imshow(uint8(a1)); % 注意 imshow()和image()显示图像有区别，imshow()不能显示 double 型数据，必须进行转换 uint8(a1)；
title('第一次去噪图像');           % 并且image() 显示图像有坐标；
%提取小波分解中第二层的低频图像，即实现了低通滤波去噪  
%相当于把第一层的低频图像经过再一次的低频滤波处理  
a2=wrcoef2('a',c,s,'sym4',2);  
%画出去噪后的图像  
subplot(2,2,4); imshow(uint8(a2)); %image(a2);
title('第二次去噪图像');
%保存图像  
imwrite(x,'E:\picture\2.jpg');
imwrite(uint8(a1),'E:\picture\3.jpg'); %imwrite()保存图像，也需要将数据类型转化为uint8
imwrite(uint8(a2),'E:\picture\4.jpg');