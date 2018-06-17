% ARÝTMETÝK KODLAMA ILE METIN KODLAMA
clc;
clear;
fprintf('******** ARÝTMETÝK KODLAMA ILE METIN KODLAMA ********** \n\n');
%% Metni Okuma
alldata = fileread('metin.txt');

%% Deðiþkenleri Hesaplama
[symbols, ~, seq] = unique( alldata ) ;
counts = accumarray( seq, 1 ) ;
sum_p = sum(counts);
p = (counts./sum_p); 
[sym, b, c] = unique( seq );
text = [];

fprintf('Okunan Metin : ');
fprintf('%s\n\n\n',alldata);

%% Aritmetik Kodlama - Encryption
fprintf('****** TAG ******\n\n');
enco = arithenco(seq, counts);
disp(enco');

%% Aritmetik Kodlama - Decryption
fprintf('****** DECRYPTED TEXT(Index) ********\n\n');
deco  = arithdeco(enco,counts, sum_p); 
disp(deco');

%% Çözülmüþ Metnin Tokenize Edilmesi(Index to Char)
fprintf('****** DECRYPTED TEXT(Char) ********\n\n');
for i = 1:length(deco)
    text = [text, symbols(deco(i))];
end
fprintf('Decrypted Text : %s\n',text);
fprintf('Okunan Metin   : ');
fprintf('%s\n\n\n',alldata);
