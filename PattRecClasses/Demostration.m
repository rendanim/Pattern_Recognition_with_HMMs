disp('Welcome to the Handwritten Calculator! Remember to end with "="!')

temp = [];
num=['1','2','3','4','5','6','7','8','9','0','+','-','*','/'];
load('./HMM/HMM40_state5_pseudo0.5.mat')
while true
    Input = {DrawCharacter(10)};
    lInput = logprob(hmm(:,3), Feature_Exreaction(Input));
    pInput=find(lInput == max(lInput));
    if pInput < 15
        temp = [temp, num(pInput)];
    elseif pInput == 15
        break
    end
end

ansr = inline(temp);
h = msgbox([temp,' = ',num2str(ansr(1))],'Calculator');
set(h, 'position', [440 440 200 100]); 
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 20 );


