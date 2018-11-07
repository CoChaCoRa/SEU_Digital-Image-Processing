function  [result]  = Correlation(a,b)
%传入参数为二维矩阵a和b，a为匹配区域，b为滤波器

%获取a，b尺寸参数
[M,N]=size(a);
m=1:M;
n=1:N;
[M0,N0]=size(b);
p=1:M0;
q=1:N0;
%对矩阵a进行扩充，用0填充空白区域
f=zeros(M+2*(M0-1),N+2*(N0-1));
f(m+M0-1,n+N0-1)=a;

result=zeros(M+M0-1,N+N0-1);
for i=1:M+M0-1
    for j=1:N+N0-1
        wkl=zeros(size(f));
        wkl(i+p-1,j+q-1)=b;%滤波器扫过图像
        result(i,j)=sum(sum(f.*conj(wkl)));%将当前区域的图像像素值与滤波器相乘并求和
    end
end
end

