% AR�TMET�K KODLAMA ILE RESIM KODLAMA

%% Resmi okuma
% img = imread('Lena.bmp'); % Read an image Lena 512*512 to original variable
img = imgetfile;
img = imread(img);

subplot(2, 3, 1); 
imshow(img, []);
title('Original Image');

%% Olas�l�klar� Hesaplama
occ=zeros(1,256);
img_vector = img(:) + 1;
for i=1:size(img,1)
    for j=1:size(img,2)
        pixel_value = double(img(i,j));
        index = pixel_value + 1;
        occ(1, index) = occ(1, index) + 1;
    end
end

for i=1:size(occ,2)
    if occ(i) == 0
        occ(i) = 1;
    end
end
ta=tabulate(img_vector); % 3 kolon i�erir. Sembol | Ka� Kez Ge�ti�i | Olas�l���
count=ta(:,2); %Ge�me Say�lar�n�n Tutuldu�u De�i�ken

%% Aritmetik Kodlama ile Kodlanan Verinin �izimi
enco = arithenco(img_vector, occ);
m = vec2mat(enco,floor(sqrt(1951873)));
img2 = mat2gray(m);
subplot(2, 3, 2); 
imshow(img2, []);
title('Encoded Image');

%% Aritmetik Kodlanm�� Verinin ��z�lm�� Halinin �izimi
deco  = arithdeco(enco,occ,262144); 
m = vec2mat(deco,512);
img3 = mat2gray(m);
subplot(2, 3, 3); 
imshow(img3', []);
title('Decoded Image');
flag = isequal(img_vector,deco); 