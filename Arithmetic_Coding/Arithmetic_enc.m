%% ARITHMETIC CODING USING THE INCREMENTAL ENCODING TECHNIQUE.

function[Tag_bits]=Arithmetic_enc(sym,p,seq)
tic;  % TIC-TOC commands are used to measure the simulation time of the program.
format long g;
%% ARGUMENTS OF THE FUNCTION
% SYM is a string of symbols of information from the source.
% P represents the array of Probabilities of the corresponding symbols in
% the SYM string.
% SEQ is the string of sequence of symbols to be encoded by arithmetic
% coding.

% if(length(sym)==length(p) && sum(p)==1)  
if(length(sym)==length(p))  
    %% ALGORITHM IMPLEMENTATION
    
    % Calculate the Symbol Intervals.
    Fx=zeros(1,length(sym));
    for i=1:length(sym)
        if i==1
            Fx(i)=p(i);
        else
            Fx(i)=Fx(i-1)+p(i);
        end
    end
    
    % Encoding the Sequence of Symbols. 
    L=0;U=1; % Initial Lower and Upper Intervals.
    Tag_bits=zeros(1,0); % Initializing the Tag Bits.
    for i=1:length(seq)
        j=find(seq(i)==sym);   % Finds the Index of the sequence symbol in the symbol string.
        if(j==1)
            L_new=L;
        else
            L_new=L+(U-L)*Fx(j-1);
        end
        U_new=L+(U-L)*Fx(j);
        L=L_new;
        U=U_new;
        while((L<0.5 && U<0.5) ||(L>=0.5 && U>0.5))
            if(L<0.5 && U<0.5)
                Tag_bits=[Tag_bits,'0'];
                L=2*L;
                U=2*U;
            else
                Tag_bits=[Tag_bits,'1'];
                L=2*(L-0.5);
                U=2*(U-0.5);
            end
        end
    end
    tag=(L+U)/2;
    
    % Embedding the Final Tag Value.
    bits=zeros(1,0);
    if(2*tag>1)
        tag=2*tag-1;
        bits=[bits,'1'];
    else
        tag=2*tag;
        bits=[bits,'0'];
    end
    while(bin2dec(bits)/2^length(bits)<L)
        if(2*tag>1)
            tag=2*tag-1;
            bits=[bits,'1'];
        else
            tag=2*tag;
            bits=[bits,'0'];
        end
    end
    Tag_bits=[Tag_bits,bits];
    
    % Padding of zeros is done to keep the TAG BITS size multiple of 16 bits.
    Tag_bits=[Tag_bits,dec2bin(0,16-rem(length(Tag_bits),16))];
    display('Tag Value is:');
    disp(bin2dec(Tag_bits)/2^length(Tag_bits));
    display('Tag Word is:');
    Tag_bits=[Tag_bits,dec2bin(length(seq),16)];
else
    display('Plese enter proper values!!!');
end
toc;