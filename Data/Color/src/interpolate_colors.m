function color_matrix = interpolate_colors(html_colors)
%interpolate_colors Create a colormap by interpolating between HTML colors.
%
%   Color_matrix = interpolate_colors(html_colors)
%
%   Input
%       html_colors - A cell array of HTML color strings.
%       
%   Output
%       color_matrix - A 256-by-3 matrix of RGB colors.
%

    rgb_colors = zeros(length(html_colors), 3);
    for i = 1:length(html_colors)
        rgb_colors(i, :) = hex2rgb(html_colors{i});
    end
    color_matrix = interp1(1:length(html_colors), rgb_colors, linspace(1, length(html_colors), 256));
end

function rgb = hex2rgb(hex_color)
    hex_color = hex_color(2:end);
    r = hex2dec(hex_color(1:2)) / 255;
    g = hex2dec(hex_color(3:4)) / 255;
    b = hex2dec(hex_color(5:6)) / 255;
    rgb = [r, g, b];
end
