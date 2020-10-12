SYMS_T=[1+0i -1+0i 0+1i 0-1i];
scatterplot(SYMS_T);
title('SYMS TRANSMIT')
idx=1:100:6576000;
b2=reshape(SYMS_RECEIVE{5,1},1,6576000);
scatterplot(b2(idx));
title('SYMS RECEIVE(2dB)')
b9=reshape(SYMS_RECEIVE{13,1},1,6576000);
scatterplot(b9(idx));
title('SYMS RECEIVE(9dB)')
b15=reshape(SYMS_RECEIVE{16,1},1,6576000);
scatterplot(b15(idx));
title('SYMS RECEIVE(15dB)')