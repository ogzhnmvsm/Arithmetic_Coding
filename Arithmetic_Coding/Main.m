clc;
clear;
alldata = fileread('metin.txt');  
[symbols, ~, seq] = unique( alldata ) ;
counts = accumarray( seq, 1 ) ;
sum_p = sum(counts);
p = (counts./sum_p); 
[sym, b, c] = unique( seq );
text = [];

% Arithmetic_enc(sym,p,seq);
tag = Arithmetic_enc(sym,p,seq);

% Arithmetic_dec(sym,p,tagword)
decoded_text = Arithmetic_dec(sym,p,tag);
for i = 1:length(decoded_text)
    text = [text, symbols(decoded_text(i))];
end




% Symbols = 'abc' -- alfabe
% counts  = [2 ; 3 ; 2] -- geçme sayýsý
% p       = [0.2 ; 0.5 ; 0.3] -- olasýlýk
% tag = arithenco(symbol_idx,counts);

