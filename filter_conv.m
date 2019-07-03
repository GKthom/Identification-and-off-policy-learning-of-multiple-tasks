function [conv_rates_filtered_avg]=filter_conv(conv_rates)
s=size(conv_rates);
for i=1:s(2)
    conv_rates_filtered=conv_rates(:,i);
    conv_rates_filtered(conv_rates_filtered==1000)=[];
    conv_rates_filtered_avg(i)=mean(conv_rates_filtered);
end