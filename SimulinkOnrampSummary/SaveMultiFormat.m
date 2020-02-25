%% 用批量保存多种格式的图片
format={'jpg','png','bmp','emf','pbm','pgm','ppm','tiff','pdf'};%多种目标格式
name='demo';
for i=1:length(format)
    saveas(get_param(gcs,'handle'),name,format(i));
end
