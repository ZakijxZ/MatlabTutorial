%% ������������ָ�ʽ��ͼƬ
format={'jpg','png','bmp','emf','pbm','pgm','ppm','tiff','pdf'};%����Ŀ���ʽ
name='demo';
for i=1:length(format)
    saveas(get_param(gcs,'handle'),name,format(i));
end
