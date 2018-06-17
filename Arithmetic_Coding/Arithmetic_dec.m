%% ARITHMETIC DECODING 
function[decoded_text]=Arithmetic_dec(sym,p,tagword)
tic;  % TIC-TOC commands are used to measure the simulation time of the program.
format long g;
%% ARGUMENTS OF THE FUNCTION
% SYM is a string of symbols of information from the source.
% P represents the array of Probabilities of the corresponding symbols in
% the SYM string.
% TAGWORD is the bit-string that represents the tag value encoded by arithmetic coding.
% if(length(sym)==length(p) && sum(p)==1)
if(length(sym)==length(p))
    %% ALOGIRTHM IMPLEMENTATION
    
    % Calculating the Symbol Intervals.
    Fx=zeros(1,length(sym));
    for i=1:length(sym)
        if i==1
            Fx(i)=p(i);
        else
            Fx(i)=Fx(i-1)+p(i);
        end
    end
    
    % Extracting the length of sequence from the TAG WORD.
    seq_len=bin2dec(tagword(length(tagword)-15:length(tagword)));
    
    % Decoding the symbols.
    disp('The decoded sequence is:');
    L=0;U=1;  % Initial Lower and Upper Limits of the Interval.
    tagvalue=bin2dec(tagword)/2^length(tagword);
    decoded_text = [];
    for i=1:seq_len
        for j=1:length(sym)
            if(Fx(j)>(tagvalue-L)/(U-L))
%                 disp(j);
                decoded_text = [decoded_text, sym(j)];
%                 fprintf('%s',sym(j));
                if j==1
                    L_new=L;
                else
                    L_new=L+(U-L)*Fx(j-1);
                end
                U_new=L+(U-L)*Fx(j);
                break;
            end
        end
        L=L_new;
        U=U_new;
    end
end
toc;