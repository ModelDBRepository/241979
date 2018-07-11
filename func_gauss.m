function yy=func_gauss (maxval, dist, sig)
yy = maxval.*exp(- (dist.*dist)/(2.*sig.*sig));
end