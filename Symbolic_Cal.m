clear;clc;
% 导入符号工具箱
syms s
syms G_deltas_dpsi_des_stat T_psi omega_e D

% 定义符号传递函数 H(s) = (s+2) / (s^2 + 3*s + 2)
numerator = 1 + T_psi*s;
denominator = 1 + 2*D/omega_e * s + 1/omega_e^2*s^2;
H_s1 = G_deltas_dpsi_des_stat * numerator / denominator;

syms v_x l_R l_F m I_zz C_alphaF C_alphaR

v_char2 = C_alphaF*C_alphaR*l_R^2/(m*(C_alphaR*l_R-C_alphaF*l_F));
l = l_F+l_R;
T = (m*v_x*l_F)/(C_alphaR*l);
omega = sqrt((C_alphaF*C_alphaR*l^2+m*v_x^2*(C_alphaR*l_R-C_alphaF*l_F))/(I_zz*m*(v_x)^2));
D0 = (m*(C_alphaF*l_F^2+C_alphaR*l_R^2)+I_zz*(C_alphaF+C_alphaR))/(2*I_zz*m*(v_x))/omega;

G_deltas_dpsi_stat0     = v_x/(l*(1+v_x^2/v_char2));

numerator2 = 1 + T*s;
denominator2 = 1 + 2*D0/omega * s + 1/omega^2*s^2;
H_s2 = G_deltas_dpsi_stat0 * numerator2 / denominator2;

H_s3 = (1+s+s)/denominator2;

H_s = (H_s1-H_s2)/H_s3;

% 显示传递函数
H_s_simplified = simplify(H_s);
[numerator, denominator] = numden(H_s_simplified);

% 展开分子和分母
expanded_numerator = expand(numerator);
expanded_denominator = expand(denominator);

% 提取分子中s的系数
numerator_coeffs = coeffs(expanded_numerator, s);

% 提取分母中s的系数
denominator_coeffs = coeffs(expanded_denominator, s);

disp('Numerator Coefficients:')
disp(numerator_coeffs)

disp('Denominator Coefficients:')
disp(denominator_coeffs)
