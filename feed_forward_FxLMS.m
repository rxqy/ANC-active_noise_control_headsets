tic;
T = 1000;
xn = rand(1,T);          % random white noise

num_coeff = 10;
Sz =  rand(1,num_coeff); % assume Sz' == Sz
Sz_hat = Sz;             % random Sz 

Pz = rand(1,num_coeff);  % random Pz
dn = filter(Pz,1,xn);    % desired signal

xntemp = zeros(1,num_coeff);
yntemp = zeros(1,num_coeff);
%Wz = rand(1,num_coeff);
Wz = zeros(1,num_coeff);
err = zeros(1,T);
total_err = zeros(1,T);

% mu = 0.01;
% for k = 1:T
%     xntemp = [xn(k), xntemp(1:num_coeff-1)];
%     %yn_hat = sum(xntemp.*Wz.*Sz);
%     yn = xntemp*Wz';
%     yntemp = [yn,yntemp(1:num_coeff-1)];
%     yn_hat = yntemp*Wz';
%     err(k) = dn(k) - yn_hat;
% 
%     
%     xn_hat=  xntemp.*Sz_hat;
%     Wz =  Wz + mu/norm(xn_hat,2)*err(k)*xn_hat;
%     %Wz =  Wz + mu*err(k)*xn_hat;
% end

mu = 0.005;
for k = 1:T
    xntemp = [xn(k), xntemp(1:num_coeff-1)];
    %yn_hat = sum(xntemp.*Wz.*Sz);
    yn = filter(Wz,1,xn);
    yn_hat = filter(Sz,1,yn);
    err(k) = dn(k) - yn_hat(k);

    total_err(k) = sum(dn-yn_hat); 
    xn_hat=  xntemp.*Sz_hat;
    Wz =  Wz + mu/norm(xn_hat,2)*err(k)*xn_hat;
    %Wz =  Wz + mu*err(k)*xn_hat;
end

yn_res = filter(Sz,1, filter(Wz,1,xn));
plot(dn(1:500),'k');
hold on;
plot(yn_res(1:500),'r');
%sum(yn_res-dn);
figure;
plot(total_err,'k')
% figure;
% plot(dn(1:500)-yn_res(1:500),'k')
toc