html_colors = {'#E6E6F0', '#DBC6D9', '#D4A7C4','#D48CB1','#9F6693','#765985','34F3E6A','#2E214D'}; 

color_matrix = interpolate_colors(html_colors);

dlmwrite('output.txt', color_matrix, 'delimiter', '\t');