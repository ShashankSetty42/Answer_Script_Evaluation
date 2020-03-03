function lines_extracted = proj_prof(img, thrshld)
%Line segmentation based on  projection profiles.
%lines will be returned in cell array format, the function takes an input
%image and the threshold, if threshold is not provided the mean will be
%used. The plot of the projections will also be shown for the purpose of
%changing the threshold in case the mean gives poor results.

[rows cols dim] = size(img);

if (dim == 3)
    img=rgb2gray(img);
end

%binarize the image to logical format - comment this out if your image is
%already logical
binary_image = img;


%create the projection profiles
verticalProfile = sum(binary_image, 2);

%plot it to get an idea of the threshold to use
plot(verticalProfile, 'r');
grid on;

if (nargin<2)
    proj_mean = mean(verticalProfile);
    lines = verticalProfile < proj_mean;
else
    lines = verticalProfile < thrshld;
end

upper = find(diff(lines) == 1);
lower = find(diff(lines) == -1);

%now find and extract the lines
lines_extracted = cell(length(upper),1);
for k = 1 : length(upper)
    aa = upper(k);
    bb = lower(k);
    lines_extracted{k} = img(aa:bb, :);
end

